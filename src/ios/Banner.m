/*
 * cordova-banner-notification
 * Created By David Briglio - 2016
 * https://github.com/DavidBriglio/cordova-banner-notification
 * Created under the MIT License.
 *
 */

#import "Banner.h"
#import <Cordova/CDVPlugin.h>
#import "CWStatusBarNotification.h"

@implementation Banner

//Show a banner notification
- (void)show:(CDVInvokedUrlCommand*)command
{
    NSDictionary* options = [command.arguments objectAtIndex:0];

    CWStatusBarNotification *notification = [CWStatusBarNotification new];

    //Return if there were no arguments passed in
    if(options == nil) {
        return;
    }

    NSString* message = [options objectForKey:@"message"];
    double duration = [[options objectForKey:@"duration"] doubleValue];
    NSString *styleStr = [options objectForKey:@"style"];
    NSString *animationInStr = [options objectForKey:@"animationIn"];
    NSString *animationOutStr = [options objectForKey:@"animationOut"];
    NSDictionary *backColor = [options objectForKey:@"backcolor"];
    NSDictionary *textColor = [options objectForKey:@"textcolor"];
    notification.notificationStyle = CWNotificationStyleNavigationBarNotification;
    notification.notificationAnimationInStyle = CWNotificationAnimationStyleTop;
    notification.notificationAnimationOutStyle = CWNotificationAnimationStyleTop;

    if(!message){
        message = @"New Notification";
    }

    if(!duration) {
        duration = 3.0;
    }

    if(styleStr){
        if([styleStr isEqualToString:@"small"]) {
            notification.notificationStyle = CWNotificationStyleStatusBarNotification;
        }
    }

    if(animationInStr){
        notification.notificationAnimationInStyle = [self getAnimation:animationInStr];
    }

    if(animationOutStr){
        notification.notificationAnimationOutStyle = [self getAnimation:animationOutStr];
    }

    if(backColor) {
        notification.notificationLabelBackgroundColor = [self getColor:backColor];
    }

    if(textColor) {
        notification.notificationLabelTextColor = [self getColor:textColor];
    }

    //Weak reference to be able to dismiss the notification in the handler
    __weak CWStatusBarNotification *weakSelf = notification;

    notification.notificationTappedBlock = ^(void) {

       //Clear the notification
       if(!weakSelf.notificationIsDismissing){
           [weakSelf dismissNotification];
       }
       [self.commandDelegate runInBackground:^{

           //Execute the callback, passing in the notification options as a parameter
           NSError *error;
           NSData *json = [NSJSONSerialization dataWithJSONObject:options options:0 error:&error];
           NSString *optionStr = [[NSString alloc] initWithData:json encoding:NSUTF8StringEncoding];
           NSString *js = [NSString stringWithFormat:@"cordova.plugins.notification.banner.__click(%@)",optionStr];
           [self.commandDelegate evalJs:js];

       }];
    };

    [notification displayNotificationWithMessage:message
                                     forDuration:duration];
}

//Get UIColor from {red:255, green:255, blue:255} format dictionary
- (UIColor *)getColor:(NSDictionary *)colorDict
{
    int red = [[colorDict objectForKey:@"red"] integerValue];
    int green = [[colorDict objectForKey:@"green"] integerValue];
    int blue = [[colorDict objectForKey:@"blue"] integerValue];

    if(!red)
    {
        red = 0;
    }

    if(!green)
    {
        green = 0;
    }

    if(!blue)
    {
        blue = 0;
    }

    return [UIColor colorWithRed:red/255.0
                           green:green/255.0
                            blue:blue/255.0
                           alpha:1.0]; //alpha is left at 1.0 because any other value looks bad with animation
}

//Get the integer code for the animation style from string 'top'/'bottom'/'right'/'left'
- (NSInteger)getAnimation:(NSString *)styleStr
{
    //Default to top
    NSInteger animation = CWNotificationAnimationStyleTop;

    if([styleStr isEqualToString:@"bottom"]){
        animation = CWNotificationAnimationStyleBottom;
    }
    else if([styleStr isEqualToString:@"left"]){
        animation = CWNotificationAnimationStyleLeft;
    }
    else if([styleStr isEqualToString:@"right"]){
        animation = CWNotificationAnimationStyleRight;
    }

    return animation;
}


@end