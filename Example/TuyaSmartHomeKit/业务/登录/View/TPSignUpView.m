//
//  TPSignUpView.m
//  fishNurse
//
//  Created by 高森 on 16/2/23.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TPSignUpView.h"

@interface TPSignUpView() <TPTextFieldViewDelegate>

@property (nonatomic, strong) TPTextFieldView *phoneTextFieldView;
@property (nonatomic, strong) TPTextFieldView *verifyCodeTextFieldView;
@property (nonatomic, strong) TPTextFieldView *passwordTextFieldView;
@property (nonatomic, strong) UIButton        *sendVerifyCodeButton;
@property (nonatomic, strong) UIButton        *confirmButton;
@property (nonatomic, strong) UILabel         *tipsLabel;
@property (nonatomic, strong) UILabel         *userAccountLabel;

@property (nonatomic, assign) BOOL            needVerifyCode;
@property (nonatomic, assign) TPVerifyType    type;

@end

@implementation TPSignUpView

- (instancetype)initWithFrame:(CGRect)frame needVerifyCode:(BOOL)needVerifyCode type:(TPVerifyType)type {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = MAIN_BACKGROUND_COLOR;
        
        [self addSubview:self.topBarView];
        
        _needVerifyCode = needVerifyCode;
        _type = type;
        
        if (needVerifyCode) {
            [self addSubview:self.tipsLabel];
            [self addSubview:self.userAccountLabel];
            [self addSubview:self.verifyCodeTextFieldView];
            [self addSubview:self.sendVerifyCodeButton];
        } else {
            self.passwordTextFieldView.top = APP_TOP_BAR_HEIGHT + 20;
        }
        [self addSubview:self.passwordTextFieldView];
        [self addSubview:self.confirmButton];
        
        [self.verifyCodeTextFieldView.textField addTarget:self action:@selector(passwordTextFieldChanged:) forControlEvents:UIControlEventEditingChanged];
        [self.passwordTextFieldView.textField addTarget:self action:@selector(passwordTextFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    return self;
}

- (void)setUserAccount:(NSString *)userAccount {
    _userAccount = userAccount;
    if ([userAccount rangeOfString:@"@"].length == 0) {
        self.tipsLabel.text = NSLocalizedString(@"code_has_send_to_phone", @"");
        self.userAccountLabel.text = [NSString stringWithFormat:@"+%@ %@", _countryCode, _userAccount];
        
        _verifyCodeTextFieldView.textField.keyboardType = UIKeyboardTypeNumberPad;
    } else {
        self.tipsLabel.text = NSLocalizedString(@"code_has_send_to_email", @"");
        self.userAccountLabel.text = userAccount;
        
        _verifyCodeTextFieldView.textField.keyboardType = UIKeyboardTypeASCIICapable;
    }
    
    if (_type == TPVerifyTypeModify) {
        self.tipsLabel.text = NSLocalizedString(@"ty_current_bind_phone_tip", @"");
    }
}

- (NSString *)verifyCode {
    return _verifyCodeTextFieldView.text;
}

- (NSString *)password {
    return _passwordTextFieldView.text;
}

- (UILabel *)tipsLabel {
    if (!_tipsLabel) {
        _tipsLabel = [TPViewUtil labelWithFrame:CGRectMake(15, APP_TOP_BAR_HEIGHT + 20, APP_SCREEN_WIDTH - 30, 20) fontSize:14 color:LIST_SUB_TEXT_COLOR];
        _tipsLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _tipsLabel;
}

- (UILabel *)userAccountLabel {
    if (!_userAccountLabel) {
        _userAccountLabel = [TPViewUtil labelWithFrame:CGRectMake(15, self.tipsLabel.bottom + 4, APP_SCREEN_WIDTH - 30, 22) fontSize:16 color:MAIN_COLOR];
        _userAccountLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _userAccountLabel;
}

- (TPTextFieldView *)verifyCodeTextFieldView {
    if (!_verifyCodeTextFieldView) {
        _verifyCodeTextFieldView = [[TPTextFieldView alloc] initWithFrame:CGRectMake(15, self.userAccountLabel.bottom + 20, self.width - 130 - 30, 44)];
        _verifyCodeTextFieldView.backgroundColor = LIST_BACKGROUND_COLOR;
        _verifyCodeTextFieldView.roundCorner = YES;
        _verifyCodeTextFieldView.topLineHidden = YES;
        _verifyCodeTextFieldView.bottomLineHidden = YES;
        _verifyCodeTextFieldView.placeholder = NSLocalizedString(@"input_verification_code", @"");
    }
    return _verifyCodeTextFieldView;
}

- (UIButton *)sendVerifyCodeButton {
    if (!_sendVerifyCodeButton) {
        _sendVerifyCodeButton = [TPViewUtil buttonWithFrame:CGRectMake(self.width - 120 - 15, self.verifyCodeTextFieldView.top, 120, 44) fontSize:16 bgColor:BUTTON_BACKGROUND_COLOR textColor:BUTTON_TEXT_COLOR borderColor:nil];
        [_sendVerifyCodeButton setTitle:NSLocalizedString(@"login_get_code", @"") forState:UIControlStateNormal];
        [_sendVerifyCodeButton addTarget:self action:@selector(sendVerifyCodeButtonTap) forControlEvents:UIControlEventTouchUpInside];
//        [self disableSendVerifyCodeButton:nil];
    }
    return _sendVerifyCodeButton;
}

- (TPTextFieldView *)passwordTextFieldView {
    if (!_passwordTextFieldView) {
        _passwordTextFieldView = [[TPTextFieldView alloc] initWithFrame:CGRectMake(15, self.verifyCodeTextFieldView.bottom + 10, self.width - 30, 44)];
        _passwordTextFieldView.backgroundColor = LIST_BACKGROUND_COLOR;
        _passwordTextFieldView.roundCorner = YES;
        _passwordTextFieldView.topLineHidden = YES;
        _passwordTextFieldView.bottomLineHidden = YES;
        if (_type == TPVerifyTypeSignUp) {
            _passwordTextFieldView.placeholder = NSLocalizedString(@"please_input_password", @"");
        } else {
            _passwordTextFieldView.placeholder = NSLocalizedString(@"input_new_password", @"");
        }
        _passwordTextFieldView.delegate = self;
        _passwordTextFieldView.textField.keyboardType = UIKeyboardTypeASCIICapable;
        _passwordTextFieldView.textField.secureTextEntry = YES;
        [self textFieldRightItemViewTap];
    }
    return _passwordTextFieldView;
}

- (UIButton *)confirmButton {
    if (!_confirmButton) {
        _confirmButton = [TPViewUtil buttonWithFrame:CGRectMake(15, self.passwordTextFieldView.bottom + 16, self.width - 30, 44) fontSize:18 bgColor:BUTTON_BACKGROUND_COLOR textColor:BUTTON_TEXT_COLOR borderColor:nil];
        [_confirmButton setTitle:NSLocalizedString(@"confirm", @"") forState:UIControlStateNormal];
        [_confirmButton addTarget:self action:@selector(confirmButtonTap) forControlEvents:UIControlEventTouchUpInside];
        [self disableConfirmButton];
    }
    return _confirmButton;
}

- (void)sendVerifyCodeButtonTap {
    [_verifyCodeTextFieldView.textField becomeFirstResponder];
    
    if ([self.delegate respondsToSelector:@selector(signUpViewSendVerifyCodeButtonTap:)]) {
        [self.delegate signUpViewSendVerifyCodeButtonTap:self];
    }
}

- (void)enableSendVerifyCodeButton:(NSString *)title {
    _sendVerifyCodeButton.backgroundColor = BUTTON_BACKGROUND_COLOR;
    [_sendVerifyCodeButton setEnabled:YES];
    if (title != nil) {
        [_sendVerifyCodeButton setTitle:title forState:UIControlStateNormal];
    }
}

- (void)disableSendVerifyCodeButton:(NSString *)title {
    _sendVerifyCodeButton.backgroundColor = SEPARATOR_LINE_COLOR;
    [_sendVerifyCodeButton setEnabled:NO];
    if (title != nil) {
        [_sendVerifyCodeButton setTitle:title forState:UIControlStateNormal];
    }
}

- (void)enableConfirmButton {
    [_confirmButton setEnabled:YES];
    _confirmButton.backgroundColor = BUTTON_BACKGROUND_COLOR;
}

- (void)disableConfirmButton {
    [_confirmButton setEnabled:NO];
    [_confirmButton setBackgroundColor:SEPARATOR_LINE_COLOR];
}

- (void)confirmButtonTap {
    if ([self.delegate respondsToSelector:@selector(signUpViewConfirmButtonTap:)]) {
        [self.delegate signUpViewConfirmButtonTap:self];
    }
}

- (void)passwordTextFieldChanged:(UITextField *)textField {
    if (_needVerifyCode) {
        if (self.verifyCode.length > 0 && self.password.length > 0) {
            [self enableConfirmButton];
        } else {
            [self disableConfirmButton];
        }
    } else {
        if (self.password.length > 0) {
            [self enableConfirmButton];
        } else {
            [self disableConfirmButton];
        }
    }
}

#pragma mark - TPTextFieldViewDelegate

- (void)textFieldRightItemViewTap {
    _passwordTextFieldView.textField.secureTextEntry = !_passwordTextFieldView.textField.secureTextEntry;
    _passwordTextFieldView.rightImage = [UIImage imageNamed:_passwordTextFieldView.textField.secureTextEntry ? @"ty_login_password_no" : @"ty_login_password"];
}

@end
