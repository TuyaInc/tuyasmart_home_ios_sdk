//
//  TuyaSmartActivator.h
//  TuyaSmartKit
//
//  Created by fengyu on 15/8/31.
//  Copyright (c) 2015年 Tuya. All rights reserved.
//

#ifndef TuyaSmart_TuyaSmartActivator
#define TuyaSmart_TuyaSmartActivator

#import <TuyaSmartUtil/TuyaSmartUtil.h>


/// 收到有线配网设备的广播后，会发送此通知。objec为dictionary，@{@"productId":productId, @"gwId":gwId}
extern NSString *const TuyaSmartActivatorNotificationFindGatewayDevice;

@class TuyaSmartDeviceModel;

typedef enum : NSUInteger {
    TYActivatorModeEZ,//快连模式
    TYActivatorModeAP,//热点模式
    TYActivatorModeQRCode,//摄像头二维码模式
} TYActivatorMode;

@class TuyaSmartActivator;

@protocol TuyaSmartActivatorDelegate<NSObject>

@required

/// 配网状态更新的回调，wifi单品，zigbee网关，zigbee子设备
- (void)activator:(TuyaSmartActivator *)activator didReceiveDevice:(TuyaSmartDeviceModel *)deviceModel error:(NSError *)error;

@optional
/// 配网状态更新的回调 mesh网关
- (void)meshActivator:(TuyaSmartActivator *)activator didReceiveDeviceId:(NSString *)deviceId meshId:(NSString *)meshId error:(NSError *)error __deprecated_msg("Use -[TuyaSmartActivatorDelegate activator:didReceiveDevice:error:] instead. `deviceId` is `deviceModel.devId`, `meshId` is `deviceModel.parentId`.");

@end

/// 配网相关功能
@interface TuyaSmartActivator : NSObject


/**
 *  单例
 */
+ (instancetype)sharedInstance;

/**
 *  获取当前Wifi的SSID名称
 */
+ (NSString *)currentWifiSSID;

/**
 *  获取当前Wifi的BSSID名称
 */
+ (NSString *)currentWifiBSSID;


@property (nonatomic, weak) id<TuyaSmartActivatorDelegate> delegate;

#pragma mark - active gateway

/**
 *
 *  获取配网Token（有效期10分钟）
 *
 *  @param homeId  家庭id
 *  @param success 操作成功回调，返回配网Token
 *  @param failure 操作失败回调
 */
- (void)getTokenWithHomeId:(long long)homeId
                   success:(TYSuccessString)success
                   failure:(TYFailureError)failure;


/**
 *
 *  OEM配网
 *  获取配网Token（有效期10分钟）
 *
 *  @param productKey   产品Id
 *  @param homeId       家庭id
 *  @param success      操作成功回调，返回配网Token
 *  @param failure      操作失败回调
 */
- (void)getTokenWithProductKey:(NSString *)productKey
                        homeId:(long long)homeId
                       success:(TYSuccessString)success
                       failure:(TYFailureError)failure;

/**
 *
 *  获取配网Token（有效期10分钟）
 *
 *  @param uuid    设备唯一id
 *  @param homeId  家庭id
 *  @param success 操作成功回调，返回配网Token
 *  @param failure 操作失败回调
 */
- (void)getTokenWithUUID:(NSString *)uuid
                  homeId:(long long)homeId
                 success:(TYSuccessString)success
                 failure:(TYFailureError)failure;

/**
 *  开始配网 (无线配网)
 *
 *  @param mode     配网模式, EZ或AP模式
 *  @param ssid     路由器热点名称
 *  @param password 路由器热点密码
 *  @param token    配网Token
 *  @param timeout  超时时间, 默认为100秒
 */
- (void)startConfigWiFi:(TYActivatorMode)mode
                   ssid:(NSString *)ssid
               password:(NSString *)password
                  token:(NSString *)token
                timeout:(NSTimeInterval)timeout;

/**
 *  开始配网（有线配网）
 *
 *  @param token    配网Token
 *  @param timeout  超时时间, 默认为100秒
 */
- (void)startConfigWiFiWithToken:(NSString *)token timeout:(NSTimeInterval)timeout;

/**
 *  开始配网（有线配网）只去激活一个品类的设备
 *
 *  @param token        配网Token
 *  @param productId    productId 设备的产品Id
 *  @param timeout      超时时间, 默认为100秒
 */
- (void)startConfigWiFiWithToken:(NSString *)token
                       productId:(NSString *)productId
                         timeout:(NSTimeInterval)timeout;

/**
 *  开始EZ模式多设备配网
 *
 *  @param ssid     路由器热点名称
 *  @param password 路由器热点密码
 *  @param token    配网Token
 *  @param timeout  超时时间, 默认为100秒
 */
- (void)startEZMultiConfigWiFiWithSsid:(NSString *)ssid
                              password:(NSString *)password
                                 token:(NSString *)token
                               timeout:(NSTimeInterval)timeout;


/**
 *  停止配网
 */
- (void)stopConfigWiFi;

#pragma mark - active sub device

/**
 *  激活子设备
 *  如 zigbee、Wi-Fi 子设备 ...
 *
 *  @param gwId     网关Id
 *  @param timeout  超时时间, 默认为100秒
 */
- (void)activeSubDeviceWithGwId:(NSString *)gwId timeout:(NSTimeInterval)timeout;


/**
 *  停止激活子设备
 */
- (void)stopActiveSubDeviceWithGwId:(NSString *)gwId;

@end

#endif
