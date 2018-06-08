//
//  TYEZAddDeviceView.m
//  TuyaSmart
//
//  Created by 高森 on 16/1/27.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TYEZAddDeviceView.h"

@interface TYEZAddDeviceView () <UITextFieldDelegate>

@property (nonatomic, strong) UILabel     *tipsLabel;
@property (nonatomic, strong) UIImageView *ssidImageView;
@property (nonatomic, strong) UILabel     *ssidLabel;
@property (nonatomic, strong) UIView      *passwordView;
@property (nonatomic, strong) UITextField *passwordTextField;
@property (nonatomic, strong) UIImageView *seePwView;

@end

@implementation TYEZAddDeviceView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.tipsLabel];
        [self addSubview:self.ssidImageView];
        [self addSubview:self.ssidView];
        
        [self addSubview:self.passwordView];
        [self addSubview:self.nextButton];
        
        if (self.nextButton.bottom > self.height) {
            self.nextButton.bottom = self.height - 15;
            self.passwordView.bottom = self.nextButton.top - 15;
        }
    }
    return self;
}

- (UILabel *)tipsLabel {
    if (!_tipsLabel) {
        _tipsLabel = [TPViewUtil labelWithFrame:CGRectMake(0, 0, APP_CONTENT_WIDTH, 30) fontSize:12 color:NOTICE_TEXT_COLOR];
        _tipsLabel.textAlignment = NSTextAlignmentCenter;
        _tipsLabel.backgroundColor = NOTICE_BACKGROUND_COLOR;
        _tipsLabel.text = NSLocalizedString(@"ez_notSupport_5G", nil);
    }
    return _tipsLabel;
}

- (UIImageView *)ssidImageView {
    if (!_ssidImageView) {
        CGFloat top = (APP_VISIBLE_HEIGHT * 0.618 - 100) / 2;
        _ssidImageView = [[UIImageView alloc] initWithFrame:CGRectMake((APP_CONTENT_WIDTH - 100) / 2, top, 100, 100)];
        _ssidImageView.image = [[UIImage imageNamed:@"ty_adddevice_wifi"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _ssidImageView.contentMode = UIViewContentModeCenter;
        _ssidImageView.backgroundColor = [UIColor whiteColor];
        _ssidImageView.layer.cornerRadius = 50;
        _ssidImageView.layer.masksToBounds = YES;
    }
    return _ssidImageView;
}

- (UIView *)ssidView {
    if (!_ssidView) {
        _ssidView = [TPViewUtil viewWithFrame:CGRectMake(15, self.ssidImageView.bottom + 44, APP_SCREEN_WIDTH - 30, 44) color:nil];
        [_ssidView addSubview:[TPViewUtil imageViewWithFrame:CGRectMake(16, 14, 16, 16) image:[UIImage imageNamed:@"tysmart_wifi"]]];
        [_ssidView addSubview:self.ssidLabel];
        UIImageView *arrow = [TPViewUtil imageViewWithFrame:CGRectMake(self.ssidView.width - 35, 0, 35, 44) image:[UIImage imageNamed:@"cell_view_arrow"]];
        arrow.contentMode = UIViewContentModeCenter;
        _ssidView.userInteractionEnabled = YES;
        [_ssidView addSubview:arrow];
        [_ssidView addSubview:[TPViewUtil viewWithFrame:CGRectMake(0, 43.5, _ssidView.width, 0.5) color:LIST_LINE_COLOR]];
    }
    return _ssidView;
}

- (UILabel *)ssidLabel {
    if (!_ssidLabel) {
        _ssidLabel = [TPViewUtil labelWithFrame:CGRectMake(46, 0, self.ssidView.width - 46 - 35, 44) fontSize:16 color:HEXCOLOR(0x303030)];
    }
    return _ssidLabel;
}

- (UIView *)passwordView {
    if (!_passwordView) {
        _passwordView = [TPViewUtil viewWithFrame:CGRectMake(15, self.ssidView.bottom + 8, APP_SCREEN_WIDTH - 30, 44) color:nil];
        [_passwordView addSubview:[TPViewUtil imageViewWithFrame:CGRectMake(16, 14, 16, 16) image:[UIImage imageNamed:@"tysmart_password"]]];
        [_passwordView addSubview:self.passwordTextField];
        [_passwordView addSubview:self.seePwView];
        [_passwordView addSubview:[TPViewUtil viewWithFrame:CGRectMake(0, 43.5, _passwordView.width, 0.5) color:LIST_LINE_COLOR]];
    }
    return _passwordView;
}

- (UITextField *)passwordTextField {
    if (!_passwordTextField) {
        _passwordTextField = [TPViewUtil textFieldWithFrame:CGRectMake(46, 0, self.passwordView.width - 46 - 35, 43.5) fontSize:16 color:[UIColor blackColor]];
        _passwordTextField.placeholder = NSLocalizedString(@"please_input_wifi_password", @"");
        _passwordTextField.keyboardType = UIKeyboardTypeASCIICapable;
        _passwordTextField.returnKeyType = UIReturnKeyDone;
        _passwordTextField.delegate = self;
    }
    return _passwordTextField;
}

- (UIImageView *)seePwView {
    if (!_seePwView) {
        _seePwView = [TPViewUtil imageViewWithFrame:CGRectMake(self.passwordView.width - 35, 0, 35, 44) image:[UIImage imageNamed:@"ty_login_password"]];
        _seePwView.contentMode = UIViewContentModeCenter;
        _seePwView.userInteractionEnabled = YES;
        [_seePwView addGestureRecognizer:[TPViewUtil singleFingerClickRecognizer:self sel:@selector(seePw)]];
    }
    return _seePwView;
}

- (UIButton *)nextButton {
    if (!_nextButton) {
        _nextButton = [TPViewUtil buttonWithFrame:CGRectMake(15, APP_VISIBLE_HEIGHT - 44 - 15, APP_SCREEN_WIDTH - 30, 44) fontSize:16 bgColor:MAIN_COLOR textColor:[UIColor whiteColor]];
        [_nextButton setTitle:NSLocalizedString(@"next", @"") forState:UIControlStateNormal];
    }
    return _nextButton;
}

- (NSString *)password {
    return self.passwordTextField.text;
}

- (void)setPassword:(NSString *)password {
    _passwordTextField.text = password;
}

- (void)setSsid:(NSString *)ssid {
    _ssid = ssid;
    
    if (ssid.length == 0) {
        self.ssidImageView.tintColor = MAIN_BACKGROUND_COLOR;
        self.ssidLabel.text = NSLocalizedString(@"ty_ez_current_no_wifi", @"");
    } else {
        self.ssidImageView.tintColor = MAIN_COLOR;
        self.ssidLabel.text = [NSString stringWithFormat:NSLocalizedString(@"ty_ez_current_wifi", @""), ssid];
    }
}

- (void)seePw {
    _passwordTextField.secureTextEntry = !_passwordTextField.secureTextEntry;
    _seePwView.image = [UIImage imageNamed:_passwordTextField.secureTextEntry ? @"ty_login_password_no" : @"ty_login_password"];
    
    if (_passwordTextField.isFirstResponder){
        [_passwordTextField becomeFirstResponder];
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
