//
//  TuyaSmartReceivedShareUserModel.h
//  TuyaSmartKit
//
//  Created by 冯晓 on 2018/1/9.
//  Copyright © 2018年 Tuya. All rights reserved.
//

#import "TYModel.h"


@interface TuyaSmartReceivedShareUserModel : TYModel

// 用户name
@property (nonatomic, strong) NSString *name;

// 手机号
@property (nonatomic, strong) NSString *mobile;

// 邮箱
@property (nonatomic, strong) NSString *email;


@end
