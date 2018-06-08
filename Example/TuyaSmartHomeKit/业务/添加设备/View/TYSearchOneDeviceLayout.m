//
//  TYSearchOneDeviceLayout.m
//  TuyaSmart
//
//  Created by 高森 on 16/1/27.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TYSearchOneDeviceLayout.h"
#import <DACircularProgress/DALabeledCircularProgressView.h>

@interface TYSearchOneDeviceLayout ()

@property (nonatomic, strong) DALabeledCircularProgressView *circularView;
@property (nonatomic, strong) UILabel *tipsLabel;

@end

@implementation TYSearchOneDeviceLayout

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = MAIN_BACKGROUND_COLOR;
        
        _circularView = [[DALabeledCircularProgressView alloc] initWithFrame:CGRectMake((APP_CONTENT_WIDTH - 100) / 2, APP_TOP_BAR_HEIGHT + (APP_VISIBLE_HEIGHT - 100) / 3, 100, 100)];
        _circularView.trackTintColor = [MAIN_COLOR colorWithAlphaComponent:0.2];
        _circularView.progressTintColor = MAIN_COLOR;
        _circularView.innerTintColor = [UIColor whiteColor];
        _circularView.thicknessRatio = 0.05;
        _circularView.roundedCorners = YES;
        
        _circularView.progressLabel.font = [UIFont systemFontOfSize:24];
        _circularView.progressLabel.textColor = MAIN_COLOR;
        [self addSubview:_circularView];
        
        _tipsLabel = [TPViewUtil labelWithFrame:CGRectMake((APP_CONTENT_WIDTH - 300) / 2, _circularView.bottom + 24, 300, 60) fontSize:14 color:SUB_FONT_COLOR];
        _tipsLabel.numberOfLines = 0;
        
        NSString *labelText = [NSString stringWithFormat:@"%@\n%@", NSLocalizedString(@"ty_ez_connecting_devicei_note1", @""), NSLocalizedString(@"ty_ez_connecting_device_note2", @"")];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.alignment = NSTextAlignmentCenter;
        paragraphStyle.lineSpacing = 3;
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
        
        _tipsLabel.attributedText = attributedString;
        [self addSubview:_tipsLabel];
        
        self.topBarView.leftItem.image = [UIImage imageNamed:@"back_white.png"];
        self.topBarView.centerItem.title = NSLocalizedString(@"ty_ez_connecting_device_title", @"");
        self.topBarView.rightItem = nil;
        [self addSubview:self.topBarView];
        
        [self setProgress:0];
    }
    return self;
}


- (void)setProgress:(CGFloat)progress {
    [_circularView setProgress:progress animated:YES];
    _circularView.progressLabel.text = [NSString stringWithFormat:@"%.0f%%", 100 * progress];
}

@end
