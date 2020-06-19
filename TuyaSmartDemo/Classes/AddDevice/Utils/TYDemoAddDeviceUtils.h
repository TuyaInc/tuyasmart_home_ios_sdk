//
//  TYAddDeviceUtils.h
//  TuyaSmartHomeKit_Example
//
//  Created by Kennaki Kai on 2018/12/3.
//  Copyright © 2018 xuchengcheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TYDemoAddDeviceUtils : NSObject

+ (instancetype)sharedInstance;

- (UILabel *)keyLabel;

- (UITextField *)textField;

- (void)alertMessage:(NSString *)message;

/*
 * go system to connect wifi
 */
- (void)gotoSettingWifi;

/*
 * get current network status
 */
- (BOOL)currentNetworkStatus;



@end

TYDemoAddDeviceUtils * sharedAddDeviceUtils();

NS_ASSUME_NONNULL_END
