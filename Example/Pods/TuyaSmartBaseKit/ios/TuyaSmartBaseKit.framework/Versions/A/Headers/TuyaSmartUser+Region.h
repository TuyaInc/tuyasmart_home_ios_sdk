//
//  TuyaSmartUser+Region.h
//  TYLoginModule2
//
//  Created by lan on 2019/2/15.
//

#import "TuyaSmartUser.h"
#import "TYRegionModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TuyaSmartUser (Region)

/**
 *  Get region list.
 *  获取区域列表
 *
 *  @param countryCode Country code
 *  @param success     Success block
 *  @param failure     Failure block
 */
- (void)regionListWithCountryCode:(NSString *)countryCode
                          success:(void(^)(NSArray<TYRegionModel *> *regionList))success
                          failure:(TYFailureError)failure;

/**
 *  Get degault region of the country code.`AY` for China, `AZ` for America, `EU` for Europe.
 *  获取国家码对应的默认地区, AY：中国，AZ：美国，EU：欧洲。
 *
 *  @param countryCode Country code
 *  @return return a default region of the country code.
 */
- (NSString *)getDefaultRegionWithCountryCode:(NSString *)countryCode;

/**
 *  Get default domain.
 *  获取默认域名
 *
 *  MQTT: mobileMqttsUrl
 *  API:  mobileApiUrl
 *
 *  @return return a default region of the country code.
 */
- (NSDictionary *)getDefaultDomain;

/**
 *  Send verification code, used for register/login/reset password.
 *  发送验证码，用于注册、登录、重设密码
 *
 *  @param userName    Mobile phone number or Email address
 *  @param region      for register is required, use [TuyaSmartUser
 *                     regionListWithCountryCode:success:failure:] or
 *                     [TuyaSmartUser getDefaultRegionWithCountryCode:] to get region
 *  @param countryCode Country code
 *  @param type        1: mobile phone verification code register,
 *                     2: mobile phone verification code login,
 *                     3: mobile phone password reset.
 *  @param success     Success block
 *  @param failure     Failure block
 */
- (void)sendVerifyCodeWithUserName:(NSString *)userName
                            region:(NSString *_Nullable)region
                       countryCode:(NSString *)countryCode
                              type:(NSInteger)type
                           success:(TYSuccessHandler)success
                           failure:(TYFailureError)failure;

/**
 *  Check verification code, used for register/login/reset password.
 *  验证验证码，用于注册、登录、重设密码
 *
 *  @param userName    Mobile phone number or Email address
 *  @param region      for register is required, use [TuyaSmartUser
 *                     regionListWithCountryCode:success:failure:] or
 *                     [TuyaSmartUser getDefaultRegionWithCountryCode:] to get region
 *  @param countryCode Country code
 *  @param code        Verification code
 *  @param type        1: mobile phone verification code register,
 *                     2: mobile phone verification code login,
 *                     3: mobile phone password reset.
 *  @param success     Success block
 *  @param failure     Failure block
 */
- (void)checkCodeWithUserName:(NSString *)userName
                       region:(NSString *_Nullable)region
                  countryCode:(NSString *)countryCode
                         code:(NSString *)code
                         type:(NSInteger)type
                      success:(TYSuccessBOOL)success
                      failure:(TYFailureError)failure;

/**
 *  Mobile phone & Email register.
 *  手机+邮箱注册
 *
 *  @param userName    Mobile phone number or Email address
 *  @param region      The region to register account, use [TuyaSmartUser
 *                     regionListWithCountryCode:success:failure:] or
 *                     [TuyaSmartUser getDefaultRegionWithCountryCode:] to get region
 *  @param countryCode Country code
 *  @param code        Verification code
 *  @param password    Password
 *  @param success     Success block
 *  @param failure     Failure block
 */
- (void)registerWithUserName:(NSString *)userName
                      region:(NSString *)region
                 countryCode:(NSString *)countryCode
                        code:(NSString *)code
                    password:(NSString *)password
                     success:(TYSuccessHandler)success
                     failure:(TYFailureError)failure;

/**
 *  Switch the region of logged in user.
 *  切换已登录用户的地区
 *
 *  WARNING:
 *      1. switch user region is same as register a new account to the region
 *         of user. becaues of GDPR, switch region will not take user's device
 *         and scene to the new account.Only take user information to the new
 *         account.
 *      2. When account switch to the new region, old account only reserved
 *         for 30 days.After 30 days, old account will be deleted.
 *      3. If switch region success, new account will be logined.
 *
 *  @param region      The region to register account, use [TuyaSmartUser
 *                     regionListWithCountryCode:success:failure:] or
 *                     [TuyaSmartUser getDefaultRegionWithCountryCode:] to get region
 *  @param success     Success block
 *  @param failure     Failure block
 */
- (void)switchUserRegion:(NSString *)region
                 success:(TYSuccessHandler)success
                 failure:(TYFailureError)failure;

@end

NS_ASSUME_NONNULL_END
