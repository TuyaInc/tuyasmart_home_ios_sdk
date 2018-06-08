//
//  MobileBindingView.m
//  TuyaSmartPublic
//
//  Created by remy on 16/3/29.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "MobileBindingView.h"
#import "TPCellView.h"
#import "TPTextFieldView.h"

@interface MobileBindingView() <TPCellViewDelegate>

@property (nonatomic, strong) UIView          *centerView;

@property (nonatomic, strong) TPCellView      *countrySelectView;
@property (nonatomic, strong) TPTextFieldView *phoneTextFieldView;
@property (nonatomic, strong) TPTextFieldView *verifyCodeTextFieldView;
@property (nonatomic, strong) UIButton        *sendVerifyCodeButton;
@property (nonatomic, strong) UIButton        *bindingButton;

@end

@implementation MobileBindingView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = MAIN_BACKGROUND_COLOR;
        
        self.topBarView.centerItem.title = NSLocalizedString(@"mobile_binding", @"");
        [self addSubview:self.topBarView];
        
        [self addSubview:self.centerView];
        UILabel *title = [TPViewUtil labelWithFrame:CGRectMake(0, 0, APP_CONTENT_WIDTH, 56) fontSize:14 color:LIST_LIGHT_TEXT_COLOR];
        title.textAlignment = NSTextAlignmentCenter;
        title.text = NSLocalizedString(@"ty_mobile_binding_tip", @"");
        [self.centerView addSubview:title];
        [self.centerView addSubview:self.countrySelectView];
        [self.centerView addSubview:self.phoneTextFieldView];
        [self.centerView addSubview:self.verifyCodeTextFieldView];
        [self.centerView addSubview:self.sendVerifyCodeButton];
        [self.centerView addSubview:self.bindingButton];

        [self.phoneTextFieldView.textField addTarget:self action:@selector(identifyTextFieldChanged:) forControlEvents:UIControlEventEditingChanged];
        [self.verifyCodeTextFieldView.textField addTarget:self action:@selector(identifyTextFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    return self;
}

- (NSString *)phoneNumber {
    return _phoneTextFieldView.text;
}

- (NSString *)verifyCode {
    return _verifyCodeTextFieldView.text;
}

- (UIView *)centerView {
    if (!_centerView) {
        _centerView = [[UIView alloc] initWithFrame:CGRectMake(0, APP_TOP_BAR_HEIGHT, APP_SCREEN_WIDTH, 56 + 44 * 4 + 10 * 3)];
    }
    return _centerView;
}

- (TPCellView *)countrySelectView {
    if (!_countrySelectView) {
        _countrySelectView = [[TPCellView alloc] initWithFrame:CGRectMake(15, 56, self.width - 30, 44)];
        _countrySelectView.delegate = self;
        _countrySelectView.backgroundColor = LIST_BACKGROUND_COLOR;
        _countrySelectView.roundCorner = YES;
        _countrySelectView.topLineHidden = YES;
        _countrySelectView.bottomLineHidden = YES;
        
        _countrySelectView.leftItem = [TPCellViewItem cellItemWithTitle:NSLocalizedString(@"login_choose_country", @"") image:nil];
        _countrySelectView.leftItem.textColor = LIST_SUB_TEXT_COLOR;
        
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
        _phoneTextFieldView.placeholder = NSLocalizedString(@"input_telephone_number", @"");
        _phoneTextFieldView.textField.keyboardType = UIKeyboardTypeNumberPad;
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

- (UIButton *)bindingButton {
    if (!_bindingButton) {
        _bindingButton = [TPViewUtil buttonWithFrame:CGRectMake(15, self.phoneTextFieldView.bottom + 70, self.width - 30, 44) fontSize:16 bgColor:BUTTON_BACKGROUND_COLOR textColor:BUTTON_TEXT_COLOR borderColor:nil];
        [_bindingButton setTitle:NSLocalizedString(@"confirm", @"") forState:UIControlStateNormal];
        [_bindingButton addTarget:self action:@selector(bindingButtonTap) forControlEvents:UIControlEventTouchUpInside];
        [self disableBindingButton];
    }
    return _bindingButton;
}

- (void)sendVerifyCodeButtonTap {
    [_verifyCodeTextFieldView.textField becomeFirstResponder];
    
    if ([self.delegate respondsToSelector:@selector(bindingViewSendVerifyCodeButtonTap:)]) {
        [self.delegate bindingViewSendVerifyCodeButtonTap:self];
    }
}

- (void)setCountryCode:(TPCountryModel *)model {
    _countrySelectView.leftItem.title = model.countryName;
    _countrySelectView.rightItem.title = [NSString stringWithFormat:@"+%@",model.countryCode];
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

- (void)bindingButtonTap {
    if ([self.delegate respondsToSelector:@selector(bindingViewBindingButtonTap:)]) {
        [self.delegate bindingViewBindingButtonTap:self];
    }
}

- (void)enableBindingButton {
    [_bindingButton setEnabled:YES];
    _bindingButton.backgroundColor = BUTTON_BACKGROUND_COLOR;
}

- (void)disableBindingButton {
    [_bindingButton setEnabled:NO];
    [_bindingButton setBackgroundColor:SEPARATOR_LINE_COLOR];
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

        
    if (self.phoneTextFieldView.textField.text.length > 0 && self.verifyCodeTextFieldView.textField.text.length > 0) {
        [self enableBindingButton];
    } else {
        [self disableBindingButton];
    }
}


#pragma mark TPCellViewDelegate

- (void)TPCellViewTap:(TPCellView *)tpCellView {
    if ([self.delegate respondsToSelector:@selector(bindingViewCountrySelectViewTap:)]) {
        [self.delegate bindingViewCountrySelectViewTap:self];
    }
}

@end
