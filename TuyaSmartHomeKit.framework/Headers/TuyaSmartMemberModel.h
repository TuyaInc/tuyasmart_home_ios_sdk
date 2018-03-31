//
//  TuyaSmartMemberModel.h
//  TuyaSmartKit
//
//  Created by 高森 on 15/12/29.
//  Copyright © 2015年 Tuya. All rights reserved.
//

#ifndef TuyaSmart_TuyaSmartMemberModel
#define TuyaSmart_TuyaSmartMemberModel

#import "TYModel.h"
#import "TuyaSmartDevice.h"
#import "TuyaSmartGroup.h"

@interface TuyaSmartMemberModel : TYModel

/**
 *  成员Id
 */
@property (nonatomic, assign) NSInteger memberId;

/**
 *  备注名称
 */
@property (nonatomic, strong) NSString  *nickName;

/**
 *  用户名(手机号/邮箱号)
 */
@property (nonatomic, strong) NSString  *userName;

/**
 *  设备列表
 */
@property (nonatomic, strong) NSArray<TuyaSmartDeviceModel *> *deviceList;

/**
 *  群组列表
 */
@property (nonatomic, strong) NSArray<TuyaSmartGroupModel *> *groupList;

@end

#endif
