//
//  TYPanelBaseViewController.h
//  TuyaSmartKitDemo
//
//  Created by 冯晓 on 16/8/30.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TYPanelBaseViewController.h"

@interface TYPanelBaseDeviceViewController : TYPanelBaseViewController <TuyaSmartDeviceDelegate>

@property (nonatomic, strong) NSString *devId;

@property (nonatomic, strong) TuyaSmartDevice *device;

@end
