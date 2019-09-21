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
#import "TuyaSmartMQTTMessageModel.h"

NS_ASSUME_NONNULL_BEGIN

/// Device online status
/// 设备的在线状态
typedef enum : NSUInteger {
    TYDeviceOnlineModeLocal, // Local network online
    TYDeviceOnlineModeInternet, // Internet online
    TYDeviceOnlineModeOffline, // offline
} TYDeviceOnlineMode;

/// dp publish channel
/// 设备控制的方式
typedef enum : NSUInteger {
    TYDevicePublishModeLocal, // Through local network
    TYDevicePublishModeInternet, // Through internet
    TYDevicePublishModeAuto, // Auto (If local network is avaliable, use local)
} TYDevicePublishMode;

@class TuyaSmartDevice;

@protocol TuyaSmartDeviceDelegate<NSObject>

@optional

/**
 *  Device info update, such as the name, online
 *  设备基本信息（例如名字，在线状态等）变化代理回调
 *
 *  @param device instance
 */
- (void)deviceInfoUpdate:(TuyaSmartDevice *)device;

/**
 *  Device removed
 *  设备被移除变化代理回调
 *
 *  @param device instance
 */
- (void)deviceRemoved:(TuyaSmartDevice *)device;

/**
 *  dp data update
 *  设备 dps 变化代理回调
 *
 *  @param device  instance
 *  @param dps     dps
 */
- (void)device:(TuyaSmartDevice *)device dpsUpdate:(NSDictionary *)dps;

/**
 *  Device firmware upgrade success
 *  固件升级成功代理回调
 *
 *  @param device instance
 *  @param type   device type
 */
- (void)deviceFirmwareUpgradeSuccess:(TuyaSmartDevice *)device type:(NSInteger)type;

/**
 *  Device firmware upgrade failure
 *  固件升级失败代理回调
 *
 *  @param device instance
 *  @param type   device type
 */
- (void)deviceFirmwareUpgradeFailure:(TuyaSmartDevice *)device type:(NSInteger)type;

/**
 *  Device firmware upgrading
 *  固件升级中代理回调
 *
 *  @param device instance
 *  @param type   device type
 */
- (void)deviceFirmwareUpgrading:(TuyaSmartDevice *)device type:(NSInteger)type;

/**
 *  Firmware upgrade progress.
 *  固件升级进度
 *
 *  @param device   instance
 *  @param type     device type
 *  @param progress upgrade progress
 */
- (void)device:(TuyaSmartDevice *)device firmwareUpgradeProgress:(NSInteger)type progress:(double)progress;

/**
 *  Wifi signal strength callback.
 *  Wifi信号强度
 *
 *  @param device   instance
 *  @param signal   Signal strength
 */
- (void)device:(TuyaSmartDevice *)device signal:(NSString *)signal;

/**
 *  Recv custom message
 *  收到自定义消息
 *
 *  @param device   instance
 *  @param message  custom message
 */
- (void)device:(TuyaSmartDevice *)device didReceiveCustomMessage:(TuyaSmartMQTTMessageModel *)message;

/**
 *  the delegate of warning information update
 *  设备的告警信息变化的代理回调
 *
 *  @param device       instance
 *  @param warningInfo  warning info
 */
- (void)device:(TuyaSmartDevice *)device warningInfoUpdate:(NSDictionary *)warningInfo;

@end

/// Device-related functions.
/// 设备相关功能
@interface TuyaSmartDevice : NSObject

@property (nonatomic, strong, readonly) TuyaSmartDeviceModel *deviceModel;
@property (nonatomic, weak, nullable) id<TuyaSmartDeviceDelegate> delegate;

/**
 *  Get TuyaSmartDevice instance. If current user don't have this device, a nil will be return.
 *  获取设备实例。如果当前用户没有该设备，将会返回nil。
 *
 *  @param devId Device ID
 *  @return instance
 */
+ (nullable instancetype)deviceWithDeviceId:(NSString *)devId;

/**
 *  Get TuyaSmartDevice instance. If current user don't have this device, a nil will be return.
 *  获取设备实例。如果当前用户没有该设备，将会返回nil。
 *
 *  @param devId Device ID
 *  @return instance
 */
- (nullable instancetype)initWithDeviceId:(NSString *)devId NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;

/**
 *  Get device online status.
 *  获取设备在线状态
 */
- (TYDeviceOnlineMode)onlineMode;

/**
 *  dp command publish.
 *  dp命令下发
 *
 *  @param dps     dp dictionary
 *  @param success Success block
 *  @param failure Failure block
 */
- (void)publishDps:(NSDictionary *)dps
           success:(nullable TYSuccessHandler)success
           failure:(nullable TYFailureError)failure;

/**
 *  dp command publish.
 *  dp命令下发
 *
 *  @param dps     dp dictionary
 *  @param mode    Publish mode(Lan/Internet/Auto)
 *  @param success Success block
 *  @param failure Failure block
 */
- (void)publishDps:(NSDictionary *)dps
              mode:(TYDevicePublishMode)mode
           success:(nullable TYSuccessHandler)success
           failure:(nullable TYFailureError)failure;

/**
 *  Edit device name.
 *  修改设备名称
 *
 *  @param name Device name
 *  @param success Success block
 *  @param failure Failure block
 */
- (void)updateName:(NSString *)name success:(nullable TYSuccessHandler)success failure:(nullable TYFailureError)failure;

/**
 *  Edit device icon.
 *  修改设备图片
 *
 *  @param icon     icon
 *  @param success  Success block
 *  @param failure  Failure block
 */
- (void)updateIcon:(UIImage *)icon
           success:(nullable TYSuccessHandler)success
           failure:(nullable TYFailureError)failure;

/**
 *  Sync device information.
 *  同步设备信息到缓存
 *
 *  @param success Success block
 *  @param failure Failure block
 */
- (void)syncWithCloud:(nullable TYSuccessHandler)success failure:(nullable TYFailureError)failure;

/**
 *  Sync device information.
 *  同步设备信息
 *
 *  @param devId   Device ID
 *  @param homeId  Home ID
 *  @param success Success block
 *  @param failure Failure block
 */
+ (void)syncDeviceInfoWithDevId:(NSString *)devId homeId:(long long)homeId success:(nullable TYSuccessHandler)success failure:(nullable TYFailureError)failure;

/**
 *  Sync subdevice information.
 *  同步子设备信息
 *
 *  @param gatewayId  Gateway ID
 *  @param devId   Device ID
 *  @param success Success block
 *  @param failure Failure block
 */
+ (void)syncSubDeviceInfoWithGatewayId:(NSString *)gatewayId devId:(NSString *)devId success:(nullable TYSuccessHandler)success failure:(nullable TYFailureError)failure;

/**
 *  Remove device. Unbind the device with current user.
 *  移除设备，解除与当前用户的关联关系。
 *
 *  @param success Success block
 *  @param failure Failure block
 */
- (void)remove:(nullable TYSuccessHandler)success failure:(nullable TYFailureError)failure;

/**
 *  Restore factory settings.
 *  恢复出厂设置
 *
 *  @param success Success block
 *  @param failure Failure block
 */
- (void)resetFactory:(nullable TYSuccessHandler)success failure:(nullable TYFailureError)failure;

/**
 *  Get sub-device list of current gateway.
 *  获取当前网关下的子设备列表
 *
 *  @param success Success block
 *  @param failure Failure block
 */
- (void)getSubDeviceListFromCloudWithSuccess:(nullable void (^)(NSArray <TuyaSmartDeviceModel *> *subDeviceList))success failure:(nullable TYFailureError)failure;

/**
 *  Synchronize the Longitude and Latitude of the Mobile Phone to the Device
 *  将手机的经纬度同步到设备
 *
 *  @param success Success block
 *  @param failure Failure block
 */
- (void)syncLocationToDeviceWithSucecess:(nullable TYSuccessHandler)success failure:(nullable TYFailureError)failure;

#pragma mark - firmware upgrade

/**
 *  Get firmware upgrade information.
 *  获取设备升级信息
 *
 *  @param success Success block
 *  @param failure Failure block
 */
- (void)getFirmwareUpgradeInfo:(nullable void (^)(NSArray <TuyaSmartFirmwareUpgradeModel *> *upgradeModelList))success
                       failure:(nullable TYFailureError)failure;

/**
 *  Upgrade firmware. Receive success or failure callback from TuyaSmartDeviceDelegate.
 *  下发升级指令，设备开始升级, 升级成功或失败会通过TuyaSmartDeviceDelegate返回
 *
 *  @param type    Device type of `TuyaSmartFirmwareUpgradeModel`
 *  @param success Success block
 *  @param failure Failure block
 */
- (void)upgradeFirmware:(NSInteger)type success:(nullable TYSuccessHandler)success failure:(nullable TYFailureError)failure;

/**
 *  Cancel firmware upgrade network request.
 *  取消未完成的固件升级接口请求
 */
- (void)cancelFirmwareRequest;


/**
 *  Report device firmware version.
 *  上报设备固件的版本号
 *
 *  @param version Version
 *  @param type    Device type
 *  @param success Success block
 *  @param failure Failure block
 */
- (void)updateDeviceVersion:(NSString *)version type:(NSInteger)type success:(nullable TYSuccessHandler)success failure:(nullable TYFailureError)failure;


#if TARGET_OS_IOS

/**
 *  Get wifi signal strength. Receive signal strength from`-[TuyaSmartDeviceDelegate device:signal:]`.
 *  获取wifi的信号强度。通过`-[TuyaSmartDeviceDelegate device:signal:]`接收回调
 *
 *  @param success Success block
 *  @param failure Failure block
 */
- (void)getWifiSignalStrengthWithSuccess:(nullable TYSuccessHandler)success failure:(nullable TYFailureError)failure;

/**
 *  publish message in lan
 *  发送局域网消息
 *
 *  @param body     message body
 *  @param type     message type
 *  @param success  Success block
 *  @param failure  Failure block
 */
- (void)publishMessageInLanWithBody:(NSDictionary *)body type:(NSInteger)type success:(nullable TYSuccessHandler)success failure:(nullable TYFailureError)failure;

/**
 *  Query dp initiative. Some dp won't report initiative when changed.
 *  获取主动查询的dp点，这些dp点只有在主动查询的时候才上报，否则不会上报。
 *
 *  @param dpsArray dpId array. If nil or empty array passed in，All dp will be queried。
 *  @param success Success block
 *  @param failure Failure block
 */
- (void)getInitiativeQueryDpsInfoWithDpsArray:(nullable NSArray *)dpsArray success:(nullable TYSuccessHandler)success failure:(nullable TYFailureError)failure;

/**
 *  Awake low energy device.
 *  唤醒低功耗设备
 *
 *  @param success Success block
 *  @param failure Failure block
 */
- (void)awakeDeviceWithSuccess:(nullable TYSuccessHandler)success failure:(nullable TYFailureError)failure;


#pragma mark - publish custom message

/**
 *  add custom message delegate.  Receive custom message from `- (void)device:(TuyaSmartDevice *)device didReceiveCustomMessage:(TuyaSmartMQTTMessageModel *)message`.
 *  添加自定义消息代理  通过`- (void)device:(TuyaSmartDevice *)device didReceiveCustomMessage:(TuyaSmartMQTTMessageModel *)message` 回调
 *
 *  @param delegate Delegate
 *  @param protocol Protocol
 */
- (void)addDelegate:(id<TuyaSmartDeviceDelegate>)delegate forProtocol:(NSInteger)protocol;

/**
 *  remove custom message delegate
 *  删除自定义消息代理
 *
 *  @param delegate Delegate
 *  @param protocol Protocol
 */
- (void)removeDelegate:(id<TuyaSmartDeviceDelegate>)delegate forProtocol:(NSInteger)protocol;

/**
 *  send to custom message
 *  自定义（非dps）消息发送
 *
 *  @param data     Data
 *  @param protocol Protocol
 *  @param success  Success block
 *  @param failure  Failure block
 */
- (void)publishCustomMessageWithData:(NSDictionary *)data
                            protocol:(NSInteger)protocol
                             success:(nullable TYSuccessHandler)success
                             failure:(nullable TYFailureError)failure;

#endif

@end

NS_ASSUME_NONNULL_END

#endif
