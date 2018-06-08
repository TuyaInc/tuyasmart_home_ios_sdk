//
//  TYContectToAPView.m
//  TuyaSmart
//
//  Created by fengyu on 15/4/10.
//  Copyright (c) 2015年 Tuya. All rights reserved.
//

#import "TYContectToAPView.h"

@interface TYContectToAPView ()

@property(nonatomic,strong) UIButton *noButton;
@property(nonatomic,strong) UIButton *yesButton;

@end

@implementation TYContectToAPView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self addPromptLabel];
    [self addAPImageView];
    [self addButtonView];
    return self;
}

- (void)addPromptLabel {
    UILabel *promptLabel = [TPViewUtil labelWithFrame:CGRectMake(0, 275, APP_SCREEN_WIDTH, 56) fontSize:14 color:SUB_FONT_COLOR];
    promptLabel.textAlignment = NSTextAlignmentCenter;
    promptLabel.numberOfLines = 0;
    promptLabel.text = NSLocalizedString(@"ty_ap_connect_description", @"");
    promptLabel.height = [promptLabel sizeThatFits:CGSizeMake(promptLabel.width, APP_VISIBLE_HEIGHT)].height;
    [self addSubview:promptLabel];
}

- (void)addAPImageView {
    UIImageView *APImageView = [[UIImageView alloc] initWithImage:[TPUtils imageNamedLocalize:@"ty_adddevice_ap_screen"]];
    float x = (APP_SCREEN_WIDTH - APImageView.width)/2;
    APImageView.frame = CGRectMake(x, 48, APImageView.width, APImageView.height);
    [self addSubview:APImageView];
    
    UILabel *label = [TPViewUtil labelWithFrame:CGRectMake(48, 93, 160, 34) fontSize:16 color:HEXCOLOR(0x1E1E1E)];
    label.text = [NSString stringWithFormat:@"%@-XXXX", AP_SSID_PREFIX];
    label.backgroundColor = [UIColor whiteColor];
    [APImageView addSubview:label];
}

- (void)addButtonView {
    
    _noButton = [TPViewUtil buttonWithFrame:CGRectMake((APP_CONTENT_WIDTH - 200) / 2, 315, 200, 18) fontSize:13 textColor:SUB_BUTTON_TEXT_COLOR];
    [_noButton setTitle:NSLocalizedString(@"ty_ap_connect_help", @"") forState:UIControlStateNormal];
    [_noButton addTarget:self action:@selector(helpAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_noButton];
    
    _yesButton = [TPViewUtil buttonWithFrame:CGRectMake(15, APP_VISIBLE_HEIGHT - 44 - 15, APP_SCREEN_WIDTH - 30, 44) fontSize:16 bgColor:MAIN_COLOR textColor:[UIColor whiteColor]];
    [_yesButton setTitle:NSLocalizedString(@"ty_ap_connect_go", @"") forState:UIControlStateNormal];
    [_yesButton addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_yesButton];
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