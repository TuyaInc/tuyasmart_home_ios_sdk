//
//  TYLoginAndRegisterView.h
//  TuyaSmartHomeKit_Example
//
//  Created by Kennaki Kai on 2018/11/30.
//  Copyright © 2018 xuchengcheng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, TYLoginAndRegisterViewType) {
    TYLoginAndRegisterViewTypeLogin,
    TYLoginAndRegisterViewTypeRegister,
};

typedef NS_ENUM(NSInteger, TYLoginAndRegisterViewActionType) {
    TYLoginAndRegisterViewActionTypeLogin,
    TYLoginAndRegisterViewActionTypeSendVerifyCode,
    TYLoginAndRegisterViewActionTypeRegister,
};

@protocol TYLoginAndRegisterViewDelegate <NSObject>

- (void)loginAndRegisterViewTrigerredAction:(TYLoginAndRegisterViewActionType)actionType;

@end

@interface TYDemoLoginAndRegisterView : UIView <UITextFieldDelegate>

- (instancetype)initWithType:(TYLoginAndRegisterViewType)type;

@property (nonatomic, assign) id<TYLoginAndRegisterViewDelegate> delegate;

@property (nonatomic, strong) UITextField *countryCodeField;//for example: 86
@property (nonatomic, strong) UITextField *accountField;//phone number or e-mail.
@property (nonatomic, strong) UITextField *passwordField;
@property (nonatomic, strong) UITextField *verifyCodeField;//verify code from your short messages.

@end

NS_ASSUME_NONNULL_END
