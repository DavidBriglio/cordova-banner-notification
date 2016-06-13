
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
    
    NSString* message = @"New Notification";
    double duration = 3.0;
    NSInteger style = CWNotificationStyleNavigationBarNotification;
    NSInteger animationIn = CWNotificationAnimationStyleTop;
    NSInteger animationOut = CWNotificationAnimationStyleTop;
    
    if([options objectForKey:@"message"]){
        message = [options objectForKey:@"message"];
    }
    
    if([options objectForKey:@"duration"]) {
        duration = [[options objectForKey:@"duration"] doubleValue];
    }
    
    if([options objectForKey:@"style"]){
        NSString *styleStr = [options objectForKey:@"style"];
        if([styleStr isEqualToString:@"small"]) {
            style = CWNotificationStyleStatusBarNotification;
        }
    }
    
    if([options objectForKey:@"animationIn"]){
        NSString *styleStr = [options objectForKey:@"animationIn"];
        animationIn = [self getAnimation:styleStr];
    }
    
    if([options objectForKey:@"animationOut"]){
        NSString *styleStr = [options objectForKey:@"animationOut"];
        animationOut = [self getAnimation:styleStr];
    }
    
    if([options objectForKey:@"backcolor"]) {
        NSDictionary *color = [options objectForKey:@"backcolor"];
        notification.notificationLabelBackgroundColor = [self getColor:color];
    }
    
    if([options objectForKey:@"textcolor"]) {
        NSDictionary *color = [options objectForKey:@"textcolor"];
        notification.notificationLabelTextColor = [self getColor:color];
    }
    
    notification.notificationStyle = style;
    notification.notificationAnimationInStyle = animationIn;
    notification.notificationAnimationOutStyle = animationOut;
    
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
    double red = 0.0;
    double green = 0.0;
    double blue = 0.0;
    
    if([colorDict objectForKey:@"red"])
    {
        red = [[colorDict objectForKey:@"red"] integerValue]/255.0;
    }
    
    if([colorDict objectForKey:@"green"])
    {
        green = [[colorDict objectForKey:@"green"] integerValue]/255.0;
    }
    
    if([colorDict objectForKey:@"blue"])
    {
        blue = [[colorDict objectForKey:@"blue"] integerValue]/255.0;
    }
    
    return [UIColor colorWithRed:red
                           green:green
                            blue:blue
                           alpha:1.0]; //alpha is left at 1.0 because it looks bad with animation
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