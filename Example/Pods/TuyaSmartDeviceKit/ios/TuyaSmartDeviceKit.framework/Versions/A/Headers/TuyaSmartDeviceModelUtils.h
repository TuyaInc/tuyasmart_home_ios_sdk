//
//  TuyaSmartDeviceModelUtils.h
//  TuyaSmartDeviceKit
//
//  Created by Hemin Won on 2019/8/16.
//

#ifndef TuyaSmartDeviceModelUtils_h
#define TuyaSmartDeviceModelUtils_h


typedef NS_ENUM(NSInteger, TYHomeRoleType) {
    TYHomeRoleType_Unknown = -999,  /**< 家庭角色 无效 invalid role */
    TYHomeRoleType_Custom  = -1,  /**< 自定义角色 home custom role */
    TYHomeRoleType_Member  = 0,   /**< 家庭普通成员 home ordinary member*/
    TYHomeRoleType_Admin,         /**< 家庭管理员 无增删除其他管理员权限 home admin, can't add or remove other admin */
    TYHomeRoleType_Owner,         /**< 家庭超级管理员 拥有者 home owner, have all authority */
};

typedef NS_ENUM(NSUInteger, TYHomeStatus) {
    TYHomeStatusPending = 1,      /**< 待加入 受邀者未决定是否加入对应家庭 Not deciding whether to join the home */
    TYHomeStatusAccept,           /**< 受邀者已同意加入对应家庭 The invitee has agreed to join the home */
    TYHomeStatusReject            /**< 受邀者已拒绝加入对应家庭 The invitee have refused to join the home */
};


#endif /* TuyaSmartDeviceModelUtils_h */
