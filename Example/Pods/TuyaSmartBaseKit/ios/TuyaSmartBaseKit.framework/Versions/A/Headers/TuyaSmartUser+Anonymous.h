//
//  TuyaSmartUser+Anonymous.h
//  TuyaSmartBaseKit
//
//  Created by XuChengcheng on 2020/7/28.
//

#import "TuyaSmartUser.h"

NS_ASSUME_NONNULL_BEGIN

@interface TuyaSmartUser (Anonymous)

/**
 *  Anonymous register
 *  匿名注册
 *
 *  @param countryCode Country code
 *  @param userName    User Name, e.g. : [UIDevice currentDevice].name
 *  @param success     Success block
 *  @param failure     Failure block
 */
- (void)registerAnonymousWithCountryCode:(NSString *)countryCode
                                userName:(NSString *)userName
                                 success:(nullable TYSuccessHandler)success
                                 failure:(nullable TYFailureError)failure;

/**
 *  delete anonymous account
 *  删除匿名账号
 *
 *  @param success     Success block
 *  @param failure     Failure block
 */
- (void)deleteAnonymousAccountWithSuccess:(TYSuccessHandler)success
                                  failure:(TYFailureError)failure;

/**
 *  bind username
 *  绑定匿名账号
 *
 *  @param countryCode Country code
 *  @param userName    Mobile phone number or Email address
 *  @param code        verification code
 *  @param password    password
 *  @param success     Success block
 *  @param failure     Failure block
 */
- (void)usernameBindingWithCountryCode:(NSString *)countryCode
                              userName:(NSString *)userName
                                  code:(NSString *)code
                              password:(NSString *)password
                               success:(nullable TYSuccessHandler)success
                               failure:(nullable TYFailureError)failure;

@end

NS_ASSUME_NONNULL_END
