//
//  TuyaSmartDevice.h
//  TuyaSmartKit
//
//  Created by fengyu on 15/8/31.
//  Copyright (c) 2015年 Tuya. All rights reserved.
//

#ifndef TuyaSmart_TuyaSmartDevice
#define TuyaSmart_TuyaSmartDevice

#import <Foundation/Foundation.h>
#import "TuyaSmartFirmwareUpgradeModel.h"
#import "TuyaSmartDeviceModel.h"
#import "TuyaSmartKitConstants.h"

/**
 设备在线状态
 */
typedef enum : NSUInteger {
    TYDeviceOnlineModeLocal, // 局域网在线
    TYDeviceOnlineModeInternet, // 外网在线
    TYDeviceOnlineModeOffline // 离线
} TYDeviceOnlineMode;

/**
 dp命令下发通道
 */
typedef enum : NSUInteger {
    TYDevicePublishModeLocal, // 局域网发送指令
    TYDevicePublishModeInternet, // 外网发送指令
    TYDevicePublishModeAuto // 自动(优先局域网)
} TYDevicePublishMode;

@class TuyaSmartDevice;

@protocol TuyaSmartDeviceDelegate<NSObject>

@optional

/// 设备信息更新
- (void)deviceInfoUpdate:(TuyaSmartDevice *)device;

/// 设备被移除
- (void)deviceRemoved:(TuyaSmartDevice *)device;

/// dp数据更新
- (void)device:(TuyaSmartDevice *)device dpsUpdate:(NSDictionary *)dps;

/// 固件升级成功
- (void)deviceFirmwareUpgradeSuccess:(TuyaSmartDevice *)device;

/// 固件升级失败
- (void)deviceFirmwareUpgradeFailure:(TuyaSmartDevice *)device;

/**
 *
 *  固件升级进度
 *  @param type 1 - 联网模块 2 - 设备控制模块
 *  @param progress 升级进度
 */
- (void)device:(TuyaSmartDevice *)device firmwareUpgradeProgress:(NSInteger)type progress:(double)progress;

@end

/// 设备相关功能
@interface TuyaSmartDevice : NSObject

@property (nonatomic, strong, readonly) TuyaSmartDeviceModel *deviceModel;
@property (nonatomic, weak) id<TuyaSmartDeviceDelegate> delegate;

/** 获取设备对象
 @param devId 设备Id
 */
+ (instancetype)deviceWithDeviceId:(NSString *)devId;

/** 获取设备对象
 @param devId 设备Id
 */
- (instancetype)initWithDeviceId:(NSString *)devId NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;

/**
 *  获取设备在线状态
 *
 *  @return 在线状态(局域网在线/外网在线/离线)
 */
- (TYDeviceOnlineMode)onlineMode;

/**
 *  dp命令下发
 *
 *  @param dps     命令字典
 *  @param success 操作成功回调
 *  @param failure 操作失败回调
 */
- (void)publishDps:(NSDictionary *)dps
           success:(TYSuccessHandler)success
           failure:(TYFailureError)failure;

/**
 *  dp命令下发
 *
 *  @param dps      命令字典
 *  @param mode     下发模式(局域网模式/外网模式/自动)
 *  @param success  操作成功回调
 *  @param failure  操作失败回调
 */
- (void)publishDps:(NSDictionary *)dps
              mode:(TYDevicePublishMode)mode
           success:(TYSuccessHandler)success
           failure:(TYFailureError)failure;

/**
 *  修改设备名称
 *
 *  @param name 设备名称
 *  @param success 操作成功回调
 *  @param failure 操作失败回调
 */
- (void)updateName:(NSString *)name success:(TYSuccessHandler)success failure:(TYFailureError)failure;

/**
 *  同步设备信息
 *
 *  @param success 操作成功回调
 *  @param failure 操作失败回调
 */
- (void)syncWithCloud:(TYSuccessHandler)success failure:(TYFailureError)failure;

/**
 *  同步设备信息
 *
 *  @param devId    设备Id
 *  @param homeId   房间Id
 *  @param success  操作成功回调
 *  @param failure  操作失败回调
 */
+ (void)syncDeviceInfoWithDevId:(NSString *)devId homeId:(long long)homeId success:(TYSuccessHandler)success failure:(TYFailureError)failure;

/**
 *  重置设备
 *
 *  @param success 操作成功回调
 *  @param failure 操作失败回调
 */
- (void)remove:(TYSuccessHandler)success failure:(TYFailureError)failure;

/**
 *  恢复出厂设置
 *
 *  @param success 操作成功回调
 *  @param failure 操作失败回调
 */
- (void)resetFactory:(TYSuccessHandler)success failure:(TYFailureError)failure;

/**
 *  获取设备升级信息  需要先升级联网模块，再升级设备控制模块
 *
 *  @param success 操作成功回调, 返回设备升级信息 devModel是设备控制模块的升级信息 gwModel是联网模块的升级信息
 *  @param failure 操作失败回调
 */
- (void)getFirmwareUpgradeInfo:(void (^)(TuyaSmartFirmwareUpgradeModel *devModel,TuyaSmartFirmwareUpgradeModel *gwModel))success
                       failure:(TYFailureError)failure;

/**
 *  下发升级指令，设备开始升级, 升级成功或失败会通过TuyaSmartDeviceDelegate返回
 *
 *  @param type    1 - 联网模块 2 - 设备控制模块
 *  @param success 操作成功回调
 *  @param failure 操作失败回调
 */
- (void)upgradeFirmware:(NSInteger)type success:(TYSuccessHandler)success failure:(TYFailureError)failure;


/// 取消固件未完成的接口请求
- (void)cancelFirmwareRequest;

/**
 *  获取设备升级信息  需要先升级联网模块，再升级设备控制模块
 *
 *  @param success 操作成功回调, 返回设备升级信息 devModel是设备控制模块的升级信息
 *  @param failure 操作失败回调
 */
- (void)getNewFirmwareUpgradeInfo:(void (^)(NSArray <TuyaSmartFirmwareUpgradeModel *> *))success
                          failure:(TYFailureError)failure;

/**
 *  下发升级指令，设备开始升级, 升级成功或失败会通过TuyaSmartDeviceDelegate返回
 *
 *  @param type    0-wifi 1-ble 2-gprs 9-mcu
 *  @param success 操作成功回调
 *  @param failure 操作失败回调
 */
- (void)upgradeNewFirmware:(NSInteger)type success:(TYSuccessHandler)success failure:(TYFailureError)failure;

/**
 *  更新设备固件的版本号
 *
 *  @param version 版本号
 *  @param type    固件类型
 *  @param success 操作成功回调
 *  @param failure 操作失败回调
 */
- (void)updateDeviceVersion:(NSString *)version type:(NSInteger)type success:(TYSuccessHandler)success failure:(TYFailureError)failure;

/**
 *  激活ZigBee子设备
 *
 *  @param success 操作成功回调
 *  @param failure 操作失败回调
 */
- (void)activeSubDeviceWithSuccess:(TYSuccessHandler)success failure:(TYFailureError)failure;

/**
 *  停止激活zigbee子设备
 */
- (void)stopActiveSubDevice;

/**
 *  获取当前网关下的子设备列表
 *
 *  @param success 操作成功回调
 *  @param failure 操作失败回调
 */
- (void)getSubDeviceListFromCloudWithSuccess:(void (^)(NSArray <TuyaSmartDeviceModel *> *subDeviceList))success failure:(TYFailureError)failure;


@end

#endif
