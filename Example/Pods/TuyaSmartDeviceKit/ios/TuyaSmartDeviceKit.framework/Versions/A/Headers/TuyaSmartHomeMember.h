//
//  TuyaSmartHomeMember.h
//  TuyaSmartKit
//
//  Created by 冯晓 on 2017/12/18.
//  Copyright © 2017年 Tuya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TuyaSmartHomeMemberModel.h"
#import "TuyaSmartHomeMemberRequestModel.h"

@interface TuyaSmartHomeMember : NSObject

#pragma mark - deprecated

/**
 *  Add a home member
 *  添加家庭成员
 *
 *  @param homeId      Home Id
 *  @param countryCode Country code
 *  @param account     User account
 *  @param name        Note name
 *  @param isAdmin     Whether the administrator
 *  @param success     Success block
 *  @param failure     Failure block
 */
- (void)addHomeMemberWithHomeId:(long long)homeId
                    countryCode:(NSString *)countryCode
                        account:(NSString *)account
                           name:(NSString *)name
                        isAdmin:(BOOL)isAdmin
                        success:(TYSuccessHandler)success
                        failure:(TYFailureError)failure __deprecated_msg("This method is deprecated, Use -[TuyaSmartHome -  addHomeMemberWithName:headPic:countryCode:userAccount:isAdmin:success:failure:] instead");

/**
 *  Update home member info
 *  修改家庭成员信息
 *
 *  @param memberId    Member Id
 *  @param name        Note name
 *  @param isAdmin     Whether the administrator
 *  @param success     Success block
 *  @param failure     Failure block
 */
- (void)updateHomeMemberNameWithMemberId:(long long)memberId
                                    name:(NSString *)name
                                 isAdmin:(BOOL)isAdmin
                                 success:(TYSuccessHandler)success
                                 failure:(TYFailureError)failure __deprecated_msg("This method is deprecated, Use -[TuyaSmartHomeMember - (void)updateHomeMemberInfoWithMemberId:name:headPic:isAdmin:success:failure:] instead");

/**
 *  添加家庭成员
 *
 *  @param groupId      家庭组ID
 *  @param name         家庭成员名字
 *  @param headPic      家庭成员头像
 *  @param countryCode  国家码
 *  @param account      用户账号
 *  @param admin        是否是管理员
 *  @param success      操作成功回调
 *  @param failure      操作失败回调
 */
- (void)addHomeMemberWithHomeId:(long long)groupId
                           name:(NSString *)name
                        headPic:(UIImage *)headPic
                    countryCode:(NSString *)countryCode
                    userAccount:(NSString *)account
                        isAdmin:(BOOL)admin
                        success:(TYSuccessDict)success
                        failure:(TYFailureError)failure __deprecated_msg("This method is deprecated, Use -[TuyaSmartHome -  addHomeMemberWithName:headPic:countryCode:userAccount:isAdmin:success:failure:] instead");


/**
 *  Get home member list
 *  获取家庭成员列表
 *
 *  @param homeId      Home Id
 *  @param success     Success block
 *  @param failure     Failure block
 */
- (void)getHomeMemberListWithHomeId:(long long)homeId
                            success:(void(^)(NSArray <TuyaSmartHomeMemberModel *> *memberList))success
                            failure:(TYFailureError)failure __deprecated_msg("This method is deprecated, Use -[TuyaSmartHome - (void)getHomeMemberListWithSuccess:failure:] instead");

#pragma mark - public

/**
 *  Remove a home member
 *  删除家庭成员
 *
 *  @param memberId    Member Id
 *  @param success     Success block
 *  @param failure     Failure block
 */
- (void)removeHomeMemberWithMemberId:(long long)memberId
                             success:(TYSuccessHandler)success
                             failure:(TYFailureError)failure;

/**
 *  Update home member info
 *  修改家庭成员信息
 *
 *  @param memberId    Member Id
 *  @param name        Note name
 *  @param headPic     Portrait
 *  @param isAdmin     Whether the administrator
 *  @param success     Success block
 *  @param failure     Failure block
 */
- (void)updateHomeMemberInfoWithMemberId:(long long)memberId
                                    name:(NSString *)name
                                 headPic:(UIImage *)headPic
                                 isAdmin:(BOOL)isAdmin
                                 success:(TYSuccessHandler)success
                                 failure:(TYFailureError)failure  __deprecated_msg("This method will be deprecated and remove, Use [TuyaSmartHomeMember - (void)updateHomeMemberInfoWithMemberRequestModel:success:failure:]");


/**
 Update home member info
 修改家庭成员信息

 @param memberRequestModel request model, Set the corresponding property
 @param success            success callback
 @param failure            failure callcack
 */
- (void)updateHomeMemberInfoWithMemberRequestModel:(TuyaSmartHomeMemberRequestModel *)memberRequestModel
                                           success:(TYSuccessHandler)success
                                           failure:(TYFailureError)failure;

/**
 *  Update home member note name
 *  更新家庭成员备注名称
 *
 *  @param memberId    Member Id
 *  @param name        Note name
 *  @param isAdmin     Whether the administrator
 *  @param success     Success block
 *  @param failure     Failure block
 */
- (void)updateHomeMemberRemarkNameWithMemberId:(long long)memberId
                                          name:(NSString *)name
                                       isAdmin:(BOOL)isAdmin
                                       success:(TYSuccessHandler)success
                                       failure:(TYFailureError)failure;

/**
 *  Update home member portrait
 *  更新家庭成员头像
 *
 *  @param memberId    Member Id
 *  @param headPic     Portrait
 *  @param isAdmin     Whether the administrator
 *  @param success     Success block
 *  @param failure     Failure block
 */
- (void)updateHomeMemberHeadPicWithMemberId:(long long)memberId
                                    headPic:(UIImage *)headPic
                                    isAdmin:(BOOL)isAdmin
                                    success:(TYSuccessHandler)success
                                    failure:(TYFailureError)failure;

/**
 *  Update home member management authority
 *  更新家庭成员管理权限
 *
 *  @param memberId    Member Id
 *  @param isAdmin     Whether the administrator
 *  @param success     Success block
 *  @param failure     Failure block
 */
- (void)updateHomeMemberAdminWithMemberId:(long long)memberId
                                  isAdmin:(BOOL)isAdmin
                                  success:(TYSuccessHandler)success
                                  failure:(TYFailureError)failure;

@end
