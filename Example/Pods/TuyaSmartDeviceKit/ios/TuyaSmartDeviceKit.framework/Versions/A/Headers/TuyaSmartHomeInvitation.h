//
//  TuyaSmartHomeInvitation.h
//  TuyaSmartDeviceKit
//
//  Created by Hemin Won on 2020/4/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TuyaSmartHomeInvitation : NSObject

/// 邀请码方式邀请新成员 invitation code invite home member
/// @param createRequestModel 请求Model createRequestModel
/// @param success 成功回调 success
/// @param failure 失败回调 failure
- (void)createInvitationWithCreateRequestModel:(TuyaSmartHomeInvitationCreateRequestModel *)createRequestModel
                                       success:(void(^)(TuyaSmartHomeInvitationResultModel *invitationResultModel))success
                                       failure:(TYFailureError)failure;

/// 取消邀请 cancel invitation
/// @param invitationID invitation ID
/// @param success 成功回调 success
/// @param failure 失败回调 failure
- (void)cancelInvitationWithInvitationID:(NSNumber *)invitationID
                                 success:(TYSuccessBOOL)success
                                 failure:(TYFailureError)failure;

/// 重新邀请成员 reinvite member
/// @param reinviteRequestModel 重新邀请Model reinviteRequestModel
/// @param success 成功回调 success
/// @param failure 失败回调 failure
- (void)reinviteInvitationWithReinviteRquestModel:(TuyaSmartHomeInvitationReinviteRequestModel *)reinviteRequestModel
                                          success:(void(^)(TuyaSmartHomeInvitationResultModel *invitationResultModel))success
                                          failure:(TYFailureError)failure;

/// 获取邀请记录列表信息 fetch invitation record list
/// @param homeID 家庭 ID homeID
/// @param success 成功回调 success
/// @param failure 失败回调 failure
- (void)fetchInvitationRecordListWithHomeID:(long long)homeID
                                    success:(void(^)(NSArray<TuyaSmartHomeInvitationRecordModel *> *invitationRecordList))success
                                    failure:(TYFailureError)failure;

/// 更新邀请信息 update invitation info
/// @param invitationInfoRequestModel 邀请信息请求Model invitationInfoRequestModel
/// @param success 成功回调 success
/// @param failure 失败回调 failure
- (void)updateInvitationInfoWithInvitationInfoRequestModel:(TuyaSmartHomeInvitationInfoRequestModel *)invitationInfoRequestModel
                                                   success:(TYSuccessBOOL)success
                                                   failure:(TYFailureError)failure;


/// 获取邀请者的家庭信息 fetch home info from invitation code
/// @param invitationCode 邀请码 invitation code
/// @param success 成功回调 success
/// @param failure 失败回调 failure
- (void)fetchInvitationHomeInfoWithInvitationCode:(NSString *)invitationCode
                                          success:(void(^)(TuyaSmartHomeModel *homeModel))success
                                          failure:(TYFailureError)failure;

/// 加入家庭 join home
/// @param invitationCode 邀请码 invitation code
/// @param success 成功回调 success
/// @param failure 失败回调 failure
- (void)joinHomeWithInvitationCode:(NSString *)invitationCode
                           success:(TYSuccessBOOL)success
                           failure:(TYFailureError)failure;
@end

NS_ASSUME_NONNULL_END
