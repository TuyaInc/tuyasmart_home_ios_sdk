//
//  TuyaFirmwareUpgradeInfo.h
//  TuyaSmartKit
//
//  Created by fengyu on 15/9/15.
//  Copyright (c) 2015年 Tuya. All rights reserved.
//

#ifndef TuyaSmart_TuyaSmartFirmwareUpgradeModel
#define TuyaSmart_TuyaSmartFirmwareUpgradeModel

#import <Foundation/Foundation.h>

@interface TuyaSmartFirmwareUpgradeModel : NSObject

//升级文案
@property (nonatomic, strong) NSString  *desc;

// 设备类型文案
@property (nonatomic, strong) NSString *typeDesc;

//0:无新版本 1:有新版本 2:在升级中 5:等待设备唤醒
@property (nonatomic, assign) NSInteger upgradeStatus;

//新版本使用的固件版本
@property (nonatomic, strong) NSString  *version;

//当前在使用的固件版本
@property (nonatomic, strong) NSString  *currentVersion;

//升级超时时间（秒）
@property (nonatomic, assign) NSInteger timeout;

//0:app提醒升级 2:app强制升级 3:检测升级
@property (nonatomic, assign) NSInteger upgradeType;

// 设备类型
@property (nonatomic, assign) NSInteger type;

//如果是蓝牙设备的升级，需要使用以下两个字段

//固件的下载URL
@property (nonatomic, strong) NSString *url;

//固件的md5
@property (nonatomic, strong) NSString *md5;

//固件包的size, byte
@property (nonatomic, strong) NSString *fileSize;

//上次升级时间
@property (nonatomic, assign) long long lastUpgradeTime;

//固件发布时间
@property (nonatomic, assign) long long firmwareDeployTime;

// 升级设备是否可控,0可控 1不可控
@property (nonatomic, assign) BOOL controlType;

@end

#endif
