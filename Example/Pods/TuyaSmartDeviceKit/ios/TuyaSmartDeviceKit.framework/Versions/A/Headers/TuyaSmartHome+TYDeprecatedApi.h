//
//  TuyaSmartHome+TYDeprecatedApi.h
//  TuyaSmartDeviceKit
//
//  Created by Hemin Won on 2020/5/21.
//

#import "TuyaSmartHome.h"

NS_ASSUME_NONNULL_BEGIN

@interface TuyaSmartHome (TYDeprecatedApi)

/**
 *  Add a home member
 *  添加家庭成员 将会废弃
 *
 *  @param name         Member name
 *  @param headPic      Member portrait
 *  @param countryCode  Country code
 *  @param account      User account
 *  @param isAdmin      Whether the administrator
 *  @param success      Success block
 *  @param failure      Failure block
 */
- (void)addHomeMemberWithName:(NSString *)name
                      headPic:(UIImage *)headPic
                  countryCode:(NSString *)countryCode
                  userAccount:(NSString *)account
                      isAdmin:(BOOL)isAdmin
                      success:(TYSuccessDict)success
                      failure:(TYFailureError)failure __deprecated_msg("This method is deprecated, Use [TuyaSmartHome   addHomeMemberWithName:headPic:countryCode:userAccount:role:success:failure:]");

/**
 *  Add a home member
 *  添加家庭成员
 *
 *  @param name         Member name
 *  @param headPic      Member portrait
 *  @param countryCode  Country code
 *  @param account      User account
 *  @param role         home role type
 *  @param success      Success block
 *  @param failure      Failure block
 */
- (void)addHomeMemberWithName:(NSString *)name
                      headPic:(UIImage *)headPic
                  countryCode:(NSString *)countryCode
                  userAccount:(NSString *)account
                         role:(TYHomeRoleType)role
                      success:(TYSuccessDict)success
                      failure:(TYFailureError)failure __deprecated_msg("This method is deprecated, Use [TuyaSmartHome addHomeMemberWithAddMemeberRequestModel:success:failure:]");

@end

NS_ASSUME_NONNULL_END
