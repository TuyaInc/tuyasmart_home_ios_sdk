//
//  TYSceneHeaderView.m
//  TYSmartSceneLibrary
//
//  Created by XuChengcheng on 2017/5/2.
//  Copyright © 2017年 xcc. All rights reserved.
//

#import "TYSceneHeaderView.h"

@implementation TYSceneHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubView];
    }
    
    return self;
}

- (void)addSubView {
    self.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLabel = [TPViewUtil simpleLabel:CGRectMake(0, 25, APP_SCREEN_WIDTH, 33) bf:24 tc:HEXCOLOR(0x303030) t:NSLocalizedString(@"ty_smart_scene_edit_title2", @"")];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:titleLabel];
    
    NSString *subTitle = NSLocalizedString(@"ty_smart_scene_edit_explain", @"");
    
    UILabel *subTitleLabel = [TPViewUtil simpleLabel:CGRectMake(25, 74, APP_SCREEN_WIDTH - 50, 60) f:12 tc:HEXCOLOR(0x8a8e91) t:subTitle];
    subTitleLabel.textAlignment = NSTextAlignmentCenter;
    subTitleLabel.numberOfLines = 3;
    [self addSubview:subTitleLabel];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:subTitle];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentCenter;
    paragraphStyle.lineSpacing = 3;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [subTitle length])];
    subTitleLabel.attributedText = attributedString;
    
    [subTitleLabel sizeToFit];
    
    UIButton *closeButton = [[UIButton alloc] initWithFrame:CGRectMake(APP_SCREEN_WIDTH - 20 - 11, 6, 20, 20)];
    [closeButton setImage:[UIImage imageNamed:@"ty_index_scene_close"] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(closeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeButton];
}

- (IBAction)closeButtonClicked:(id)sender {
    if ([self.delegate respondsToSelector:@selector(TYSceneHeaderViewDidDismiss)]) {
        [self.delegate TYSceneHeaderViewDidDismiss];
    }
}


@end
