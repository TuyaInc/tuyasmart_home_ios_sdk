//
//  SignInView.m
//  TuyaSmart
//
//  Created by fengyu on 15/2/9.
//  Copyright (c) 2015年 Tuya. All rights reserved.
//

#import "TPSignInView.h"
#import "TPCellView.h"
#import "TPTextFieldView.h"
#import "TPBarButtonItem.h"

@interface TPSignInView() <TPCellViewDelegate, TPTextFieldViewDelegate>

@property (nonatomic, strong) UIView          *centerView;
@property (nonatomic, strong) UIView          *bottomView;

@property (nonatomic, strong) TPCellView      *countrySelectView;
@property (nonatomic, strong) TPTextFieldView *phoneTextFieldView;
@property (nonatomic, strong) TPTextFieldView *verifyCodeTextFieldView;
@property (nonatomic, strong) TPTextFieldView *passwordTextFieldView;
@property (nonatomic, strong) UIButton        *sendVerifyCodeButton;
@property (nonatomic, strong) UIButton        *signInButton;

@property (nonatomic, strong) UIButton        *phoneCodeLoginButton;
@property (nonatomic, strong) UIButton        *resetPassButton;

@property (nonatomic, assign) BOOL            phoneCodeLogin;

@end

@implementation TPSignInView

- (instancetype)initWithFrame:(CGRect)frame phoneCodeLogin:(BOOL)phoneCodeLogin {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = MAIN_BACKGROUND_COLOR;
        
        _phoneCodeLogin = phoneCodeLogin;
        
        [self addSubview:self.centerView];
        [self addSubview:self.bottomView];
        
        self.centerView.top = APP_TOP_BAR_HEIGHT + 20;
        self.bottomView.bottom = APP_SCREEN_HEIGHT - 20;
        
        
        [self.centerView addSubview:self.countrySelectView];
        [self.centerView addSubview:self.phoneTextFieldView];
        
        
        if (phoneCodeLogin == YES) { //手机验证码登录
            self.topBarView.leftItem = [TPBarButtonItem cancelItem:self action:@selector(topBarLeftItemTap)];
            self.topBarView.centerItem.title = NSLocalizedString(@"ty_login_sms", @"");
            self.topBarView.rightItem = nil;
            
            [self.centerView addSubview:self.verifyCodeTextFieldView];
            [self.centerView addSubview:self.sendVerifyCodeButton];
            
            self.bottomView.hidden = YES;
        } else { //手机,邮箱密码登录
            self.topBarView.leftItem = nil;
            self.topBarView.centerItem.title = NSLocalizedString(@"login", @"");
            self.topBarView.rightItem.title = NSLocalizedString(@"login_register", @"");
            
            [self.centerView addSubview:self.passwordTextFieldView];
            [self.centerView addSubview:self.phoneCodeLoginButton];
            [self.centerView addSubview:self.resetPassButton];
        }
        
        [self addSubview:self.topBarView];
        [self.centerView addSubview:self.signInButton];
        
        [self.phoneTextFieldView.textField addTarget:self action:@selector(identifyTextFieldChanged:) forControlEvents:UIControlEventEditingChanged];
        [self.verifyCodeTextFieldView.textField addTarget:self action:@selector(identifyTextFieldChanged:) forControlEvents:UIControlEventEditingChanged];
        [self.passwordTextFieldView.textField addTarget:self action:@selector(identifyTextFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    return self;
}

- (NSString *)phoneNumber {
    return _phoneTextFieldView.text;
}

- (NSString *)verifyCode {
    return _verifyCodeTextFieldView.text;
}

- (NSString *)password {
    return _passwordTextFieldView.text;
}

- (UIView *)centerView {
    if (!_centerView) {
        _centerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_SCREEN_WIDTH, 44 * 4 + 20 + 10 * 2 + 16 * 2)];
    }
    return _centerView;
}

- (TPCellView *)countrySelectView {
    if (!_countrySelectView) {
        _countrySelectView = [[TPCellView alloc] initWithFrame:CGRectMake(15, 0, self.width - 30, 44)];
        _countrySelectView.delegate = self;
        _countrySelectView.backgroundColor = LIST_BACKGROUND_COLOR;
        _countrySelectView.roundCorner = YES;
        _countrySelectView.topLineHidden = YES;
        _countrySelectView.bottomLineHidden = YES;
        
        _countrySelectView.leftItem = [TPCellViewItem cellItemWithTitle:NSLocalizedString(@"login_choose_country", @"") image:nil];
        _countrySelectView.leftItem.textColor = HEXCOLOR(0xBBBBC2);
        
        _countrySelectView.rightItem = [TPCellViewItem cellItemWithArrowImage:@""];
    }
    return _countrySelectView;
}

- (TPTextFieldView *)phoneTextFieldView {
    if (!_phoneTextFieldView) {
        _phoneTextFieldView = [[TPTextFieldView alloc] initWithFrame:CGRectMake(15, self.countrySelectView.bottom + 10, self.width - 30, 44)];
        _phoneTextFieldView.backgroundColor = LIST_BACKGROUND_COLOR;
        _phoneTextFieldView.roundCorner = YES;
        _phoneTextFieldView.topLineHidden = YES;
        _phoneTextFieldView.bottomLineHidden = YES;
        if (_phoneCodeLogin) {
            _phoneTextFieldView.placeholder = NSLocalizedString(@"input_telephone_number", @"");
            _phoneTextFieldView.textField.keyboardType = UIKeyboardTypeNumberPad;
        } else {
            _phoneTextFieldView.placeholder = NSLocalizedString(@"phone_email", @"");
            _phoneTextFieldView.textField.keyboardType = UIKeyboardTypeASCIICapable;
        }
        
    }
    return _phoneTextFieldView;
}

- (TPTextFieldView *)verifyCodeTextFieldView {
    if (!_verifyCodeTextFieldView) {
        _verifyCodeTextFieldView = [[TPTextFieldView alloc] initWithFrame:CGRectMake(15, self.phoneTextFieldView.bottom + 10, self.width - 130 - 30, 44)];
        _verifyCodeTextFieldView.backgroundColor = LIST_BACKGROUND_COLOR;
        _verifyCodeTextFieldView.roundCorner = YES;
        _verifyCodeTextFieldView.topLineHidden = YES;
        _verifyCodeTextFieldView.bottomLineHidden = YES;
        _verifyCodeTextFieldView.placeholder = NSLocalizedString(@"input_verification_code", @"");
        _verifyCodeTextFieldView.textField.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _verifyCodeTextFieldView;
}

- (UIButton *)sendVerifyCodeButton {
    if (!_sendVerifyCodeButton) {
        _sendVerifyCodeButton = [TPViewUtil buttonWithFrame:CGRectMake(self.width - 120 - 15,self.phoneTextFieldView.bottom + 10, 120, 44) fontSize:16 bgColor:BUTTON_BACKGROUND_COLOR textColor:BUTTON_TEXT_COLOR borderColor:nil];
        [_sendVerifyCodeButton setTitle:NSLocalizedString(@"login_get_code", @"") forState:UIControlStateNormal];
        [_sendVerifyCodeButton addTarget:self action:@selector(sendVerifyCodeButtonTap) forControlEvents:UIControlEventTouchUpInside];
        [self disableSendVerifyCodeButton:nil];
        _sendVerifyCodeButton.layer.cornerRadius = 6.f;
    }
    return _sendVerifyCodeButton;
}

- (TPTextFieldView *)passwordTextFieldView {
    if (!_passwordTextFieldView) {
        _passwordTextFieldView = [[TPTextFieldView alloc] initWithFrame:CGRectMake(15, self.phoneTextFieldView.bottom + 10, self.width - 30, 44)];
        _passwordTextFieldView.backgroundColor = LIST_BACKGROUND_COLOR;
        _passwordTextFieldView.roundCorner = YES;
        _passwordTextFieldView.topLineHidden = YES;
        _passwordTextFieldView.bottomLineHidden = YES;
        _passwordTextFieldView.placeholder = NSLocalizedString(@"input_password", @"");
        _passwordTextFieldView.delegate = self;
        _passwordTextFieldView.textField.keyboardType = UIKeyboardTypeASCIICapable;
//        _passwordTextFieldView.textField.secureTextEntry = YES;
        [self textFieldRightItemViewTap];
    }
    return _passwordTextFieldView;
}

- (UIButton *)signInButton {
    if (!_signInButton) {
        _signInButton = [TPViewUtil buttonWithFrame:CGRectMake(15, self.phoneTextFieldView.bottom + 70, self.width - 30, 44) fontSize:18 bgColor:BUTTON_BACKGROUND_COLOR textColor:BUTTON_TEXT_COLOR borderColor:nil];
        [_signInButton setTitle:NSLocalizedString(@"login", @"") forState:UIControlStateNormal];
        [_signInButton addTarget:self action:@selector(signInButtonTap) forControlEvents:UIControlEventTouchUpInside];
        [self disableSignInButton];
    }
    return _signInButton;
}

- (UIButton *)phoneCodeLoginButton {
    if (!_phoneCodeLoginButton) {
        _phoneCodeLoginButton = [TPViewUtil buttonWithFrame:CGRectMake(15, self.signInButton.bottom + 16, 200, 20) fontSize:14 bgColor:nil textColor:LIST_LIGHT_TEXT_COLOR borderColor:nil];
        [_phoneCodeLoginButton setTitle:NSLocalizedString(@"ty_login_sms_confirm", @"") forState:UIControlStateNormal];
        _phoneCodeLoginButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_phoneCodeLoginButton addTarget:self action:@selector(phoneCodeLoginButtonTap) forControlEvents:UIControlEventTouchUpInside];
    }
    return _phoneCodeLoginButton;
}

- (UIButton *)resetPassButton {
    if (!_resetPassButton) {
        _resetPassButton = [TPViewUtil buttonWithFrame:CGRectMake(15, self.signInButton.bottom + 16, 150, 20) fontSize:14 bgColor:nil textColor:LIST_LIGHT_TEXT_COLOR borderColor:nil];
        _resetPassButton.right = self.signInButton.right;
        [_resetPassButton setTitle:NSLocalizedString(@"login_forget", @"") forState:UIControlStateNormal];
        _resetPassButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [_resetPassButton addTarget:self action:@selector(resetPassButtonTap) forControlEvents:UIControlEventTouchUpInside];
    }
    return _resetPassButton;
}

- (void)sendVerifyCodeButtonTap {
    [_verifyCodeTextFieldView.textField becomeFirstResponder];
    
    if ([self.delegate respondsToSelector:@selector(signInViewSendVerifyCodeButtonTap:)]) {
        [self.delegate signInViewSendVerifyCodeButtonTap:self];
    }
}

- (void)setCountryCode:(TPCountryModel *)model {
    if (!model) {
        _countrySelectView.rightItem.title = NSLocalizedString(@"ty_login_register_noselect", nil);
    } else {
        _countrySelectView.rightItem.title = [NSString stringWithFormat:@"%@ +%@", model.countryName, model.countryCode];
    }
    [_countrySelectView setNeedsLayout];
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

- (void)signInButtonTap {
    if ([self.delegate respondsToSelector:@selector(signInViewSignInButtonTap:)]) {
        [self.delegate signInViewSignInButtonTap:self];
    }
}

- (void)enableSignInButton {
    [_signInButton setEnabled:YES];
    _signInButton.backgroundColor = BUTTON_BACKGROUND_COLOR;
}

- (void)disableSignInButton {
    [_signInButton setEnabled:NO];
    [_signInButton setBackgroundColor:SEPARATOR_LINE_COLOR];
}

- (void)phoneCodeLoginButtonTap {
    if ([self.delegate respondsToSelector:@selector(signInViewPhoneCodeLoginButtonTap:)]) {
        [self.delegate signInViewPhoneCodeLoginButtonTap:self];
    }
}

- (void)resetPassButtonTap {
    if ([self.delegate respondsToSelector:@selector(signInViewResetPassButtonTap:)]) {
        [self.delegate signInViewResetPassButtonTap:self];
    }
}

- (void)identifyTextFieldChanged:(UITextField *)textField {
    
    if (textField == self.phoneTextFieldView.textField) {
        
        BOOL status = [self.delegate getCountStatus];
        
        if (status) {
            return;
        }
        
        
        if (textField.text.length > 0) {
            [self enableSendVerifyCodeButton:nil];
        } else {
            [self disableSendVerifyCodeButton:nil];
        }
        
    }
    

    if (_phoneCodeLogin == YES) {
        
        if (self.phoneTextFieldView.text.length > 0 && self.verifyCodeTextFieldView.text.length > 0) {
            [self enableSignInButton];
        } else {
            [self disableSignInButton];
        }
    } else {
        
        if (self.phoneTextFieldView.text.length > 0 && self.passwordTextFieldView.text.length > 0) {
            [self enableSignInButton];
        } else {
            [self disableSignInButton];
        }
        
    }
    
}

#pragma mark TPCellViewDelegate

- (void)TPCellViewTap:(TPCellView *)tpCellView {
    if ([self.delegate respondsToSelector:@selector(signInViewCountrySelectViewTap:)]) {
        [self.delegate signInViewCountrySelectViewTap:self];
    }
}

- (void)topBarLeftItemTap {
    [tp_topMostViewController() dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - TPTextFieldViewDelegate

- (void)textFieldRightItemViewTap {
    _passwordTextFieldView.textField.secureTextEntry = !_passwordTextFieldView.textField.secureTextEntry;
    _passwordTextFieldView.rightImage = [UIImage imageNamed:_passwordTextFieldView.textField.secureTextEntry ? @"ty_login_password_no" : @"ty_login_password"];
}

@end
