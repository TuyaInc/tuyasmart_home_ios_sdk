//
//  TuyaSmartUser+DeprecatedApi.h
//  TuyaSmartBaseKit
//
//  Created by zhukw on 2020/3/26.
//

#import "TuyaSmartUser.h"

NS_ASSUME_NONNULL_BEGIN

@interface TuyaSmartUser (DeprecatedApi)

#pragma mark email

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
                failure:(nullable TYFailureError)failure
DEPRECATED_MSG_ATTRIBUTE("use registerByEmail:email:password:code:success:failure: instead");


#pragma mark phone

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
      failure:(nullable TYFailureError)failure
DEPRECATED_MSG_ATTRIBUTE("use loginWithMobile:countryCode:code:success:failure: instead");

#pragma mark Uid

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
              failure:(nullable TYFailureError)failure
DEPRECATED_MSG_ATTRIBUTE("use loginOrRegisterWithCountryCode:uid:password:createHome:success:failure: instead");

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
           failure:(nullable TYFailureError)failure
DEPRECATED_MSG_ATTRIBUTE("use loginOrRegisterWithCountryCode:uid:password:createHome:success:failure: instead");

/**
 *  uid login/register. The account will be registered at first login.
 *  uid 登录注册接口（如果没有注册就注册，如果注册就登录），不自动创建家庭
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
                               failure:(nullable TYFailureError)failure
DEPRECATED_MSG_ATTRIBUTE("use loginOrRegisterWithCountryCode:uid:password:createHome:success:failure: instead");

@end

NS_ASSUME_NONNULL_END
