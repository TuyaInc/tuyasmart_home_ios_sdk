//
//  TuyaSmartSDK.h
//  TuyaSmartKit
//
//  Created by fengyu on 15/8/31.
//  Copyright (c) 2015年 Tuya. All rights reserved.
//

#ifndef TuyaSmart_TuyaSmartSDK
#define TuyaSmart_TuyaSmartSDK

#import <TuyaSmartUtil/TuyaSmartUtil.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, TYEnv) {
    TYEnvDaily,
    TYEnvPrepare,
    TYEnvRelease,
};

@interface TuyaSmartSDK : NSObject

/// Singleton
+ (instancetype)sharedInstance;

/// Push token
@property (nonatomic, strong) NSString *pushToken;

/**
 *  Application group identifier
 *  If you want to use the SDK in app extension, set `appGroupId` before SDK initialized both in app & app extension.
 *  如果需要开发APP Extension，请在初始化SDK的时候设置 appGroupId
 */
@property (nonatomic, strong) NSString *appGroupId;

/// Debug mode
/// 调试模式
@property (nonatomic, assign) BOOL debugMode;

/// Latitude of the loaction
@property (nonatomic, assign) double latitude;

/// Longitude of the loaction
@property (nonatomic, assign) double longitude;

/// Server environment, daily/prepare/release. For test only. Not recommended to switch
/// 测试环境，不建议切换
@property (nonatomic, assign) TYEnv env;

/// Channel
@property (nonatomic, strong) NSString *channel;

/**
 *  Initialize TuyaSmart SDK
 *  初始化涂鸦智能SDK
 *
 *  @param appKey    TuyaSmart AppKey
 *  @param secretKey TuyaSmart SecretKey
 */
- (void)startWithAppKey:(NSString *)appKey secretKey:(NSString *)secretKey;

/**
 *  Report location if needed
 *
 *  @param latitude latitude
 *  @param longitude longitude
 */
- (void)updateLatitude:(double)latitude longitude:(double)longitude;

@end


@interface TuyaSmartSDK (Upgrade)

/**
 *  Check if TuyaSmartKit need to be upgrade to TuyaSmartHomeKit
 *  检测是否需要升级数据 从TuyaSDK 升级到TuyaHomeSDK，需要进行数据升级
 */
- (BOOL)checkVersionUpgrade;

/**
 *  SDK data upgrade
 *  SDK数据升级
 */
- (void)upgradeVersion:(nullable TYSuccessHandler)success
               failure:(nullable TYFailureError)failure;

@end


@interface TuyaSmartSDK (PushNotification)

/**
 *  Get notification status
 *  获取 APP 消息通知的开启状态
 */
- (void)getPushStatusWithSuccess:(TYSuccessBOOL)success failure:(TYFailureError)failure;

/**
*  Set notification status
*  开启或者关闭 APP 开启消息通知的状态
*/
- (void)setPushStatusWithStatus:(BOOL)status success:(TYSuccessHandler)success failure:(TYFailureError)failure;

@end


void TYLog(NSString *format, ...) NS_FORMAT_FUNCTION(1,2);

NS_ASSUME_NONNULL_END

#endif
