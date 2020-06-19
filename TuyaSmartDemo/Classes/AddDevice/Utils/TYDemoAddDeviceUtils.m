//
//  TYAddDeviceUtils.m
//  TuyaSmartHomeKit_Example
//
//  Created by Kennaki Kai on 2018/12/3.
//  Copyright © 2018 xuchengcheng. All rights reserved.
//

#import "TYDemoAddDeviceUtils.h"
#import "Reachability.h"

#import "TPDemoUtils.h"

TYDemoAddDeviceUtils * sharedAddDeviceUtils() {
    return [TYDemoAddDeviceUtils sharedInstance];
}

@implementation TYDemoAddDeviceUtils
+ (instancetype)sharedInstance {
    
    static TYDemoAddDeviceUtils *sharedUtils = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!sharedUtils) {
            sharedUtils = [self new];
        }
    });
    return sharedUtils;
}

- (UILabel *)keyLabel {
    UILabel *label = [UILabel new];
    label.font = [UIFont systemFontOfSize:16];
    return label;
}

- (UITextField *)textField {
    UITextField *field = [UITextField new];
    field.layer.borderColor = UIColor.blackColor.CGColor;
    field.layer.borderWidth = 1;
    
    return field;
}

- (void)alertMessage:(NSString *)message {
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:message
                                                     message:nil
                                                    delegate:nil
                                           cancelButtonTitle:@"OK"
                                           otherButtonTitles:nil];
    [alert show];
}

- (void)gotoSettingWifi {
    NSURL *url = [TPDemoUtils wifiSettingUrl];
    if (TP_SYSTEM_VERSION < 10.0) {
        [[UIApplication sharedApplication] openURL:url];
    } else {
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL success) {
        }];
    }
}

- (BOOL)currentNetworkStatus {
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    return [reachability currentReachabilityStatus] == ReachableViaWiFi;
}


@end
