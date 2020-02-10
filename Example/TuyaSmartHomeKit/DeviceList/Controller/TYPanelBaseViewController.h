//
//  TYPanelBaseViewController.h
//  TuyaSmartKitDemo
//
//  Created by 冯晓 on 16/8/30.
//  Copyright © 2016年 Tuya. All rights reserved.
//

@interface TYPanelBaseViewController : TPBaseViewController <TuyaSmartDeviceDelegate>

@property (nonatomic, strong) NSString *devId;
@property (nonatomic, strong) NSString *groupId;

@property (nonatomic, strong) TuyaSmartDevice *device;
@property (nonatomic, strong) TuyaSmartGroup *group;

- (void)updateOfflineView;

@end
