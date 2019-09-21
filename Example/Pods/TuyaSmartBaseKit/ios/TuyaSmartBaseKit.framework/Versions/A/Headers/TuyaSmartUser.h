//
//  TuyaSmartUser.h
//  TuyaSmartKit
//
//  Created by fengyu on 15/8/31.
//  Copyright (c) 2015年 Tuya. All rights reserved.
//

#ifndef TuyaSmart_TuyaSmartUser
#define TuyaSmart_TuyaSmartUser

#import <UIKit/UIKit.h>
#import <TuyaSmartUtil/TuyaSmartUtil.h>

NS_ASSUME_NONNULL_BEGIN

/// Notification will be sent when user session is invalid.
/// 当用户登录信息过期后发出的通知
extern NSString *const TuyaSmartUserNotificationUserSessionInvalid;

/// User register type
/// 账号注册的类型
typedef NS_ENUM(NSInteger, TYRegType) {
    TYRegEmailType,         // Register from email
    TYRegPhoneType,         // Register from mobile phone
    TYRegOtherType,         // Register from other
    TYRegQQType,            // Register from QQ
    TYRegWeiboType,         // Register from Weibo
    TYRegFacebookType,      // Register from Facebook
    TYRegTwitterType,       // Register from Twitter
    TYRegWechatType         // Register from Wechat
};

/// User-related functions.
/// 用户相关功能
@interface TuyaSmartUser : NSObject

/// Singleton
+ (instancetype)sharedInstance;

/// Session ID
@property (nonatomic, strong, readonly) NSString *sid;

/// User ID
@property (nonatomic, strong, readonly) NSString *uid;

/// Head icon
@property (nonatomic, strong, readonly) NSString *headIconUrl;

/// Nick name
@property (nonatomic, strong, readonly) NSString *nickname;

/// Username. If account is mobile phone, this is mobile phone. If account is email, this is email.
/// 用户名。如果主账号是手机号，userName就是手机号.如果主账号是邮箱，userName就是邮箱。
@property (nonatomic, strong, readonly) NSString *userName;

/// Mobile phone
@property (nonatomic, strong, readonly) NSString *phoneNumber;

/// Email
@property (nonatomic, strong, readonly) NSString *email;

/// Country code. `86` for China, `1` for America.
/// 国家区号。86：中国，1：美国。
@property (nonatomic, strong, readonly) NSString *countryCode;

/// Login state
@property (nonatomic, assign, readonly) BOOL isLogin;

/// The region code of current account. `AY` for China, `AZ` for America, `EU` for Europe.
/// 当前账号所在的国家区域。AY：中国，AZ：美国，EU：欧洲。
@property (nonatomic, strong, readonly) NSString *regionCode;

/// The api domains of current account region.
/// 当前账号所在区域的接口域名地址
@property (nonatomic, strong, readonly) NSDictionary *domain;

/// Timezone ID. e.g. `Asia/Shanghai`.
/// 用户时区信息
@property (nonatomic, strong, readonly) NSString *timezoneId;

@property (nonatomic, strong, readonly) NSString *partnerIdentity;

/// mqtt host
/// mqtt 域名
@property (nonatomic, strong, readonly) NSString *mbHost;

@property (nonatomic, strong, readonly) NSString *gwHost;

/// mqtt port
/// mqtt 端口号
@property (nonatomic, assign, readonly) NSInteger port;

/// SSL
/// 是否开启SSL
@property (nonatomic, assign, readonly) BOOL useSSL;

/// Temperature unit. 1 for `°C`, 2 for `°F`.
/// 温度单位。1：`°C`， 2：`°F`。
@property (nonatomic, assign) NSInteger tempUnit;

/// User register type
/// 账号注册的类型
@property (nonatomic, assign, readonly) TYRegType regFrom;

/// Nickname of sns account.
/// 第三方账号的昵称
@property (nonatomic, strong, readonly) NSString *snsNickname;

@property (nonatomic, strong, readonly) NSString *ecode;


#pragma mark - Mobile phone verification code login

/**
 *  Send verification code. Used for mobile phone verification code login, register, password reset.
 *  发送验证码，用于手机验证码登录/注册，手机密码重置。
 *
 *  @param countryCode Country code
 *  @param phoneNumber Mobile phone number
 *  @param type        0: mobile phone verification code login, 1: mobile phone verification code register, 2: mobile phone password reset.
 *  @param success     Success block
 *  @param failure     Failure block
 */
- (void)sendVerifyCode:(NSString *)countryCode
           phoneNumber:(NSString *)phoneNumber
                  type:(NSInteger)type
               success:(nullable TYSuccessHandler)success
               failure:(nullable TYFailureError)failure;

/**
 *  Send verification code. Used for mobile phone bind, mobile phone change.
 *  发送验证码，用于手机验证码绑定手机号，更换手机号。
 *
 *  @param countryCode Country code
 *  @param phoneNumber Mobile phone number
 *  @param success     Success block
 *  @param failure     Failure block
 */
- (void)sendBindVerifyCode:(NSString *)countryCode
               phoneNumber:(NSString *)phoneNumber
                   success:(nullable TYSuccessHandler)success
                   failure:(nullable TYFailureError)failure;

/**
 *  Mobile phone verification code login and register.
 *  手机验证码登录和注册
 *
 *  @param countryCode Country code
 *  @param phoneNumber Mobile phone number
 *  @param code        Verification code
 *  @param success     Success block
 *  @param failure     Failure block
 */
- (void)login:(NSString *)countryCode
  phoneNumber:(NSString *)phoneNumber
         code:(NSString *)code
      success:(nullable TYSuccessHandler)success
      failure:(nullable TYFailureError)failure;

/**
 *  Mobile phone bind.
 *  手机绑定
 *
 *  @param countryCode Country code
 *  @param phoneNumber Mobile phone number
 *  @param code        Verification code
 *  @param success     Success block
 *  @param failure     Failure block
 */
- (void)mobileBinding:(NSString *)countryCode
          phoneNumber:(NSString *)phoneNumber
                 code:(NSString *)code
              success:(nullable TYSuccessHandler)success
              failure:(nullable TYFailureError)failure;

#pragma mark - Mobile phone password login

/**
 *  Mobile phone register.
 *  手机注册
 *
 *  @param countryCode Country code
 *  @param phoneNumber Mobile phone number
 *  @param password    Password
 *  @param code        Verification code
 *  @param success     Success block
 *  @param failure     Failure block
 */
- (void)registerByPhone:(NSString *)countryCode
            phoneNumber:(NSString *)phoneNumber
               password:(NSString *)password
                   code:(NSString *)code
                success:(nullable TYSuccessHandler)success
                failure:(nullable TYFailureError)failure;

/**
 *  Mobile phone password login.
 *  手机密码登录
 *
 *  @param countryCode Country code
 *  @param phoneNumber Mobile phone number
 *  @param password    Password
 *  @param success     Success block
 *  @param failure     Failure block
 */
- (void)loginByPhone:(NSString *)countryCode
         phoneNumber:(NSString *)phoneNumber
            password:(NSString *)password
             success:(nullable TYSuccessHandler)success
             failure:(nullable TYFailureError)failure;

/**
 *  Mobile phone password reset.
 *  手机密码重置
 *
 *  @param countryCode Country code
 *  @param phoneNumber Mobile phone number
 *  @param newPassword New password
 *  @param code        Verification code
 *  @param success     Success block
 *  @param failure     Failure block
 */
- (void)resetPasswordByPhone:(NSString *)countryCode
                 phoneNumber:(NSString *)phoneNumber
                 newPassword:(NSString *)newPassword
                        code:(NSString *)code
                     success:(nullable TYSuccessHandler)success
                     failure:(nullable TYFailureError)failure;

#pragma mark - Email login 1.0

/**
 *  Email register 1.0.
 *  邮箱注册  1.0
 *
 *  @param countryCode Country code
 *  @param email       Email
 *  @param password    Password
 *  @param success     Success block
 *  @param failure     Failure block
 */
- (void)registerByEmail:(NSString *)countryCode
                  email:(NSString *)email
               password:(NSString *)password
                success:(nullable TYSuccessHandler)success
                failure:(nullable TYFailureError)failure;

/**
 *  Email login.
 *  邮箱登录
 *
 *  @param countryCode Country code
 *  @param email       Email
 *  @param password    Password
 *  @param success     Success block
 *  @param failure     Failure block
 */
- (void)loginByEmail:(NSString *)countryCode
               email:(NSString *)email
            password:(NSString *)password
             success:(nullable TYSuccessHandler)success
             failure:(nullable TYFailureError)failure;

/**
 *  Send verification code, used for email password reset.
 *  发送验证码，用于邮箱密码重置
 *
 *  @param countryCode Country code
 *  @param email       Email
 *  @param success     Success block
 *  @param failure     Failure block
 */
- (void)sendVerifyCodeByEmail:(NSString *)countryCode
                        email:(NSString *)email
                      success:(nullable TYSuccessHandler)success
                      failure:(nullable TYFailureError)failure;

/**
 *  Email password reset.
 *  邮箱密码重置
 *
 *  @param countryCode Country code
 *  @param email       Email
 *  @param newPassword New password
 *  @param code        Verification code
 *  @param success     Success block
 *  @param failure     Failure block
 */
- (void)resetPasswordByEmail:(NSString *)countryCode
                       email:(NSString *)email
                 newPassword:(NSString *)newPassword
                        code:(NSString *)code
                     success:(nullable TYSuccessHandler)success
                     failure:(nullable TYFailureError)failure;


#pragma mark - Email register 2.0

/**
 *  Send verification code, used for email password register.
 *  发送验证码，用于邮箱注册
 *
 *  @param countryCode Country code
 *  @param email       Email
 *  @param success     Success block
 *  @param failure     Failure block
 */
- (void)sendVerifyCodeByRegisterEmail:(NSString *)countryCode
                                email:(NSString *)email
                              success:(nullable TYSuccessHandler)success
                              failure:(nullable TYFailureError)failure;

/**
 *  Email register 2.0.
 *  邮箱注册 2.0
 *
 *  @param countryCode Country code
 *  @param email       Email
 *  @param password    Password
 *  @param code        Verification code
 *  @param success     Success block
 *  @param failure     Failure block
 */
- (void)registerByEmail:(NSString *)countryCode
                  email:(NSString *)email
               password:(NSString *)password
                   code:(NSString *)code
                success:(nullable TYSuccessHandler)success
                failure:(nullable TYFailureError)failure;

#pragma mark - verification code login

/**
 *  Email verification code login.
 *  邮箱验证码登录
 *
 *  @param email       Email
 *  @param countryCode Country code
 *  @param code        Verification code
 *  @param success     Success block
 *  @param failure     Failure block
 */
- (void)loginWithEmail:(NSString *)email countryCode:(NSString *)countryCode code:(NSString *)code success:(TYSuccessHandler)success failure:(TYFailureError)failure;

/**
 *  Modile phone verification code login.
 *  手机验证码登录
 *
 *  @param mobile      Mobile phone number
 *  @param countryCode Country code
 *  @param code        Verification code
 *  @param success     Success block
 *  @param failure     Failure block
 */
- (void)loginWithMobile:(NSString *)mobile countryCode:(NSString *)countryCode code:(NSString *)code success:(TYSuccessHandler)success failure:(TYFailureError)failure;

#pragma mark - uid login

/**
 *  uid register.
 *  uid注册
 *
 *  @param uid         User ID
 *  @param password    Password
 *  @param countryCode Country code
 *  @param success     Success block
 *  @param failure     Failure block
 */
- (void)registerByUid:(NSString *)uid
             password:(NSString *)password
          countryCode:(NSString *)countryCode
              success:(nullable TYSuccessHandler)success
              failure:(nullable TYFailureError)failure;

/**
 *  uid login.
 *  uid登录
 *
 *  @param uid         User ID
 *  @param password    Password
 *  @param countryCode Country code
 *  @param success     Success block
 *  @param failure     Failure block
 */
- (void)loginByUid:(NSString *)uid
          password:(NSString *)password
       countryCode:(NSString *)countryCode
           success:(nullable TYSuccessHandler)success
           failure:(nullable TYFailureError)failure;

/**
 *  uid login/register. The account will be registered at first login.
 *  uid 登录注册接口（如果没有注册就注册，如果注册就登录）
 *
 *  @param countryCode  Country code
 *  @param uid          User ID
 *  @param password     Password
 *  @param success      Success block
 *  @param failure      Failure block
 */
- (void)loginOrRegisterWithCountryCode:(NSString *)countryCode
                                   uid:(NSString *)uid
                              password:(NSString *)password
                               success:(nullable TYSuccessHandler)success
                               failure:(nullable TYFailureError)failure;

/**
 *  uid login/register. The account will be registered at first login.
 *  uid 登录注册接口（如果没有注册就注册，如果注册就登录）
 *
 *  @param countryCode  Country code
 *  @param uid          User ID
 *  @param password     Password
 *  @param createHome   Create default home
 *  @param success      Success block
 *  @param failure      Failure block
 */
- (void)loginOrRegisterWithCountryCode:(NSString *)countryCode
                                   uid:(NSString *)uid
                              password:(NSString *)password
                            createHome:(BOOL)createHome
                               success:(nullable TYSuccessID)success
                               failure:(nullable TYFailureError)failure;

/**
 *  uid login/register. The account will be registered at first login.
 *  uid 登录注册接口（如果没有注册就注册，如果注册就登录）
 *
 *  @param countryCode  Country code
 *  @param uid          User ID
 *  @param password     Password
 *  @param success      Success block
 *  @param failure      Failure block
 */
- (void)loginOrRegisterByPhone:(NSString *)countryCode
                           uid:(NSString *)uid
                      password:(NSString *)password
                       success:(nullable TYSuccessHandler)success
                       failure:(nullable TYFailureError)failure
DEPRECATED_MSG_ATTRIBUTE("use loginOrRegisterWithCountryCode:uid:password:success:failure: instead");

/**
 *  uid login/register. The account will be registered at first login.
 *  uid 登录注册接口（如果没有注册就注册，如果注册就登录）
 *
 *  @param countryCode  Country code
 *  @param uid          User ID
 *  @param password     Password
 *  @param createHome   Create default home
 *  @param success      Success block
 *  @param failure      Failure block
 */
- (void)loginOrRegisterByPhone:(NSString *)countryCode
                           uid:(NSString *)uid
                      password:(NSString *)password
                    createHome:(BOOL)createHome
                       success:(nullable TYSuccessID)success
                       failure:(nullable TYFailureError)failure
DEPRECATED_MSG_ATTRIBUTE("use loginOrRegisterWithCountryCode:uid:password:createHome:success:failure: instead");


#pragma mark - Social login

/**
 *  QQ login.
 *  QQ登录
 *
 *  @param countryCode Country code
 *  @param userId userId from QQ authorization login
 *  @param accessToken accessToken from QQ authorization login
 *  @param success Success block
 *  @param failure Failure block
 */
- (void)loginByQQ:(NSString *)countryCode
           userId:(NSString *)userId
      accessToken:(NSString *)accessToken
          success:(nullable TYSuccessHandler)success
          failure:(nullable TYFailureError)failure;

/**
 *  Wechat login.
 *  微信登录
 *
 *  @param countryCode Country code
 *  @param code code from Wechat authorization login
 *  @param success Success block
 *  @param failure Failure block
 */
- (void)loginByWechat:(NSString *)countryCode
                 code:(NSString *)code
              success:(nullable TYSuccessHandler)success
              failure:(nullable TYFailureError)failure;


/**
 *  Facebook Login.
 *  Facebook登录
 *
 *  @param countryCode Country code
 *  @param token token from Facebook authorization login
 *  @param success Success block
 *  @param failure Failure block
 */
- (void)loginByFacebook:(NSString *)countryCode
                  token:(NSString *)token
                success:(nullable TYSuccessHandler)success
                failure:(nullable TYFailureError)failure;



/**
 *  Twitter login.
 *  Twitter登录
 *
 *  @param countryCode Country code
 *  @param key key from Twitter authorization login
 *  @param secret secret from Twitter authorization login
 *  @param success Success block
 *  @param failure Failure block
 */
- (void)loginByTwitter:(NSString *)countryCode
                   key:(NSString *)key
                secret:(NSString *)secret
               success:(nullable TYSuccessHandler)success
               failure:(nullable TYFailureError)failure;


#pragma mark -

/**
 *  Logout.
 *  登出
 *
 *  @param success Success block
 *  @param failure Failure block
 */
- (void)loginOut:(nullable TYSuccessHandler)success
         failure:(nullable TYFailureError)failure;

/**
 *  Edit nick name.
 *  修改昵称
 *
 *  @param nickName Nick name
 *  @param success  Success block
 *  @param failure  Failure block
 */
- (void)updateNickname:(NSString *)nickName
               success:(nullable TYSuccessHandler)success
               failure:(nullable TYFailureError)failure;

/**
 *  Edit head icon.
 *  修改头像
 *
 *  @param headIcon Head icon
 *  @param success  Success block
 *  @param failure  Failure block
 */
- (void)updateHeadIcon:(UIImage *)headIcon
               success:(nullable TYSuccessHandler)success
               failure:(nullable TYFailureError)failure;


/**
 *  Update user information.
 *  更新用户信息
 *
 *  @param success Success block
 *  @param failure Failure block
 */
- (void)updateUserInfo:(nullable TYSuccessHandler)success
               failure:(nullable TYFailureError)failure;


/**
 *  Edit user timezone information.
 *  更新用户时区
 *
 *  @param timeZoneId TimeZone ID. e.g. `Asia/Shanghai`.
 *  @param success    Success block
 *  @param failure    Failure block
 */
- (void)updateTimeZoneWithTimeZoneId:(NSString *)timeZoneId
                             success:(nullable TYSuccessHandler)success
                             failure:(nullable TYFailureError)failure;

/**
 *  Edit user temperature unit
 *  更新用户温度单位
 *
 *  @param tempUnit   Temperature unit. 1 for `°C`, 2 for `°F`.
 *  @param success    Success block
 *  @param failure    Failure block
 */
- (void)updateTempUnitWithTempUnit:(NSInteger)tempUnit
                           success:(nullable TYSuccessHandler)success
                           failure:(nullable TYFailureError)failure;

/**
 *  Destory account. One week after, all of the account information will be removed from server forever. If you login before removed, the destory request will be canceled.
 *  停用帐号（注销用户）
 *  一周后账号才会永久停用并删除以下你账户中的所有信息，在此之前重新登录，则你的停用请求将被取消
 *
 *  @param success Success block
 *  @param failure Failure block
 */
- (void)cancelAccount:(nullable TYSuccessHandler)success
              failure:(nullable TYFailureError)failure;


#pragma mark -

/// Cancel network request
- (void)cancelRequest;

@end

#endif

NS_ASSUME_NONNULL_END
