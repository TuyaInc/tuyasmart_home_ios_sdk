//
//  TPSignUpViewController.h
//  fishNurse
//
//  Created by 高森 on 16/2/23.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TPBaseViewController.h"

typedef enum : NSUInteger {
    TPVerifyTypeSignUp,//注册
    TPVerifyTypeReset,//重置密码
    TPVerifyTypeModify,//修改密码
    TPVerifyTypeLogin,//登录
} TPVerifyType;


@interface TPSignUpViewController : TPBaseViewController

@property (nonatomic, strong) NSString *countryCode;
@property (nonatomic, strong) NSString *userAccount;

@property (nonatomic, assign) TPVerifyType type;

@end
