//
//  TuyaSmartHomeDeviceShare.h
//  TuyaSmartKit
//
//  Created by 冯晓 on 2018/1/9.
//  Copyright © 2018年 Tuya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TuyaSmartShareMemberModel.h"
#import "TuyaSmartShareMemberDetailModel.h"
#import "TuyaSmartReceiveMemberDetailModel.h"
#import "TuyaSmartReceivedShareUserModel.h"
#import "TuyaSmartShareDeviceModel.h"


///  Sharing device related functions (based on device dimension sharing)
///  共享设备相关功能 （基于家庭的设备维度的共享）
@interface TuyaSmartHomeDeviceShare : NSObject

/**
 Add Shares
 添加共享
 
 @param homeId      homeId
 @param countryCode countryCode
 @param userAccount userAccount
 @param devIds      devId list
 @param success     Success block
 @param failure     Failure block
 */
- (void)addShareWithHomeId:(long long)homeId
               countryCode:(NSString *)countryCode
               userAccount:(NSString *)userAccount
                    devIds:(NSArray <NSString *> *)devIds
                   success:(void(^)(TuyaSmartShareMemberModel *model))success
                   failure:(TYFailureError)failure;


/**
 Add Shares (new, not overwriting old Shares)
 添加共享 （新增，不覆盖旧的分享）
 
 @param memberId    memberId
 @param devIds      devId list
 @param success     Success block
 @param failure     Failure block
 */
- (void)addShareWithMemberId:(NSInteger)memberId
                      devIds:(NSArray <NSString *> *)devIds
                     success:(TYSuccessHandler)success
                     failure:(TYFailureError)failure;


/**
 Get a list of all active shared users in the home
 获取家庭下所有主动共享的用户列表
 
 @param homeId  homeId
 @param success Success block
 @param failure Failure block
 */
- (void)getShareMemberListWithHomeId:(long long)homeId
                             success:(void(^)(NSArray<TuyaSmartShareMemberModel *> *list))success
                             failure:(TYFailureError)failure;


/**
 Get a list of all shared users received
 获取所有收到共享的用户列表
 
 @param success Success block
 @param failure Failure block
 */
- (void)getReceiveMemberListWithSuccess:(void(^)(NSArray<TuyaSmartShareMemberModel *> *list))success
                                failure:(TYFailureError)failure;


/**
 Obtaining shared data that is actively shared by user
 获取单个 主动共享 的用户共享数据
 
 @param memberId memberId
 @param success  Success block
 @param failure  Failure block
 */
- (void)getShareMemberDetailWithMemberId:(NSInteger)memberId
                                 success:(void(^)(TuyaSmartShareMemberDetailModel *model))success
                                 failure:(TYFailureError)failure;


/**
 Getting shared data from a Sharer
 获取单个 收到共享 的用户共享数据
 
 @param memberId    memberId
 @param success     Success block
 @param failure     Failure block
 */
- (void)getReceiveMemberDetailWithMemberId:(NSInteger)memberId
                                   success:(void(^)(TuyaSmartReceiveMemberDetailModel *model))success
                                   failure:(TYFailureError)failure;


/**
 Remove active Sharers
 删除主动共享者
 
 @param memberId memberId
 @param success  Success block
 @param failure  Failure block
 */
- (void)removeShareMemberWithMemberId:(NSInteger)memberId
                              success:(TYSuccessHandler)success
                              failure:(TYFailureError)failure;


/**
 Remove Received Sharer
 删除收到共享者
 
 @param memberId 共享成员ID
 @param success  Success block
 @param failure  Failure block
 */
- (void)removeReceiveShareMemberWithMemberId:(NSInteger)memberId
                                     success:(TYSuccessHandler)success
                                     failure:(TYFailureError)failure;


/**
 Modify the nickname of an active shared user
 修改某个主动共享用户的昵称
 
 @param memberId memberId
 @param name     nickname
 @param success  Success block
 @param failure  Failure block
 */
- (void)renameShareMemberNameWithMemberId:(NSInteger)memberId
                                     name:(NSString *)name
                                  success:(TYSuccessHandler)success
                                  failure:(TYFailureError)failure;


/**
 Modify the nickname of the Received sharer
 修改收到共享者的昵称
 
 @param memberId memberId
 @param name     nickname
 @param success  Success block
 @param failure  Failure block
 */
- (void)renameReceiveShareMemberNameWithMemberId:(NSInteger)memberId
                                            name:(NSString *)name
                                         success:(TYSuccessHandler)success
                                         failure:(TYFailureError)failure;


#pragma mark - 单设备共享操作

/**
 Device Add Sharing
 单设备添加共享
 
 @param homeId      homeId
 @param countryCode countryCode
 @param userAccount userAccount
 @param devId       devId
 @param success     Success block
 @param failure     Failure block
 */
- (void)addDeviceShareWithHomeId:(long long)homeId
                     countryCode:(NSString *)countryCode
                     userAccount:(NSString *)userAccount
                           devId:(NSString *)devId
                         success:(void(^)(TuyaSmartShareMemberModel *model))success
                         failure:(TYFailureError)failure;


/**
 Remove Received Shared
 删除收到的共享设备
 
 @param devId   DevId
 @param success Success block
 @param failure Failure block
 */
- (void)removeReceiveDeviceShareWithDevId:(NSString *)devId
                                  success:(TYSuccessHandler)success
                                  failure:(TYFailureError)failure;


/**
 remove shares to members
 删除分享出去的设备
 
 @param memberId    member Id
 @param devId       devdId
 @param success     Success block
 @param failure     Failure block
 */
- (void)removeDeviceShareWithMemberId:(NSInteger)memberId
                                devId:(NSString *)devId
                              success:(TYSuccessHandler)success
                              failure:(TYFailureError)failure;


/**
 获取设备共享用户列表
 
 @param devId   设备号
 @param success Success block
 @param failure Failure block
 */
- (void)getDeviceShareMemberListWithDevId:(NSString *)devId
                                  success:(void(^)(NSArray<TuyaSmartShareMemberModel *> *list))success
                                  failure:(TYFailureError)failure;


/**
 Get Device Sharing from
 获取设备分享来自哪里
 
 @param devId   devId
 @param success Success block
 @param failure Failure block
 */
- (void)getShareInfoWithDevId:(NSString *)devId
                      success:(void(^)(TuyaSmartReceivedShareUserModel *model))success
                      failure:(TYFailureError)failure;

/**
 Invite to share with other users
 邀请分享给其他用户
 
 @param countryCode countryCode
 @param userAccount userAccount
 @param devId       devId
 @param success     Success block
 @param failure     Failure block
 */
- (void)inviteShareWithCountryCode:(NSString *)countryCode
                       userAccount:(NSString *)userAccount
                             devId:(NSString *)devId
                           success:(TYSuccessInt)success
                           failure:(TYFailureError)failure;

/**
 Confirm invite share
 确认分享接口
 
 @param shareId     邀请分享接口返回的shareId
 @param success     Success block
 @param failure     Failure block
 */
- (void)confirmInviteShareWithShareId:(NSInteger)shareId
                              success:(TYSuccessHandler)success
                              failure:(TYFailureError)failure;

#pragma mark - group share

/**
 Get a list of shared users for group (reflected in the panel)
 获取单个群组共享用户列表(面板中体现)
 
 @param groupId groupId
 @param success Success block
 @param failure Failure block
 */
- (void)getGroupShareMemberListWithGroupId:(NSString *)groupId
                                   success:(void(^)(NSArray<TuyaSmartShareMemberModel *> *list))success
                                   failure:(TYFailureError)failure;

/**
 Sharing Groups to Other Users
 分享群组给其他用户
 
 @param homeId      HomeId
 @param countryCode Country Code
 @param userAccount User Account
 @param groupId     GroupId
 @param success     Success block
 @param failure     Failure block
 */

- (void)addGroupShareToMemberWithHomeId:(long long)homeId
                             countyCode:(NSString *)countryCode
                            userAccount:(NSString *)userAccount
                                groupId:(NSString *)groupId
                                success:(TYSuccessID)success
                                failure:(TYFailureError)failure;

/**
 Get group share information
 获取群组的分享信息
 
 @param groupId groupId
 @param success Success block
 @param failure Failure block
 */

- (void)getShareGroupFromInfoWithGroupId:(NSString *)groupId
                                 success:(TYSuccessID)success
                                 failure:(TYFailureError)failure;

/**
 Group Remove Sharing
 移除分享群组
 
 @param groupId 群组号
 @param success Success block
 @param failure Failure block
 */

- (void)removeShareGroupWithGroupId:(NSString *)groupId
                            success:(TYSuccessID)success
                            failure:(TYFailureError)failure;

/**
 Remove group sharing of other members
 移除其他成员的群组分享
 
 @param relationId  relationId
 @param groupId     groupId
 @param success     Success block
 @param failure     Failure block
 */
- (void)removeGroupShareWithRelationId:(NSInteger)relationId
                               groupId:(NSString *)groupId
                               success:(TYSuccessHandler)success
                               failure:(TYFailureError)failure;



@end
