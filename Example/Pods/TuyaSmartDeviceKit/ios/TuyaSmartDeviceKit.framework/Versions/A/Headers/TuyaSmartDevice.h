//
//  TuyaSmartDevice.h
//  TuyaSmartKit
//
//  Created by fengyu on 15/8/31.
//  Copyright (c) 2015年 Tuya. All rights reserved.
//

#ifndef TuyaSmart_TuyaSmartDevice
#define TuyaSmart_TuyaSmartDevice

#import <TuyaSmartUtil/TuyaSmartUtil.h>
#import "TuyaSmartFirmwareUpgradeModel.h"
#import "TuyaSmartDeviceModel.h"

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
- (void)deviceFirmwareUpgradeSuccess:(TuyaSmartDevice *)device type:(NSInteger)type;

/// 固件升级失败
- (void)deviceFirmwareUpgradeFailure:(TuyaSmartDevice *)device type:(NSInteger)type;

/**
 *  固件升级进度
 *
 *  @param type     设备类型
 *  @param progress 升级进度
 */
- (void)device:(TuyaSmartDevice *)device firmwareUpgradeProgress:(NSInteger)type progress:(double)progress;

// wifi信号强度回调
- (void)device:(TuyaSmartDevice *)device signal:(NSString *)signal;

@end

/// 设备相关功能
@interface TuyaSmartDevice : NSObject

@property (nonatomic, strong, readonly) TuyaSmartDeviceModel *deviceModel;
@property (nonatomic, weak) id<TuyaSmartDeviceDelegate> delegate;

/**
 * 获取设备对象
 *
 * @param devId 设备Id
 */
+ (instancetype)deviceWithDeviceId:(NSString *)devId;

/**
 * 获取设备对象
 *
 * @param devId 设备Id
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
 *  @param homeId   家庭Id
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
 *  获取当前网关下的子设备列表
 *
 *  @param success 操作成功回调
 *  @param failure 操作失败回调
 */
- (void)getSubDeviceListFromCloudWithSuccess:(void (^)(NSArray <TuyaSmartDeviceModel *> *subDeviceList))success failure:(TYFailureError)failure;

/**
 *  获取wifi的信号强度
 *  通过 - (void)device:(TuyaSmartDevice *)device signalStrength:(NSString *)SignalStrength 接受回调
 *
 *  @param success 操作成功回调
 *  @param failure 操作失败回调
 */
- (void)getWifiSignalStrengthWithSuccess:(TYSuccessHandler)success failure:(TYFailureError)failure;

#pragma mark - firmware upgrade

/**
 *  获取设备升级信息
 *
 *  @param success 操作成功回调
 *  @param failure 操作失败回调
 */
- (void)getFirmwareUpgradeInfo:(void (^)(NSArray <TuyaSmartFirmwareUpgradeModel *> *upgradeModelList))success
                       failure:(TYFailureError)failure;

/**
 *  下发升级指令，设备开始升级, 升级成功或失败会通过TuyaSmartDeviceDelegate返回
 *
 *  @param type    设备类型 TuyaSmartFirmwareUpgradeModel - type
 *  @param success 操作成功回调
 *  @param failure 操作失败回调
 */
- (void)upgradeFirmware:(NSInteger)type success:(TYSuccessHandler)success failure:(TYFailureError)failure;

/**
 *  取消固件未完成的接口请求
 */
- (void)cancelFirmwareRequest;


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
 *  获取主动查询的dp点，这些dp点只有在主动查询的时候才上报，否则不会上报。
 *
 *  @param dpsArray dp点的数组，可以为空，如果传空或者空数组的时候，查询所有的dp
 *  @param success 操作成功回调
 *  @param failure 操作失败回调
 */
- (void)getInitiativeQueryDpsInfoWithDpsArray:(NSArray *)dpsArray success:(TYSuccessHandler)success failure:(TYFailureError)failure;

/**
 *  唤醒低功耗设备
 *
 *  @param success 操作成功回调
 *  @param failure 操作失败回调
 */
- (void)awakeDeviceWithSuccess:(TYSuccessHandler)success failure:(TYFailureError)failure;

@end

#endif
