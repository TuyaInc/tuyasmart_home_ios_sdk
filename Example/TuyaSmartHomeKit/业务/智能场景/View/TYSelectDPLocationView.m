//
//  TYSelectDPLocationView.m
//  TuyaSmartPublic
//
//  Created by 冯晓 on 2016/11/2.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TYSelectDPLocationView.h"

@interface TYSelectDPLocationView()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;
@property (nonatomic, strong) UIImageView *arrowImageView;


@end

@implementation TYSelectDPLocationView

- (void)setCity:(NSString *)city {
    _subTitleLabel.text = city;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = LIST_BACKGROUND_COLOR;
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_CONTENT_WIDTH, 0.5)];
        lineView.backgroundColor = LIST_LINE_COLOR;
        [self addSubview:lineView];
        
        [self addSubview:self.titleLabel];
        [self addSubview:self.subTitleLabel];
        [self addSubview:self.arrowImageView];
        
        
        UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 48 - 0.5, APP_CONTENT_WIDTH, 0.5)];
        lineView2.backgroundColor = LIST_LINE_COLOR;
        [self addSubview:lineView2];
        
    }
    return self;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [TPViewUtil simpleLabel:CGRectMake(15, 0, 100, 48) f:16 tc:LIST_MAIN_TEXT_COLOR t:NSLocalizedString(@"ty_smart_positioning_city", nil)];
    }
    return _titleLabel;
}

- (UILabel *)subTitleLabel {
    if (!_subTitleLabel) {
        _subTitleLabel = [TPViewUtil simpleLabel:CGRectMake(15, 0, 200, 48) f:16 tc:LIST_MAIN_TEXT_COLOR t:NSLocalizedString(@"", nil)];
        _subTitleLabel.right = APP_CONTENT_WIDTH - 37;
        _subTitleLabel.textAlignment = NSTextAlignmentRight;
    }
    return _subTitleLabel;
}

- (UIImageView *)arrowImageView {
    if (!_arrowImageView) {
        _arrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"smartScene.bundle/cell_view_arrow"]];
        _arrowImageView.right = APP_CONTENT_WIDTH - 15;
        _arrowImageView.top = (48 - _arrowImageView.height) / 2.f;
    }
    return _arrowImageView;
}

@end
