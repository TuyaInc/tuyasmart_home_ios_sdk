//
//  TPTextFieldView.m
//  TuyaSmart
//
//  Created by fengyu on 15/9/8.
//  Copyright (c) 2015年 TP. All rights reserved.
//

#import "TPTextFieldView.h"

@implementation TPTextFieldView

- (void)setRoundCorner:(BOOL)roundCorner {
    if (roundCorner) {
        self.layer.cornerRadius = 8;
        self.layer.masksToBounds = YES;
    }
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] init];
    }
    return _textField;
}

- (NSString *)text {
    return self.textField.text;
}

- (void)setText:(NSString *)text {
    self.textField.text = text;
}

- (void)setTextColor:(UIColor *)textColor {
    self.textField.textColor = textColor;
}

- (void)setPlaceholder:(NSString *)placeholder {
    self.textField.placeholder = placeholder;
}

- (void)setRightImage:(UIImage *)rightImage {
    if (_rightImage != rightImage) {
        _rightImage = rightImage;
        [self setNeedsLayout];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    float leftContentInsets = 15;
    
    if (_leftImage) {
        UIImageView *leftImageView = [[UIImageView alloc] initWithImage:_leftImage];
        leftImageView.frame = CGRectMake(10, (self.height-leftImageView.height)/2, leftImageView.width, leftImageView.height);
        [self addSubview:leftImageView];
        
        leftContentInsets += leftImageView.width + 10;
    }
    
    float rightContentInsets = 15;
    
    if (_rightImage) {
        UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(self.width - 50, 0, 50, self.height)];
        [rightButton setImage:_rightImage forState:UIControlStateNormal];
        if (_rightImageSelected) {
            [rightButton setImage:_rightImageSelected forState:UIControlStateSelected];
        }
        [rightButton addTarget:self action:@selector(rightItemTap:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:rightButton];
        
        rightContentInsets += rightButton.width;
    }
    
    self.textField.frame = CGRectMake(leftContentInsets, 0.5, self.width-leftContentInsets-rightContentInsets, self.height-1);
    [self addSubview:self.textField];
}

- (void)rightItemTap:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(textFieldRightItemViewTap)]) {
        button.selected = !button.selected;
        [self.delegate textFieldRightItemViewTap];
    }
}

@end
