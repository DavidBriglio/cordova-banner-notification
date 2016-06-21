/*
 * cordova-banner-notification
 * Created By David Briglio - 2016
 * https://github.com/DavidBriglio/cordova-banner-notification
 * Created under the MIT License.
 *
 */

#import <Cordova/CDVPlugin.h>

@interface Banner : CDVPlugin

- (void)show:(CDVInvokedUrlCommand*)command;

- (UIColor *)getColor:(NSDictionary *)colorDict defaultColor:(int) defaultColor;

- (NSInteger)getAnimation:(NSString *)styleStr;

@end
