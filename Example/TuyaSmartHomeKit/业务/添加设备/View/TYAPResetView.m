//
//  TYAPResetView.m
//  TuyaSmartPublic
//
//  Created by 高森 on 16/3/29.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TYAPResetView.h"

@implementation TYAPResetView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addTextLabel];
        [self addHelpButton];
        [self addNextButton];
    }
    return self;
}

- (void)addTextLabel {
    _tipLabel = [TPViewUtil labelWithFrame:CGRectMake((APP_CONTENT_WIDTH - 260) / 2, 64, 260, 40) fontSize:14 color:LIST_MAIN_TEXT_COLOR];
    _tipLabel.textAlignment = NSTextAlignmentCenter;
    _tipLabel.numberOfLines = 0;
    _tipLabel.text = NSLocalizedString(@"ty_ez_init_descripton1", @"");
    _tipLabel.height = [_tipLabel sizeThatFits:CGSizeMake(_tipLabel.width, APP_VISIBLE_HEIGHT)].height;
    [self addSubview:_tipLabel];

    UILabel *label2 = [TPViewUtil labelWithFrame:CGRectMake(40, _tipLabel.bottom + 56, APP_CONTENT_WIDTH - 80 , 18) fontSize:13 color:LIST_SUB_TEXT_COLOR];
    label2.numberOfLines = 0;
    label2.text = NSLocalizedString(@"ty_ez_init_descripton2", @"");
    label2.height = [label2 sizeThatFits:CGSizeMake(label2.width, APP_VISIBLE_HEIGHT)].height;
    [self addSubview:label2];
    
    UILabel *label3 = [TPViewUtil labelWithFrame:CGRectMake(40, label2.bottom + 16, APP_CONTENT_WIDTH - 80, 18) fontSize:13 color:LIST_SUB_TEXT_COLOR];
    label3.numberOfLines = 0;
    label3.text = NSLocalizedString(@"ty_ez_init_descripton3", @"");
    label3.height = [label3 sizeThatFits:CGSizeMake(label3.width, APP_VISIBLE_HEIGHT)].height;
    [self addSubview:label3];
}

- (void)addHelpButton {
    UIButton *helpButton = [TPViewUtil buttonWithFrame:CGRectMake((APP_CONTENT_WIDTH - 200) / 2, 320, 200, 18) fontSize:13 textColor:MAIN_COLOR];
    [helpButton setTitle:NSLocalizedString(@"ty_ez_init_help", @"") forState:UIControlStateNormal];
    [helpButton addTarget:self action:@selector(helpAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:helpButton];
}

- (void)addNextButton {
    UIButton *nextButton = [TPViewUtil buttonWithFrame:CGRectMake(15, APP_VISIBLE_HEIGHT - 44 - 15, APP_CONTENT_WIDTH - 30, 44) fontSize:16 bgColor:BUTTON_BACKGROUND_COLOR textColor:BUTTON_TEXT_COLOR];
    [nextButton setTitle:NSLocalizedString(@"ty_ez_init_comfirm", @"") forState:UIControlStateNormal];
    [nextButton addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:nextButton];
    
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
