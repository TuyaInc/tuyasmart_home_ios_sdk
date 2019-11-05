//
//  TYDeviceGroupViewController.h
//  TuyaSmartHomeKit_Example
//
//  Created by 温明妍 on 2019/9/11.
//  Copyright © 2019 xuchengcheng. All rights reserved.
//

#import "TPBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@class TuyaSmartDevice;

@interface TYDeviceGroupViewController : TPBaseViewController
// 当前选中的设备
@property (nonatomic, strong) TuyaSmartDevice *device;

@end

NS_ASSUME_NONNULL_END
