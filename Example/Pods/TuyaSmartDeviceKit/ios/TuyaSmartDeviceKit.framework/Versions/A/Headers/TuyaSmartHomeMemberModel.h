//
//  TuyaSmartHomeMemberModel.h
//  TuyaSmartKit
//
//  Created by 冯晓 on 2017/12/18.
//  Copyright © 2017年 Tuya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TuyaSmartDeviceModelUtils.h"

@interface TuyaSmartHomeMemberModel : NSObject

// member Id
@property (nonatomic, assign) long long memberId;

// Head portraits of members
@property (nonatomic, strong) NSString *headPic;

// name of members
@property (nonatomic, strong) NSString *name;

// admin or not
@property (nonatomic, assign) BOOL isAdmin __deprecated_msg("The property will be deprecated and remove in a future version，Please use role");

// role
@property (nonatomic, assign) TYHomeRoleType role;

// home Id
@property (nonatomic, assign) long long homeId;

// mobile
@property (nonatomic, strong) NSString *mobile;

// user name
@property (nonatomic, strong) NSString *userName;

// uid
@property (nonatomic, strong) NSString *uid;

// state of deal
@property (nonatomic, assign) TYHomeStatus dealStatus;

@end
