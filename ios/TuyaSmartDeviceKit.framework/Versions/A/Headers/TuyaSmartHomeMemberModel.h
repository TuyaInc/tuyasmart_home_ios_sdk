//
//  TuyaSmartHomeMemberModel.h
//  TuyaSmartKit
//
//  Created by 冯晓 on 2017/12/18.
//  Copyright © 2017年 Tuya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TuyaSmartHomeMemberModel : NSObject

// 成员Id
@property (nonatomic, assign) long long memberId;

// 成员头像
@property (nonatomic, strong) NSString *headPic;

// 成员名字
@property (nonatomic, strong) NSString *name;

// 是否管理员
@property (nonatomic, assign) BOOL isAdmin;

// 家庭Id
@property (nonatomic, assign) long long homeId;

// 账号
@property (nonatomic, strong) NSString *mobile;

// 用户名
@property (nonatomic, strong) NSString *userName;

// 用户Id
@property (nonatomic, strong) NSString *uid;

// 处理状态
@property (nonatomic, assign) NSInteger dealStatus;

@end
