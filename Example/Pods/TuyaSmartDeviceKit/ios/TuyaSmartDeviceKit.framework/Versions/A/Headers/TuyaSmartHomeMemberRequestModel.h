//
//  TuyaSmartHomeMemberRequestModel.h
//  Pods
//
//  Created by Hemin Won on 2019/8/18.
//

#import <Foundation/Foundation.h>
#import "TuyaSmartHomeModelUtils.h"

NS_ASSUME_NONNULL_BEGIN

@interface TuyaSmartHomeMemberRequestModel : NSObject

/** 成员ID 必传字段 member Id is required */
@property (nonatomic, assign) long long memberId;

/** 成员名称 nil时不会更新已有名称 name of member */
@property (nonatomic, strong) NSString *name;

/**
 * 成员角色 请正确设置你想设置的角色类型，若不想更新角色类型可以保持当前角色类型或设为 “TYHomeRoleType_Unknown”
 * role，Please set the type of role you want to set. If don't want to update role type keep TYHomeRoleType_Unknown or current role type
 */
@property (nonatomic, assign) TYHomeRoleType role;

/** 成员头像 nil时不会更新已有头像 Head portraits of members Can be nil */
@property (nonatomic, strong) UIImage *headPic;

@end

NS_ASSUME_NONNULL_END
