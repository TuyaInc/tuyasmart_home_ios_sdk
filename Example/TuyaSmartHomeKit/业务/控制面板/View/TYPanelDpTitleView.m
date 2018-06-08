//
//  TYPanelDpTitleView.m
//  TuyaSmartKitDemo
//
//  Created by 冯晓 on 16/8/27.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TYPanelDpTitleView.h"

@interface TYPanelDpTitleView()

@property (nonatomic, strong) UILabel *numLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;


@end

@implementation TYPanelDpTitleView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        
        
        [self addSubview:self.numLabel];
        [self addSubview:self.titleLabel];
        [self addSubview:self.subTitleLabel];
        
    }
    return self;
}

- (UILabel *)numLabel {
    if (!_numLabel) {
        _numLabel = [TPViewUtil simpleLabel:CGRectMake(16, 17, 16, 16) f:10 tc:HEXCOLOR(0xFFFFFF) t:@""];
        _numLabel.backgroundColor = HEXCOLOR(0xFF5800);
        _numLabel.layer.masksToBounds = YES;
        _numLabel.layer.cornerRadius = _numLabel.width / 2.f;
        _numLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _numLabel;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [TPViewUtil simpleLabel:CGRectMake(self.numLabel.right + 5, 15, 120, 19) f:17 tc:HEXCOLOR(0x303030) t:@""];
        _titleLabel.centerY = _numLabel.centerY;
    }
    return _titleLabel;
}

- (UILabel *)subTitleLabel {
    if (!_subTitleLabel) {
        _subTitleLabel = [TPViewUtil simpleLabel:CGRectMake(15, self.numLabel.bottom, self.width - 15, 20) f:10 tc:HEXCOLOR(0x9B9B9B) t:@""];
    }
    return _subTitleLabel;
}

- (void)setItem:(NSInteger)num title:(NSString *)title subTitle:(NSString *)subTitle {
 
    self.numLabel.text = [NSString stringWithFormat:@"%lu",(long)num];
    self.titleLabel.text = title;
    self.subTitleLabel.text = subTitle;
    
}

@end
