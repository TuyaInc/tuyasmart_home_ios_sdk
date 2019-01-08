//
//  TuyaSmartShareDeviceModel.h
//  TuyaSmartKitExample
//
//  Created by 冯晓 on 2017/7/15.
//  Copyright © 2017年 tuya. All rights reserved.
//

@interface TuyaSmartShareDeviceModel : NSObject

/**
 *  设备图标地址
 */
@property (nonatomic, strong) NSString *iconUrl;

/**
 *  设备Id
 */
@property (nonatomic, strong) NSString *devId;

/**
 *  名称(设备,群组)
 */
@property (nonatomic, strong) NSString *name;

/**
 *  是否分享
 */
@property (nonatomic, assign) BOOL share;

@property (nonatomic, strong) NSString *roomName;

@property (nonatomic, strong) NSString *homeName;






@end
