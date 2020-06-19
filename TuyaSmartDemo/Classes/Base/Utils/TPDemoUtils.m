//
//  TPUtils.m
//  TYLibraryExample
//
//  Created by 冯晓 on 16/2/16.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TPDemoUtils.h"
#import <Reachability/Reachability.h>
#import <SystemConfiguration/CaptiveNetwork.h>
#import <AudioToolbox/AudioToolbox.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import <CoreLocation/CoreLocation.h>

inline CGFloat TYSDK_ScreenWidth(void) {
    return [UIScreen mainScreen].bounds.size.width;
}

UIWindow *tp_mainWindow() {
    id appDelegate = [UIApplication sharedApplication].delegate;
    if (appDelegate && [appDelegate respondsToSelector:@selector(window)]) {
        return [appDelegate window];
    }
    
    NSArray *windows = [UIApplication sharedApplication].windows;
    if ([windows count] == 1) {
        return [windows firstObject];
    }
    else {
        for (UIWindow *window in windows) {
            if (window.windowLevel == UIWindowLevelNormal) {
                return window;
            }
        }
    }
    return nil;
}

UIViewController *tp_topMostViewController() {
    UIViewController *topViewController = tp_mainWindow().rootViewController;
    UIViewController *temp = nil;
    
    while (YES) {
        temp = nil;
        if ([topViewController isKindOfClass:[UINavigationController class]]) {
            temp = ((UINavigationController *)topViewController).visibleViewController;
            
        } else if ([topViewController isKindOfClass:[UITabBarController class]]) {
            temp = ((UITabBarController *)topViewController).selectedViewController;
        }
        else if (topViewController.presentedViewController != nil) {
            temp = topViewController.presentedViewController;
        }
        
        if (temp != nil) {
            topViewController = temp;
        } else {
            break;
        }
    }
    
    return topViewController;
}

UINavigationController *tp_mainNavigationController() {
    return (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
}

@implementation TPDemoUtils

// App-Prefs:root=xxx 过机审需要字符串加密
+ (NSURL *)prefsUrlWithQuery:(NSDictionary *)query {
    // App-Prefs
    NSData *data = [[NSData alloc] initWithBase64EncodedString:@"QXBwLVByZWZz" options:0];
    NSString *scheme = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSMutableString *url = [NSMutableString stringWithString:scheme];
    for (int i = 0; i < query.allKeys.count; i ++) {
        NSString *key = [query.allKeys objectAtIndex:i];
        NSString *value = [query valueForKey:key];
        [url appendFormat:@"%@%@=%@", (i == 0 ? @":" : @"?"), key, value];
    }
    return [NSURL URLWithString:url];
}

+ (NSURL *)wifiSettingUrl {
    // App-Prefs:root=WIFI
    return [self prefsUrlWithQuery:@{@"root": @"WIFI"}];
}

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+ (id)fetchSSIDInfo {
    NSArray *ifs = (__bridge_transfer id)CNCopySupportedInterfaces();
    id info = nil;
    for (NSString *ifnam in ifs) {
        info = (__bridge_transfer id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        if (info && [info count]) {
            break;
        }
    }
    return info;
}

+ (NSString *)currentWifiSSID {
    NSDictionary *info = [self fetchSSIDInfo];
    
    NSString *ssid = nil;
    if (info[@"SSID"]) {
        ssid = info[@"SSID"];
    }
    return ssid;
}

+ (NSString *)currentWifiBSSID {
    NSDictionary *info = [self fetchSSIDInfo];
    
    NSString *bssid = nil;
    if (info[@"BSSID"]) {
        bssid = info[@"BSSID"];
    }
    return bssid;
}

+ (NSString *)getAppleLanguages {
    return [[NSLocale preferredLanguages] objectAtIndex:0];
}

+ (NSString *)getLanguageCode {
    NSString *lang = [[TPDemoUtils getAppleLanguages] lowercaseString];
    
    if ([lang hasPrefix:[@"zh-Hans" lowercaseString]]) {
        return @"zh";
    } else if ([lang hasPrefix:[@"zh-Hant" lowercaseString]]) {
        return @"tw";
    }
    
    NSArray *list = [lang componentsSeparatedByString:@"-"];
  
    NSString *code = list.firstObject;
    return code;
}

+ (BOOL)isChinese {
    NSString *lang = [[TPDemoUtils getAppleLanguages] lowercaseString];
    
    if ([lang hasPrefix:[@"zh-Hans" lowercaseString]] || [lang hasPrefix:[@"zh-Hant" lowercaseString]]) {
        return YES;
    }
    
    return NO;
}

+ (UIImage *)imageNamedLocalize:(NSString *)imageName {
    NSString *newImageName;
    if ([TPDemoUtils isChinese]) {
        newImageName = [NSString stringWithFormat:@"%@_cn",imageName];
    } else {
        newImageName = [NSString stringWithFormat:@"%@_en",imageName];
    }
    return [UIImage imageNamed:newImageName];
}

+ (float)batteryLevel {
    UIDevice *device = [UIDevice currentDevice];
    device.batteryMonitoringEnabled = YES;
    
    return device.batteryLevel;
}

+ (NSString *)timeZone {
    NSTimeZone *zone = [NSTimeZone defaultTimeZone];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"xxx"];//+08:00 (OS X 10.9+ & iOS 7+)
    [formatter setTimeZone:zone];
    NSString *locationString = [formatter stringFromDate:[NSDate date]];
    
    return locationString;
}

+ (NSString *)timeZoneWithName:(NSString *)name {
    NSTimeZone *zone = [NSTimeZone timeZoneWithName:name];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"xxx"];//+08:00 (OS X 10.9+ & iOS 7+)
    [formatter setTimeZone:zone];
    NSString *locationString = [formatter stringFromDate:[NSDate date]];
    
    return locationString;
}

+ (NSString *)timeZoneName {
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    NSString *tzName = [timeZone name];
    return tzName;
}

+ (BOOL)isEmptyString:(NSString *)string {
    return (string == nil || [string isEqualToString:@""]);
}

+ (NSString *)stringFromBool:(BOOL)b {
    return  [NSString stringWithFormat: @"%d", (b ? 1 : 0)];
}

+ (NSString *)stringFromInteger:(NSInteger)integer {
    return  [NSString stringWithFormat: @"%ld", (long)integer];
}

+ (void)playSystemSound {
    static SystemSoundID soundIDTest = 0;
    NSString *path = @"/System/Library/Audio/UISounds/new-mail.caf";
    if (path) {
        //注册声音到系统
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path],&soundIDTest);
        AudioServicesPlaySystemSound(soundIDTest);
    }
}

+ (void)playSystemSoundVibrate {
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

+ (BOOL)IsEnableWIFI {
    Reachability *r = [Reachability reachabilityForInternetConnection];
    return [r currentReachabilityStatus] == ReachableViaWiFi;
}

+ (BOOL)IsEnableInternet {
    Reachability *r = [Reachability reachabilityForInternetConnection];
    return [r currentReachabilityStatus] != NotReachable;
}

+ (NSString *)networkType {
    Reachability *r = [Reachability reachabilityForInternetConnection];
    if ([r currentReachabilityStatus] == ReachableViaWiFi) {
        return @"wifi";
    } else if ([r currentReachabilityStatus] == ReachableViaWWAN) {
        return @"gprs";
    } else {
        return @"none";
    }
}


+ (BOOL)isEnabledNotification {
    
    UIApplication *application = [UIApplication sharedApplication];
    
    BOOL enabled;
    
    // Try to use the newer isRegisteredForRemoteNotifications otherwise use the enabledRemoteNotificationTypes.
    if ([application respondsToSelector:@selector(isRegisteredForRemoteNotifications)])
    {
        enabled = [application isRegisteredForRemoteNotifications];
    }
    else
    {
        UIRemoteNotificationType types = [application enabledRemoteNotificationTypes];
//        enabled = types & UIRemoteNotificationTypeAlert;
        enabled = types != UIRemoteNotificationTypeNone;
    }
    
    return enabled;
}


+ (UIImage *)getShotWithView:(UIView *)view {
    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, 0.0);
    
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


+ (NSString *)getISOcountryCode {
    NSString *ISOcountryCode;
    
    CTTelephonyNetworkInfo *network_Info = [CTTelephonyNetworkInfo new];
    CTCarrier *carrier = network_Info.subscriberCellularProvider;
    ISOcountryCode = carrier.isoCountryCode;
    
    if (ISOcountryCode.length == 0) {
        NSLocale *locale = [NSLocale currentLocale];
        ISOcountryCode = [locale objectForKey:NSLocaleCountryCode];
    }
    
    return [ISOcountryCode uppercaseString];
}


+ (void)logByte:(uint8_t *)bytes len:(int)len str:(NSString *)str {
    NSMutableString *tempMStr = [[NSMutableString alloc] init];
   
    for (int i=0;i<len;i++)
        [tempMStr appendFormat:@"%0x ",bytes[i]];
    
    
    NSLog(@"%@ == %@",str,tempMStr);
}

+ (uint32_t)getIntValueByHex:(NSString *)getStr
{
    NSScanner *tempScaner=[[NSScanner alloc] initWithString:getStr];
    uint32_t tempValue;
    [tempScaner scanHexInt:&tempValue];
    return tempValue;
}

+ (NSArray *)getFileNamelistWithType:(NSString *)type dirPath:(NSString *)dirPath {
    NSMutableArray *filenamelist = [NSMutableArray array];
    
    NSDirectoryEnumerator *myDirectoryEnumerator = [[NSFileManager defaultManager] enumeratorAtPath:dirPath];
    NSString *filename = [NSString string];
    while((filename = [myDirectoryEnumerator nextObject]) != nil) {
        NSString *fullpath = [dirPath stringByAppendingPathComponent:filename];
        if ([self isFileExistAtPath:fullpath]) {
            if ([[filename pathExtension] isEqualToString:type]) {
                [filenamelist addObject:fullpath];
            }
        }
    }
    
    return filenamelist;
}

+ (BOOL)isFileExistAtPath:(NSString *)fileFullPath {
    BOOL isExist = NO;
    isExist = [[NSFileManager defaultManager] fileExistsAtPath:fileFullPath];
    return isExist;
}


//摄氏度转换成华氏度
+ (double)convertCelsiusToFahrenheit:(double)temp {
    
    return temp * 1.8f + 32;
    
}

//华氏度转换成摄氏度
+ (double)convertFahrenheitToCelsius:(double)temp {
    
    return (temp - 32) / 1.8f;
    
}

//判断是否开启定位服务
+ (BOOL)isLocationEnable {
    
    if ([CLLocationManager locationServicesEnabled] == NO ||
        [CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied ||
        [CLLocationManager authorizationStatus] == kCLAuthorizationStatusRestricted){
        return NO;
    } else {
        return YES;
    }
}


@end


#pragma mark NSJSONSerialization Category
@implementation NSString (TPJSONKit)

- (id)tp_objectFromJSONString {
    return [self tp_objectFromJSONString:NSJSONReadingAllowFragments error:NULL];
}

- (id)tp_objectFromJSONString:(NSJSONReadingOptions)serializeOptions error:(NSError **)error {
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    id jsonObj = [NSJSONSerialization JSONObjectWithData:jsonData options:serializeOptions error:error];
    return jsonObj;
}

@end

