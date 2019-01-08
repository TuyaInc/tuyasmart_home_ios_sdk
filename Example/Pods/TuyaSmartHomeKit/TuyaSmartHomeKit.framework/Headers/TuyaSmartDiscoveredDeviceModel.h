//
//  TuyaSmartDiscoveredDeviceModel.h
//  TuyaSmartKit
//
//  Created by 冯晓 on 2017/1/16.
//  Copyright © 2017年 Tuya. All rights reserved.
//


@interface TuyaSmartDiscoveredDeviceModel : TYModel

/// 设备ID
@property (nonatomic, strong) NSString    *devId;
/// 0:未激活 1:激活就绪态 2:已激活
@property (nonatomic, assign) NSInteger   active;


@end
