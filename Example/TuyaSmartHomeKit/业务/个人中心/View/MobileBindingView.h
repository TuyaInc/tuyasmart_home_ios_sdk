//
//  MobileBindingView.h
//  TuyaSmartPublic
//
//  Created by remy on 16/3/29.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TPBaseLayout.h"

@class MobileBindingView;

@protocol MobileBindingViewDelegate <NSObject>

- (void)bindingViewCountrySelectViewTap:(MobileBindingView *)bindingView;
- (void)bindingViewSendVerifyCodeButtonTap:(MobileBindingView *)bindingView;
- (void)bindingViewBindingButtonTap:(MobileBindingView *)bindingView;

//获取计数状态
- (BOOL)getCountStatus;

@end

@interface MobileBindingView : TPBaseLayout

@property (nonatomic, weak) id<MobileBindingViewDelegate> delegate;

@property (nonatomic, strong) NSString *phoneNumber;
@property (nonatomic, strong) NSString *verifyCode;
@property (nonatomic, strong) NSString *password;

- (void)setCountryCode:(TPCountryModel *)countryCodeModel;

- (void)enableSendVerifyCodeButton:(NSString *)title;
- (void)disableSendVerifyCodeButton:(NSString *)title;
- (void)enableBindingButton;
- (void)disableBindingButton;

@end
