//
//  TYPanelValueViewCell.m
//  TuyaSmartKitDemo
//
//  Created by 冯晓 on 16/8/27.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TYPanelValueViewCell.h"

@interface TYPanelValueViewCell()

@property (nonatomic, strong) UIView *leftLine;
@property (nonatomic, strong) UIView *rightLine;

@end

@implementation TYPanelValueViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.bgView addSubview:self.plusButton];
        [self.bgView addSubview:self.rightLine];
        [self.bgView addSubview:self.titleLabel];
        [self.bgView addSubview:self.leftLine];
        [self.bgView addSubview:self.minButton];
        
    }
    return self;
}


- (UIButton *)plusButton {
    if (!_plusButton) {
        _plusButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _plusButton.backgroundColor = [UIColor clearColor];
        _plusButton.frame = CGRectMake(0, (self.bgView.height - 15)/2.f, 15, 15);
        _plusButton.right = APP_CONTENT_WIDTH - 25;
        [_plusButton setImage:[UIImage imageNamed:@"ty_panel_plus"] forState:UIControlStateNormal];
    }
    return _plusButton;
    
}


- (UIView *)rightLine {
    if (!_rightLine) {
        _rightLine = [[UIView alloc] initWithFrame:CGRectMake(0, (self.bgView.height - 36)/2.f, 0.5, 36)];
        _rightLine.right = self.plusButton.left - 22;
        _rightLine.backgroundColor = HEXCOLOR(0xDDDDDD);
    }
    return _rightLine;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [TPViewUtil simpleLabel:CGRectMake(0, 0, 56, self.bgView.height) f:18 tc:HEXCOLOR(0x303030) t:@"0"];
        _titleLabel.right = self.rightLine.left;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}


- (UIView *)leftLine {
    if (!_leftLine) {
        _leftLine = [[UIView alloc] initWithFrame:CGRectMake(0, (self.bgView.height - 36)/2.f, 0.5, 36)];
        _leftLine.right = self.titleLabel.left;
        _leftLine.backgroundColor = HEXCOLOR(0xDDDDDD);
    }
    return _leftLine;
    
}



- (UIButton *)minButton {
    if (!_minButton) {
        _minButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _minButton.backgroundColor = [UIColor clearColor];
        _minButton.frame = CGRectMake(0, (self.bgView.height - 15)/2.f, 15, 15);
        [_minButton setImage:[UIImage imageNamed:@"ty_panel_minus"] forState:UIControlStateNormal];
        _minButton.right = self.leftLine.left - 22;
    }
    return _minButton;
}




@end
