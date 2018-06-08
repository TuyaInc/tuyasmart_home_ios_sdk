//
//  TYSearchDeviceFinishView.m
//  TuyaSmart
//
//  Created by 高森 on 16/1/8.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TYSearchDeviceFinishView.h"

@interface TYSearchDeviceFinishView ()

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel     *tipsLabel;
@property (nonatomic, strong) UILabel     *waitLabel;

@property (nonatomic, strong) UIButton *shareButton;
@property (nonatomic, strong) UIButton *doneButton;

@property (nonatomic, strong) UIButton *helpButton;
@property (nonatomic, strong) UIButton *retryButton;
@property (nonatomic, strong) UIButton *callButton;

@property (nonatomic, strong) TuyaSmartDeviceModel *deviceModel;

@end

@implementation TYSearchDeviceFinishView

- (instancetype)initWithFrame:(CGRect)frame isSuccess:(BOOL)isSuccess device:(TuyaSmartDeviceModel *)deviceModel {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = MAIN_BACKGROUND_COLOR;
        
        [self addSubview:self.iconImageView];
        [self addSubview:self.tipsLabel];
        _deviceModel = deviceModel;
        
        if (isSuccess) {
            self.iconImageView.image = [UIImage imageNamed:@"ty_adddevice_ok"];
            
            NSString *name = deviceModel.name ? deviceModel.name : @"";
            self.tipsLabel.text = [NSString stringWithFormat:@"%@ %@", name, NSLocalizedString(@"ty_ez_status_success", @"")];
            self.tipsLabel.textColor = HEXCOLOR(0x61ba00);
            self.tipsLabel.font = [UIFont systemFontOfSize:14];
            
//            [self addSubview:self.shareButton];
            [self addSubview:self.doneButton];
            
            if (deviceModel.isOnline == NO) {
                [self addSubview:self.waitLabel];
            }
            
        } else {
            self.iconImageView.image = [[UIImage imageNamed:@"ty_adddevice_failed"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            self.iconImageView.contentMode = UIViewContentModeCenter;
            self.iconImageView.backgroundColor = [UIColor whiteColor];
            self.iconImageView.tintColor = MAIN_COLOR;
            self.iconImageView.layer.cornerRadius = 50;
            self.iconImageView.layer.masksToBounds = YES;
            

            [self.helpButton setTitle:NSLocalizedString(@"ty_ap_error_description", @"") forState:UIControlStateNormal];
            [self addSubview:self.callButton];
        
            [self addSubview:self.helpButton];
            [self addSubview:self.retryButton];
            
        }
    }
    return self;
}

- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake((APP_SCREEN_WIDTH - 100) / 2, (APP_VISIBLE_HEIGHT - 100) / 3, 100, 100)];
    }
    return _iconImageView;
}

- (UILabel *)tipsLabel {
    if (!_tipsLabel) {
        _tipsLabel = [TPViewUtil labelWithFrame:CGRectMake(15, self.iconImageView.bottom + 24, APP_SCREEN_WIDTH - 30, 20) fontSize:14 color:SUB_FONT_COLOR];
        _tipsLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _tipsLabel;
}

- (UILabel *)waitLabel {
    if (!_waitLabel) {
        _waitLabel = [TPViewUtil labelWithFrame:CGRectMake((APP_SCREEN_WIDTH - 250) / 2, self.tipsLabel.bottom + 5, 250, 20) fontSize:14 color:MAIN_COLOR];
        _waitLabel.textAlignment = NSTextAlignmentCenter;
        _waitLabel.text = NSLocalizedString(@"ty_config_device_init_tip", @"");
    }
    return _waitLabel;
}

- (UIButton *)shareButton {
    if (!_shareButton) {
        _shareButton = [TPViewUtil buttonWithFrame:CGRectMake(15, APP_VISIBLE_HEIGHT - 88 - 25, APP_SCREEN_WIDTH - 30, 44) fontSize:16 bgColor:[UIColor clearColor] textColor:SUB_FONT_COLOR borderColor:SUB_FONT_COLOR];
        [_shareButton setTitle:NSLocalizedString(@"ty_ez_status_share", @"") forState:UIControlStateNormal];
        [_shareButton addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shareButton;
}

- (UIButton *)doneButton {
    if (!_doneButton) {
        _doneButton = [TPViewUtil buttonWithFrame:CGRectMake(15, APP_VISIBLE_HEIGHT - 44 - 15, APP_SCREEN_WIDTH - 30, 44) fontSize:16 bgColor:BUTTON_BACKGROUND_COLOR textColor:BUTTON_TEXT_COLOR];
        [_doneButton setTitle:NSLocalizedString(@"action_done", @"") forState:UIControlStateNormal];
        [_doneButton addTarget:self action:@selector(doneAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _doneButton;
}

- (UIButton *)helpButton {
    if (!_helpButton) {
        _helpButton = [TPViewUtil buttonWithFrame:CGRectMake(30, self.iconImageView.bottom + 24, APP_SCREEN_WIDTH - 60, 15) fontSize:13 bgColor:[UIColor clearColor] textColor:MAIN_COLOR];
        [_helpButton addTarget:self action:@selector(helpAction) forControlEvents:UIControlEventTouchUpInside];
        
//        CGFloat width = [_helpButton.titleLabel sizeThatFits:_helpButton.size].width;
//        UIImage *arrow = [UIImage imageNamed:@"ty_addsd_error_moreinfo"];
//        UIImageView *arrowImageView = [[UIImageView alloc] initWithImage:arrow];
//        arrowImageView.centerY = _helpButton.height / 2;
//        arrowImageView.left = (_helpButton.width + width) / 2 + 5;
//        [_helpButton addSubview:arrowImageView];
    }
    return _helpButton;
}

- (UIButton *)retryButton {
    if (!_retryButton) {
        _retryButton = [TPViewUtil buttonWithFrame:CGRectMake(15, APP_VISIBLE_HEIGHT - 44 - 66, APP_SCREEN_WIDTH - 30, 44) fontSize:16 bgColor:BUTTON_BACKGROUND_COLOR textColor:BUTTON_TEXT_COLOR];
        [_retryButton setTitle:NSLocalizedString(@"retry", @"") forState:UIControlStateNormal];
        [_retryButton addTarget:self action:@selector(retryAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _retryButton;
}

- (UIButton *)callButton {
    if (!_callButton) {
        _callButton = [TPViewUtil buttonWithFrame:CGRectMake((APP_CONTENT_WIDTH - 200) / 2, APP_VISIBLE_HEIGHT - 34 - 16, 200, 34) fontSize:13 textColor:SUB_FONT_COLOR];
        _callButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _callButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_callButton setTitle:NSLocalizedString(@"ty_ap_error_phone", @"") forState:UIControlStateNormal];
        [_callButton addTarget:self action:@selector(callAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _callButton;
}

#pragma mark - action

- (void)retryAction {
    if ([self.delegate respondsToSelector:@selector(retryAction:)]) {
        [self.delegate retryAction:self];
    }
}

- (void)callAction {
    if ([self.delegate respondsToSelector:@selector(callAction:)]) {
        [self.delegate callAction:self];
    }
}

- (void)helpAction {
    if ([self.delegate respondsToSelector:@selector(helpAction:)]) {
        [self.delegate helpAction:self];
    }
}

- (void)shareAction {
    if ([self.delegate respondsToSelector:@selector(shareAction:)]) {
        [self.delegate shareAction:self];
    }
}

- (void)doneAction {
    if ([self.delegate respondsToSelector:@selector(doneAction:deviceModel:)]) {
        [self.delegate doneAction:self deviceModel:_deviceModel];
    }
}

@end
