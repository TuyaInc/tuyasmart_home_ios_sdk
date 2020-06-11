//
//  TuyaSmartActivator.h
//  TuyaSmartKit
//
//  Created by fengyu on 15/8/31.
//  Copyright (c) 2015年 Tuya. All rights reserved.
//

#ifndef TuyaSmart_TuyaSmartActivator
#define TuyaSmart_TuyaSmartActivator

#import <TuyaSmartDeviceKit/TuyaSmartDeviceKit.h>

/// 收到有线配网设备的广播后，会发送此通知。objec为dictionary，@{@"productId":productId, @"gwId":gwId}
/// Receiving broadcasts from wired config network
extern NSString *const TuyaSmartActivatorNotificationFindGatewayDevice;

typedef enum : NSUInteger {
    TYActivatorModeEZ,// smart config mode
    TYActivatorModeAP,// access point mode
    TYActivatorModeQRCode,// QR Code mode
    TYActivatorModeWired, // wired mode
} TYActivatorMode;

typedef enum : NSUInteger {
    TYActivatorStepFound = 1,// device found
    TYActivatorStepRegisted = 2,// device registed
    TYActivatorStepIntialized = 3,// device intialized
    TYActivatorStepTimeOut = 4, // device config timeout
} TYActivatorStep;

@class TuyaSmartActivator;

@protocol TuyaSmartActivatorDelegate<NSObject>

@required

/**
 Callback of Config Network Status Update
 配网状态更新的回调，wifi单品，zigbee网关，zigbee子设备

 @param activator   instance
 @param deviceModel deviceModel
 @param error       error
 */
- (void)activator:(TuyaSmartActivator *)activator didReceiveDevice:(TuyaSmartDeviceModel *)deviceModel error:(NSError *)error;

@optional

/**
 Callback of Config Network Status Update
 配网状态更新的回调，wifi单品，zigbee网关，zigbee子设备

 @param activator   instance
 @param deviceModel deviceModel
 @param step        activator step
 @param error       error
 */
- (void)activator:(TuyaSmartActivator *)activator didReceiveDevice:(TuyaSmartDeviceModel *)deviceModel step:(TYActivatorStep)step error:(NSError *)error;

/**
 Callback of Config Network Status Update (mesh gateway),deprecated
 配网状态更新的回调 mesh网关，已经废弃

 @param activator   instance
 @param deviceId    devId
 @param meshId      meshId
 @param error       error
 */
- (void)meshActivator:(TuyaSmartActivator *)activator didReceiveDeviceId:(NSString *)deviceId meshId:(NSString *)meshId error:(NSError *)error __deprecated_msg("Use -[TuyaSmartActivatorDelegate activator:didReceiveDevice:error:] instead. `deviceId` is `deviceModel.devId`, `meshId` is `deviceModel.parentId`.");

@end

@interface TuyaSmartActivator : NSObject

/**
 Singleton
 单例

 @return instance
 */
+ (instancetype)sharedInstance;

#pragma mark - ssid

/**
 Get the SSID of the current Wi-Fi
 获取当前 Wi-Fi 的 SSID
 
 @discussion To use this function in iOS 12 and later, enable the Access WiFi Information capability for your app in Xcode.
 To use this function in iOS 13 and later, must also meet at least one of criteria below:
    - Apps with permission to access location
    - Currently enabled VPN app
    - NEHotspotConfiguration (only Wi-Fi networks that the app configured)
 
 从 iOS 12 开始，调用该函数将默认返回 nil，需要在 Xcode 项目中开启「Access WiFi Information」后才会返回正确的值。这个功能需要在开发者页面的 App IDs 中激活才能使用。
 从 iOS 13 开始，还需要符合下列三项条件中的至少一项：
    - 获得了定位服务权限的应用；
    - 目前正处于启用状态的 VPN 应用；
    - 使用 NEHotspotConfiguration（仅支援通过应用配置的 Wi-Fi 网路）。
 
 @see https://developer.apple.com/videos/play/wwdc2019/713/
 
 @return Wi-Fi SSID
 */
+ (NSString *)currentWifiSSID;

/**
 Get the BSSID of the current Wi-Fi
 获取当前 Wi-Fi 的 BSSID
 
 @discussion See +[TuyaSmartActivator currentWifiSSID];
 
 @return Wi-Fi BSSID
 */
+ (NSString *)currentWifiBSSID;

/**
 Get the SSID of the current Wi-Fi asynchronous
 异步获取当前 Wi-Fi 的 SSID
 
 @discussion See +[TuyaSmartActivator currentWifiSSID];
 
 @param success Success block
 @param failure Failure block
 */
+ (void)getSSID:(TYSuccessString)success
        failure:(TYFailureError)failure;

/**
 Get the BSSID of the current Wi-Fi asynchronous
 异步获取当前 Wi-Fi 的 BSSID

 @discussion See +[TuyaSmartActivator currentWifiBSSID];

 @param success Success block
 @param failure Failure block
*/
+ (void)getBSSID:(TYSuccessString)success
         failure:(TYFailureError)failure;

#pragma mark -

@property (nonatomic, weak) id<TuyaSmartActivatorDelegate> delegate;

#pragma mark - active gateway

/**
 *  To obtain token (valid for 10 minutes)
 *  获取配网Token（有效期10分钟）
 *
 *  @param homeId  Home Id
 *  @param success Success block
 *  @param failure Failure block
 */
- (void)getTokenWithHomeId:(long long)homeId
                   success:(TYSuccessString)success
                   failure:(TYFailureError)failure;


/**
 *  To obtain token with productId  (valid for 10 minutes)
 *  获取配网Token（有效期10分钟）
 *
 *  @param productKey   Product Id
 *  @param homeId       Home Id
 *  @param success      Success block
 *  @param failure      Failure block
 */
- (void)getTokenWithProductKey:(NSString *)productKey
                        homeId:(long long)homeId
                       success:(TYSuccessString)success
                       failure:(TYFailureError)failure;

/**
 *  To obtain token with uuid  (valid for 10 minutes)
 *  获取配网Token（有效期10分钟）
 *
 *  @param uuid    Device uuid
 *  @param homeId  Home Id
 *  @param success Success block
 *  @param failure Failure block
 */
- (void)getTokenWithUUID:(NSString *)uuid
                  homeId:(long long)homeId
                 success:(TYSuccessString)success
                 failure:(TYFailureError)failure;

/**
 *  start config (Wireless config)
 *  开始配网 (无线配网)
 *
 *  @param mode     Config mode, EZ or AP
 *  @param ssid     Name of route
 *  @param password Password of route
 *  @param token    Config Token
 *  @param timeout  Timeout, default 100 seconds
 */
- (void)startConfigWiFi:(TYActivatorMode)mode
                   ssid:(NSString *)ssid
               password:(NSString *)password
                  token:(NSString *)token
                timeout:(NSTimeInterval)timeout;

/**
 *  start config (Wired config)
 *  开始配网（有线配网）
 *
 *  @param token    Token
 *  @param timeout  Timeout, default 100 seconds
 */
- (void)startConfigWiFiWithToken:(NSString *)token timeout:(NSTimeInterval)timeout;

/**
 *  start config with productId (Wired config)
 *  开始配网（有线配网）只去激活一个品类的设备
 *
 *  @param token        配网Token
 *  @param productId    productId 设备的产品Id
 *  @param timeout      Timeout, default 100 seconds
 */
- (void)startConfigWiFiWithToken:(NSString *)token
                       productId:(NSString *)productId
                         timeout:(NSTimeInterval)timeout;

/**
 *  start EZ mode multi-device config
 *  开始EZ模式多设备配网
 *
 *  @param ssid     Name of route 路由器热点名称
 *  @param password Password of route 路由器热点密码
 *  @param token    配网 Token
 *  @param timeout  Timeout, default 100 seconds
 */
- (void)startEZMultiConfigWiFiWithSsid:(NSString *)ssid
                              password:(NSString *)password
                                 token:(NSString *)token
                               timeout:(NSTimeInterval)timeout;


/**
 *  停止配网
 *  stop config
 */
- (void)stopConfigWiFi;

#pragma mark - active sub device

/**
 *  激活子设备 如 zigbee、Wi-Fi 子设备 ...
 *  active sub device
 *
 *  @param gwId     gateway Id
 *  @param timeout  Timeout, default 100 seconds
 */
- (void)activeSubDeviceWithGwId:(NSString *)gwId timeout:(NSTimeInterval)timeout;


/**
 *  stop active sub device
 *  停止激活子设备
 *
 *  @param gwId     gateway Id
 */
- (void)stopActiveSubDeviceWithGwId:(NSString *)gwId;

@end

#endif
