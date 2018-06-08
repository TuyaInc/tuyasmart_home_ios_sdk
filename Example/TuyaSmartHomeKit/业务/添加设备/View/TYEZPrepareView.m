//
//  TYEZPrepareView.m
//  TuyaSmartPublic
//
//  Created by 高森 on 16/3/29.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TYEZPrepareView.h"

@interface TYEZPrepareView()

@property (nonatomic, strong) UIImageView   *imageView;
@property (nonatomic, strong) UILabel       *tipsLabel;
@property (nonatomic, strong) UIButton      *helpButton;
@property (nonatomic, strong) UIButton      *nextButton;
@property (nonatomic, assign) TYActivatorMode   mode;

@end

@implementation TYEZPrepareView

- (instancetype)initWithFrame:(CGRect)frame mode:(TYActivatorMode)mode {
    if (self = [super initWithFrame:frame]) {
        _mode = mode;
        [self initImageView];
        [self initTipsLabel];
        [self initNextButton];
        [self initHelpButton];
    }
    return self;
}

- (void)initImageView {
    _imageView = [[UIImageView alloc] init];
    
    CGFloat width = APP_SCREEN_WIDTH;
    CGFloat height = width == 320 ? 284 : width;
    _imageView.frame = CGRectMake(0, 0, width, height);
    _imageView.contentMode = UIViewContentModeCenter;
    
    _imageView.animationImages = @[[UIImage imageNamed:@"ty_adddevice_light"],[UIImage imageNamed:@"ty_adddevice_lighting"]];
    _imageView.animationDuration = _mode == TYActivatorModeEZ ? 0.5 : 3;
    _imageView.animationRepeatCount = 0;
    [_imageView startAnimating];
    
    [self addSubview:_imageView];
}

- (void)initTipsLabel {
    _tipsLabel = [TPViewUtil labelWithFrame:CGRectMake(0, 0, APP_CONTENT_WIDTH, 30) fontSize:12 color:NOTICE_TEXT_COLOR];
    _tipsLabel.textAlignment = NSTextAlignmentCenter;
    _tipsLabel.backgroundColor = NOTICE_BACKGROUND_COLOR;
    _tipsLabel.text = NSLocalizedString(_mode == TYActivatorModeEZ ? @"ty_add_device_ez_info" : @"ty_add_device_ap_info", @"");
    
    [self addSubview:_tipsLabel];
}

- (void)setTipText:(NSString *)text {
    _tipsLabel.text = text;
}

- (void)initNextButton {
    CGFloat top = _imageView.bottom + (APP_VISIBLE_HEIGHT - _imageView.height - 88 - 10) / 2;
    _nextButton = [TPViewUtil buttonWithFrame:CGRectMake(30, top, APP_CONTENT_WIDTH - 60, 44) fontSize:16 bgColor:HEXCOLOR(0xFFFFFF) textColor:HEXCOLOR(0x626262)];
    _nextButton.layer.borderColor = HEXCOLOR(0x9B9B9B).CGColor;
    _nextButton.layer.borderWidth = 0.5;
    _nextButton.layer.cornerRadius = 22;
    [_nextButton setTitle:NSLocalizedString(_mode == TYActivatorModeEZ ? @"ty_add_device_ez_btn_info" : @"ty_add_device_ap_btn_info", @"") forState:UIControlStateNormal];
    [_nextButton addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_nextButton];
}

- (void)initHelpButton {
    _helpButton = [TPViewUtil buttonWithFrame:CGRectMake(30, _nextButton.bottom + 10, APP_CONTENT_WIDTH - 60, 44) fontSize:16 bgColor:HEXCOLOR(0xFFFFFF) textColor:HEXCOLOR(0x626262)];
    _helpButton.layer.borderColor = HEXCOLOR(0x9B9B9B).CGColor;
    _helpButton.layer.borderWidth = 0.5;
    _helpButton.layer.cornerRadius = 22;
    [_helpButton setTitle:NSLocalizedString(@"ty_add_device_btn_info", @"") forState:UIControlStateNormal];
    [_helpButton addTarget:self action:@selector(helpAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_helpButton];
}

- (void)helpAction {
    if ([self.delegate respondsToSelector:@selector(helpAction:)]) {
        [self.delegate helpAction:self];
    }
}

- (void)nextAction {
    if ([self.delegate respondsToSelector:@selector(nextAction:)]) {
        [self.delegate nextAction:self];
    }
}

@end
