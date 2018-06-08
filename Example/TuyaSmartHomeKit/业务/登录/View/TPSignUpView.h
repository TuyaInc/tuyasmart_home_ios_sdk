//
//  TPSignUpView.h
//  fishNurse
//
//  Created by 高森 on 16/2/23.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TPBaseLayout.h"
#import "TPSignUpViewController.h"

@class TPSignUpView;

@protocol TPSignUpViewDelegate <NSObject>

- (void)signUpViewSendVerifyCodeButtonTap:(TPSignUpView *)signUpView;
- (void)signUpViewConfirmButtonTap:(TPSignUpView *)signUpView;

//获取计数状态
- (BOOL)getCountStatus;

@end

@interface TPSignUpView : TPBaseLayout

@property (nonatomic, weak) id<TPSignUpViewDelegate> delegate;

@property (nonatomic, strong) NSString *countryCode;
@property (nonatomic, strong) NSString *userAccount;

@property (nonatomic, strong) NSString *verifyCode;
@property (nonatomic, strong) NSString *password;


- (void)enableSendVerifyCodeButton:(NSString *)title;
- (void)disableSendVerifyCodeButton:(NSString *)title;

- (instancetype)initWithFrame:(CGRect)frame needVerifyCode:(BOOL)needVerifyCode type:(TPVerifyType)type;

@end
