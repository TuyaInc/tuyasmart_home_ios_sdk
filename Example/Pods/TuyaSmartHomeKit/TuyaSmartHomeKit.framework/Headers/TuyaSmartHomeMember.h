//
//  TuyaSmartHomeMember.h
//  TuyaSmartKit
//
//  Created by 冯晓 on 2017/12/18.
//  Copyright © 2017年 Tuya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TuyaSmartHomeMemberModel.h"

@interface TuyaSmartHomeMember : NSObject

/**
 *  添加家庭成员
 *
 *  @param homeId      家庭ID
 *  @param countryCode 国家码
 *  @param account     用户账号
 *  @param name        备注名字
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
                        failure:(TYFailureError)failure;


/**
 *  获取家庭成员列表
 *
 *  @param homeId      家庭ID
 *  @param success     操作成功回调
 *  @param failure     操作失败回调
 */
- (void)getHomeMemberListWithHomeId:(long long)homeId
                            success:(void(^)(NSArray <TuyaSmartHomeMemberModel *> *memberList))success
                            failure:(TYFailureError)failure;


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
 *  修改家庭成员信息
 *
 *  @param memberId    家庭成员ID
 *  @param name        备注名字
 *  @param isAdmin     是否是管理员
 *  @param success     操作成功回调
 *  @param failure     操作失败回调
 */
- (void)updateHomeMemberNameWithMemberId:(long long)memberId
                                    name:(NSString *)name
                                 isAdmin:(BOOL)isAdmin
                                 success:(TYSuccessHandler)success
                                 failure:(TYFailureError)failure;


@end
