//
//  SignInView.h
//  TuyaSmart
//
//  Created by fengyu on 15/2/9.
//  Copyright (c) 2015年 Tuya. All rights reserved.
//

#import "TPBaseLayout.h"

@class TPSignInView;

@protocol TPSignInViewDelegate <NSObject>

- (void)signInViewCountrySelectViewTap:(TPSignInView *)signInView;
- (void)signInViewSendVerifyCodeButtonTap:(TPSignInView *)signInView;
- (void)signInViewSignInButtonTap:(TPSignInView *)signInView;
- (void)signInViewPhoneCodeLoginButtonTap:(TPSignInView *)signInView;
- (void)signInViewResetPassButtonTap:(TPSignInView *)signInView;

//获取计数状态
- (BOOL)getCountStatus;

@end

@interface TPSignInView : TPBaseLayout

@property (nonatomic, weak) id<TPSignInViewDelegate> delegate;

@property (nonatomic, strong) NSString *phoneNumber;
@property (nonatomic, strong) NSString *verifyCode;
@property (nonatomic, strong) NSString *password;

- (void)setCountryCode:(TPCountryModel *)countryCodeModel;

- (void)enableSendVerifyCodeButton:(NSString *)title;
- (void)disableSendVerifyCodeButton:(NSString *)title;
- (void)enableSignInButton;
- (void)disableSignInButton;

- (instancetype)initWithFrame:(CGRect)frame phoneCodeLogin:(BOOL)flag;

@end
