//
//  TYLoginAndRegisterView.m
//  TuyaSmartHomeKit_Example
//
//  Created by Kennaki Kai on 2018/11/30.
//  Copyright © 2018 xuchengcheng. All rights reserved.
//

#import "TYDemoLoginAndRegisterView.h"

@implementation TYDemoLoginAndRegisterView
{
    TYLoginAndRegisterViewType currentType;
}

- (instancetype)initWithType:(TYLoginAndRegisterViewType)type{
    if (self = [super init]) {
        currentType = type;
        [self initView];
        CGFloat top = IPhoneX ? 130 : 100;
        self.frame = CGRectMake(0, top, APP_SCREEN_WIDTH, APP_SCREEN_HEIGHT - 100);
    }
    return self;
}

- (void)initView {

    self.userInteractionEnabled = YES;
    UILabel *countryKeyLabel = [self keyLabel];
    countryKeyLabel.text = NSLocalizedString(@"Country code", @"");
    countryKeyLabel.frame = CGRectMake(20, 0, 120, 20);
    [self addSubview:countryKeyLabel];
    self.countryCodeField = [self valueTextField];
    self.countryCodeField.centerY = countryKeyLabel.centerY;
    [self addSubview:self.countryCodeField];
    self.countryCodeField.text = @"86";
    
    UILabel *accountKeyLabel = [self keyLabel];
    accountKeyLabel.text = NSLocalizedString(@"Account", @"");
    accountKeyLabel.frame = CGRectMake(20, CGRectGetMaxY(self.countryCodeField.frame) + 20 + 15, 120, 20);
    [self addSubview:accountKeyLabel];
    self.accountField = [self valueTextField];
    self.accountField.centerY = accountKeyLabel.centerY;
    [self addSubview:self.accountField];
    self.accountField.placeholder = NSLocalizedString(@"Phone number/Email", @"");
    
    UILabel *pwdKeyLabel = [self keyLabel];
    pwdKeyLabel.text = NSLocalizedString(@"input_password", @"");
    pwdKeyLabel.frame = CGRectMake(20, CGRectGetMaxY(self.accountField.frame) + 20 + 15, 120, 20);
    [self addSubview:pwdKeyLabel];
    self.passwordField = [self valueTextField];
    self.passwordField.centerY = pwdKeyLabel.centerY;
    [self addSubview:self.passwordField];
    self.passwordField.placeholder = NSLocalizedString(@"input_password", @"");
    self.passwordField.secureTextEntry = YES;
    
    switch (currentType) {
        case TYLoginAndRegisterViewTypeLogin:
        {
            UIButton *pwdLoginButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [pwdLoginButton setTitle:NSLocalizedString(@"Login with password", @"") forState:UIControlStateNormal];
            pwdLoginButton.frame = CGRectMake(20, CGRectGetMaxY(self.passwordField.frame) + 20, APP_SCREEN_WIDTH - 40, 44);
            pwdLoginButton.layer.cornerRadius = 5;
            pwdLoginButton.backgroundColor = UIColor.orangeColor;
            [pwdLoginButton addTarget:self action:@selector(passwordLogin) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:pwdLoginButton];
        }
            break;
        case TYLoginAndRegisterViewTypeRegister:
        {
            UILabel *verifyCodeKeyLabel = [self keyLabel];
            verifyCodeKeyLabel.text = NSLocalizedString(@"Verify code", @"");
            verifyCodeKeyLabel.frame = CGRectMake(20, CGRectGetMaxY(self.passwordField.frame) + 20 + 15, 120, 20);
            [self addSubview:verifyCodeKeyLabel];
            self.verifyCodeField = [self valueTextField];
            self.verifyCodeField.centerY = verifyCodeKeyLabel.centerY;
            [self addSubview:self.verifyCodeField];
            self.verifyCodeField.placeholder = NSLocalizedString(@"Verify code", @"");
            
            CGFloat buttonWidth = (APP_SCREEN_WIDTH - 60)/2;
            
            UIButton *sendVerifyCodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
            sendVerifyCodeButton.backgroundColor = UIColor.orangeColor;
            [sendVerifyCodeButton setTitle:NSLocalizedString(@"Send code", @"") forState:UIControlStateNormal];
            sendVerifyCodeButton.frame = CGRectMake(20, CGRectGetMaxY(self.verifyCodeField.frame) + 20, buttonWidth, 44);
            sendVerifyCodeButton.layer.cornerRadius = 5;
            [sendVerifyCodeButton addTarget:self action:@selector(sendVerifyCode) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:sendVerifyCodeButton];
            
            UIButton *registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
            registerButton.backgroundColor = UIColor.orangeColor;
            [registerButton setTitle:NSLocalizedString(@"login_register", @"") forState:UIControlStateNormal];
            registerButton.frame = CGRectMake(buttonWidth + 40/*button space 20 and left space 20*/, CGRectGetMaxY(self.verifyCodeField.frame) + 20, buttonWidth, 44);
            registerButton.layer.cornerRadius = 5;
            [registerButton addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:registerButton];
        }
            break;
        default:
            break;
    }
   
    UITapGestureRecognizer *tapToDismiss = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self addGestureRecognizer:tapToDismiss];
}

- (void)passwordLogin {
    if (self.delegate && [self.delegate respondsToSelector:@selector(loginAndRegisterViewTrigerredAction:)]) {
        [self.delegate loginAndRegisterViewTrigerredAction:TYLoginAndRegisterViewActionTypeLogin];
    }
}

- (void)sendVerifyCode {
    if (self.delegate && [self.delegate respondsToSelector:@selector(loginAndRegisterViewTrigerredAction:)]) {
        [self.delegate loginAndRegisterViewTrigerredAction:TYLoginAndRegisterViewActionTypeSendVerifyCode];
    }
}

- (void)registerAction {
    if (self.delegate && [self.delegate respondsToSelector:@selector(loginAndRegisterViewTrigerredAction:)]) {
        [self.delegate loginAndRegisterViewTrigerredAction:TYLoginAndRegisterViewActionTypeRegister];
    }
}

- (void)dismissKeyboard {
    [self endEditing:YES];
    [self.countryCodeField resignFirstResponder];
    [self.accountField resignFirstResponder];
    [self.passwordField resignFirstResponder];
    [self.verifyCodeField resignFirstResponder];
}

- (UILabel *)keyLabel {
    UILabel *label = [UILabel new];
    label.font = [UIFont systemFontOfSize:15];
    return label;
}

- (UITextField *)valueTextField {
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(140, 0, APP_SCREEN_WIDTH - 140 - 20, 44)];
    textField.layer.borderColor = UIColor.blackColor.CGColor;
    textField.layer.borderWidth = 0.5;
    textField.layer.cornerRadius = 5;
    textField.layer.masksToBounds = YES;
    textField.delegate = self;
    return textField;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    if (!view) {
        for (UIView *aView in self.subviews) {
            CGPoint myPoint = [aView convertPoint:point fromView:self];
            if (CGRectContainsPoint(aView.bounds, myPoint)) {
                return aView;
            }
        }
    }
    return view;
}

#pragma mark - UITextFieldDelegate delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    if (textField == self.verifyCodeField) {
        self.top -= 150;
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    CGFloat top = IPhoneX ? 130 : 100;
    self.top = top;
}
@end
