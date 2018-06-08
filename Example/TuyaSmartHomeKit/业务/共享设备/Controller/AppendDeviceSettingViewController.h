//
//  AppendDeviceSettingViewController.h
//  TuyaSmart
//
//  Created by fengyu on 15/3/10.
//  Copyright (c) 2015年 Tuya. All rights reserved.
//

#import "TPBaseViewController.h"

@protocol AppendDeviceSettingDelegate <NSObject>

@required
- (void)didSettingSwitch:(UISwitch *)settingSwitch isOn:(BOOL)isOn;

@end

@interface AppendDeviceSettingViewController : TPBaseViewController

@property (nonatomic, assign) BOOL isAutoShare;
@property (nonatomic, weak) id <AppendDeviceSettingDelegate> delegate;

@end
