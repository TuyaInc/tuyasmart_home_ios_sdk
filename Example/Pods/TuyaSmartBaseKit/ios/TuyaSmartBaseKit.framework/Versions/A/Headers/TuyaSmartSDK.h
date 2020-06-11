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

/**
 Singleton

 @return instance
 */
+ (instancetype)sharedInstance;

/**
 *  Application group identifier
 *  If you want to use the SDK in app extension, set `appGroupId` before SDK initialized both in app & app extension.
 *  如果需要开发APP Extension，请在初始化SDK的时候设置 appGroupId
 */
@property (nonatomic, strong) NSString *appGroupId;

/// Latitude of the loaction
@property (nonatomic, assign) double latitude;

/// Longitude of the loaction
@property (nonatomic, assign) double longitude;

/// Server environment, daily/prepare/release. For test only. Not recommended to switch
/// 测试环境，不建议切换
@property (nonatomic, assign) TYEnv env;

@property (nonatomic, assign) BOOL useSSLPinning;

@property (nonatomic, strong, readonly) NSString *appKey;

@property (nonatomic, strong, readonly) NSString *secretKey;

/// Channel
@property (nonatomic, strong) NSString *channel;

/// uuid of the iOS/watchOS device. Will be created at app first launch.
@property (nonatomic, strong, readonly) NSString *uuid;

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
 *
 *  @return Whether need to upgrade data
 */
- (BOOL)checkVersionUpgrade;

/**
 *  SDK data upgrade
 *  SDK数据升级
 *
 *  @param success     Success block
 *  @param failure     Failure block
 */
- (void)upgradeVersion:(nullable TYSuccessHandler)success
               failure:(nullable TYFailureError)failure;

@end


@interface TuyaSmartSDK (PushNotification)

/// Push token
@property (nonatomic, strong) NSString *pushToken DEPRECATED_MSG_ATTRIBUTE("Use +[TuyaSmartSDK sharedInstance].deviceToken instead.");

/// Push deviceToken
@property (nonatomic, strong) NSData *deviceToken;

/**
 *  Set push device token and error info
 *  设置推送token以及错误信息
 *  @param token    deviceToken
 *  @param error    error info
 */
- (void)setDeviceToken:(nullable NSData *)token withError:(nullable NSError *)error;

/**
 *  Get notification push status
 *  获取 APP 消息推送的开启状态
 *
 *  @param success     Success block
 *  @param failure     Failure block
 */
- (void)getPushStatusWithSuccess:(__nullable TYSuccessBOOL)success failure:(__nullable TYFailureError)failure;

/**
 *  Set notification push status
 *  开启或者关闭 APP 消息推送
 *
 *  @param enable      open or close
 *  @param success     Success block
 *  @param failure     Failure block
 */
- (void)setPushStatusWithStatus:(BOOL)enable success:(__nullable TYSuccessHandler)success failure:(__nullable TYFailureError)failure;



/**
 *  Get device alarm push status
 *  获取 APP 设备告警通知的开启状态
 *
 *  @param success     Success block
 *  @param failure     Failure block
 */
- (void)getDevicePushStatusWithSuccess:(__nullable TYSuccessBOOL)success failure:(__nullable TYFailureError)failure;

/**
 *  Set device alarm push status
 *  开启或者关闭 APP 设备告警推送消息
 *
 *  @param enable      open or close
 *  @param success     Success block
 *  @param failure     Failure block
 */
- (void)setDevicePushStatusWithStauts:(BOOL)enable success:(__nullable TYSuccessHandler)success failure:(__nullable TYFailureError)failure;

/**
 *  Get family message push status
 *  获取 APP 家庭通知的开启状态
 *
 *  @param success     Success block
 *  @param failure     Failure block
 */
- (void)getFamilyPushStatusWithSuccess:(__nullable TYSuccessBOOL)success failure:(__nullable TYFailureError)failure;

/**
 *  Set family message push status
 *  开启或者关闭 APP 家庭推送消息
 *
 *  @param enable      open or close
 *  @param success     Success block
 *  @param failure     Failure block
 */
- (void)setFamilyPushStatusWithStauts:(BOOL)enable success:(__nullable TYSuccessHandler)success failure:(__nullable TYFailureError)failure;

/**
 *  Get notice message push status
 *  获取 APP 消息通知的开启状态
 *
 *  @param success     Success block
 *  @param failure     Failure block
 */
- (void)getNoticePushStatusWithSuccess:(__nullable TYSuccessBOOL)success failure:(__nullable TYFailureError)failure;

/**
 *  Set notice message push status
 *  开启或者关闭 APP 消息通知推送
 *
 *  @param enable      open or close
 *  @param success     Success block
 *  @param failure     Failure block
 */
- (void)setNoticePushStatusWithStauts:(BOOL)enable success:(__nullable TYSuccessHandler)success failure:(__nullable TYFailureError)failure;

/**
 *  Get market message push status
 *  获取 APP 营销类消息的开启状态
 *
 *  @param success     Success block
 *  @param failure     Failure block
 */
- (void)getMarketingPushStatusWithSuccess:(__nullable TYSuccessBOOL)success failure:(__nullable TYFailureError)failure;

/**
 *  Set market message push status
 *  开启或者关闭 APP 营销类消息推送
 *
 *  @param enable      open or close
 *  @param success     Success block
 *  @param failure     Failure block
 */
- (void)setMarketingPushStatusWithStauts:(BOOL)enable success:(__nullable TYSuccessHandler)success failure:(__nullable TYFailureError)failure;

@end

NS_ASSUME_NONNULL_END

#endif
