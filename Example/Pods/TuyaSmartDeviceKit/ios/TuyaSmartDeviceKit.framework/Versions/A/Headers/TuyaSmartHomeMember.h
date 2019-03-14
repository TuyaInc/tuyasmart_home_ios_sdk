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
#import "TuyaSmartMemberLinkDeviceListModel.h"

@interface TuyaSmartHomeMember : NSObject

#pragma mark - interface before app version 3.7.1

/**
 *  添加家庭成员
 *
 *  @param homeId      家庭ID
 *  @param countryCode 国家码
 *  @param account     用户账号
 *  @param name        备注名称
 *  @param isAdmin     是否是管理员
 *  @param success     操作成功回调
 *  @param failure     操作失败回调
 */
- (void)addHomeMemberWithHomeId:(long long)homeId
                    countryCode:(NSString *)countryCode
                        account:(NSString *)account
                           name:(NSString *)name
                        isAdmin:(BOOL)isAdmin
                        success:(TYSuccessHandler)success
                        failure:(TYFailureError)failure __deprecated_msg("This method is deprecated, Use -[TuyaSmartHome -  addHomeMemberWithName:headPic:countryCode:userAccount:isAdmin:success:failure:] instead");

/**
 *  修改家庭成员信息
 *
 *  @param memberId    家庭成员ID
 *  @param name        备注名
 *  @param isAdmin     是否是管理员
 *  @param success     操作成功回调
 *  @param failure     操作失败回调
 */
- (void)updateHomeMemberNameWithMemberId:(long long)memberId
                                    name:(NSString *)name
                                 isAdmin:(BOOL)isAdmin
                                 success:(TYSuccessHandler)success
                                 failure:(TYFailureError)failure __deprecated_msg("This method is deprecated, Use -[TuyaSmartHomeMember - (void)updateHomeMemberInfoWithMemberId:name:headPic:isAdmin:success:failure:] instead");

/**
 *  获取家庭成员列表
 *
 *  @param homeId      家庭ID
 *  @param success     操作成功回调
 *  @param failure     操作失败回调
 */
- (void)getHomeMemberListWithHomeId:(long long)homeId
                            success:(void(^)(NSArray <TuyaSmartHomeMemberModel *> *memberList))success
                            failure:(TYFailureError)failure __deprecated_msg("This method is deprecated, Use -[TuyaSmartHome - (void)getHomeMemberListWithSuccess:failure:] instead");

#pragma mark - interface after app version 3.7.1


/**
 *  删除家庭成员
 *
 *  @param memberId    家庭成员ID
 *  @param success     操作成功回调
 *  @param failure     操作失败回调
 */
- (void)removeHomeMemberWithMemberId:(long long)memberId
                             success:(TYSuccessHandler)success
                             failure:(TYFailureError)failure;

/**
 *  更新家庭成员信息
 *
 *  @param memberId    家庭成员ID
 *  @param name        备注名称
 *  @param headPic     头像
 *  @param isAdmin     是否是管理员
 *  @param success     操作成功回调
 *  @param failure     操作失败回调
 */
- (void)updateHomeMemberInfoWithMemberId:(long long)memberId
                                    name:(NSString *)name
                                 headPic:(UIImage *)headPic
                                 isAdmin:(BOOL)isAdmin
                                 success:(TYSuccessHandler)success
                                 failure:(TYFailureError)failure;

/**
 *  更新家庭成员备注名称
 *
 *  @param memberId    家庭成员ID
 *  @param name        备注名称
 *  @param isAdmin     是否是管理员
 *  @param success     操作成功回调
 *  @param failure     操作失败回调
 */
- (void)updateHomeMemberRemarkNameWithMemberId:(long long)memberId
                                          name:(NSString *)name
                                       isAdmin:(BOOL)isAdmin
                                       success:(TYSuccessHandler)success
                                       failure:(TYFailureError)failure;

/**
 *  更新家庭成员头像
 *
 *  @param memberId    家庭成员ID
 *  @param headPic     头像
 *  @param isAdmin     是否是管理员
 *  @param success     操作成功回调
 *  @param failure     操作失败回调
 */
- (void)updateHomeMemberHeadPicWithMemberId:(long long)memberId
                                    headPic:(UIImage *)headPic
                                    isAdmin:(BOOL)isAdmin
                                    success:(TYSuccessHandler)success
                                    failure:(TYFailureError)failure;

/**
 *  更新家庭成员管理权限
 *
 *  @param memberId    家庭成员ID
 *  @param isAdmin     是否是管理员
 *  @param success     操作成功回调
 *  @param failure     操作失败回调
 */
- (void)updateHomeMemberAdminWithMemberId:(long long)memberId
                                  isAdmin:(BOOL)isAdmin
                                  success:(TYSuccessHandler)success
                                  failure:(TYFailureError)failure;

@end
