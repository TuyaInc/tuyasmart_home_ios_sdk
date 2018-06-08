//
//  TPInputPhoneView.m
//  fishNurse
//
//  Created by 高森 on 16/2/23.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TPInputUserAccountView.h"

@interface TPInputUserAccountView() <TPCellViewDelegate>

@property (nonatomic, strong) TPCellView      *countrySelectView;
@property (nonatomic, strong) TPTextFieldView *phoneTextFieldView;
@property (nonatomic, strong) UIButton        *nextButton;

@end

@implementation TPInputUserAccountView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = MAIN_BACKGROUND_COLOR;
        
        
        
        [self addSubview:self.topBarView];
        [self addSubview:self.countrySelectView];
        [self addSubview:self.phoneTextFieldView];
        [self addSubview:self.nextButton];
        
        [self.phoneTextFieldView.textField addTarget:self action:@selector(phoneTextFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    return self;
}

- (NSString *)userAccount {
    return _phoneTextFieldView.text;
}

- (TPCellView *)countrySelectView {
    if (!_countrySelectView) {
        _countrySelectView = [[TPCellView alloc] initWithFrame:CGRectMake(15, APP_TOP_BAR_HEIGHT + 20, self.width - 30, 44)];
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
        _phoneTextFieldView.placeholder = NSLocalizedString(@"phone_email", @"");
        _phoneTextFieldView.textField.keyboardType = UIKeyboardTypeASCIICapable;
    }
    return _phoneTextFieldView;
}

- (UIButton *)nextButton {
    if (!_nextButton) {
        _nextButton = [TPViewUtil buttonWithFrame:CGRectMake(15, self.phoneTextFieldView.bottom + 16, self.width - 30, 44) fontSize:18 bgColor:BUTTON_BACKGROUND_COLOR textColor:BUTTON_TEXT_COLOR borderColor:nil];
        [_nextButton setTitle:NSLocalizedString(@"next", @"") forState:UIControlStateNormal];
        [_nextButton addTarget:self action:@selector(nextButtonTap) forControlEvents:UIControlEventTouchUpInside];
        [self disableNextButton];
    }
    return _nextButton;
}

- (void)setCountryCode:(TPCountryModel *)model {
    _countrySelectView.leftItem.title = model.countryName;
    _countrySelectView.rightItem.title = [NSString stringWithFormat:@"+%@",model.countryCode];
    [_countrySelectView setNeedsLayout];
}

- (void)enableNextButton {
    [_nextButton setEnabled:YES];
    _nextButton.backgroundColor = BUTTON_BACKGROUND_COLOR;
}

- (void)disableNextButton {
    [_nextButton setEnabled:NO];
    [_nextButton setBackgroundColor:SEPARATOR_LINE_COLOR];
}

- (void)nextButtonTap {
    if (self.userAccount.length == 0) {
        return;
    }
    
    if ([self.delegate respondsToSelector:@selector(inputPhoneViewNextButtonTap:)]) {
        [self.delegate inputPhoneViewNextButtonTap:self];
    }
}

- (void)phoneTextFieldChanged:(UITextField *)textField {
    if (self.userAccount.length == 0) {
        [self disableNextButton];
    } else {
        [self enableNextButton];
    }
}


#pragma mark TPCellViewDelegate

- (void)TPCellViewTap:(TPCellView *)tpCellView {
    if ([self.delegate respondsToSelector:@selector(inputPhoneViewCountrySelectViewTap:)]) {
        [self.delegate inputPhoneViewCountrySelectViewTap:self];
    }
}

@end
