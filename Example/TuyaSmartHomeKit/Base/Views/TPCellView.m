//
//  TPViewCell.m
//  TuyaSmart
//
//  Created by fengyu on 15/9/8.
//  Copyright (c) 2015年 TP. All rights reserved.
//

#import "TPCellView.h"

@implementation TPCellView

+ (TPCellView *)seperateCellView:(CGRect)frame  backgroundColor:(UIColor *)backgroundColor {
    TPCellView *seperateCellView = [[TPCellView alloc] initWithFrame:frame];
    seperateCellView.topLineHidden = YES;
    seperateCellView.bottomLineHidden = YES;
    if (backgroundColor != nil) {
        seperateCellView.backgroundColor = backgroundColor;
    }
    return seperateCellView;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)setDelegate:(NSObject<TPCellViewDelegate> *)delegate {
    if (!_delegate) {
        [self addGestureRecognizer:[TPViewUtil singleFingerClickRecognizer:self sel:@selector(viewCellTap)]];        
    }
    _delegate = delegate;
}

- (void)setRoundCorner:(BOOL)roundCorner {
    if (roundCorner) {
        self.layer.cornerRadius = 8;
        self.layer.masksToBounds = YES;
    }
}

- (void)setRightItem:(TPCellViewItem *)rightItem {
    if (_rightItem != rightItem) {
        _rightItem = rightItem;
        [self setNeedsLayout];
    }
}

- (void)viewCellTap {
    if ([self.delegate respondsToSelector:@selector(TPCellViewTap:)]) {
        [self.delegate TPCellViewTap:self];
    }
}

- (void)showRightArrow {
    if (!_rightItem) {
        _rightItem = [[TPCellViewItem alloc] init];
    }
    _rightItem.image = [UIImage imageNamed:@"tp_list_arrow_goto"];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (_leftItem) {
        if (_leftItem.customView != nil) {
            _leftItem.customView.frame = CGRectMake(0,(self.height-_leftItem.customView.height)/2, _leftItem.customView.width, _leftItem.customView.height);
            [self addSubview:_leftItem.customView];
        } else {
            float contentInsets = 15;
            
            if (_leftItem.image != nil) {
                UIImageView *imageView = [[UIImageView alloc] initWithImage:_leftItem.image];
                imageView.frame = CGRectMake(contentInsets, (self.height-imageView.height)/2, imageView.width, imageView.height);
                [self addSubview:imageView];
                
                contentInsets += imageView.width + 10;
            }
            
            if (_leftItem.title != nil) {
                UIColor *textColor;
                if (_leftItem.textColor != nil) {
                    textColor = _leftItem.textColor;
                } else {
                    textColor = LIST_MAIN_TEXT_COLOR;
                }
                
                float fontSize;
                if (_leftItem.fontSize == 0) {
                    fontSize = 16;
                } else {
                    fontSize = _leftItem.fontSize;
                }
                
                UILabel *titlelabel = [[UILabel alloc] initWithFrame:CGRectMake(contentInsets, 0.5, 150, self.height-1)];
                titlelabel.textColor = textColor;
                titlelabel.font = [UIFont systemFontOfSize:fontSize];
                titlelabel.text = _leftItem.title;
                [self addSubview:titlelabel];
                
                CGFloat width =  [_leftItem.title sizeWithAttributes:@{NSFontAttributeName : titlelabel.font}].width;
                titlelabel.width = width;
            }
        }
    }
    
    if (_centerItem) {
        if (_centerItem.customView != nil) {
            _centerItem.customView.frame = CGRectMake((self.width-_centerItem.customView.width)/2,(self.height-_centerItem.customView.height)/2, _centerItem.customView.width, _centerItem.customView.height);
            [self addSubview:_centerItem.customView];
        } else {
            if (_centerItem.image != nil) {
                UIImageView *imageView = [[UIImageView alloc] initWithImage:_centerItem.image];
                imageView.frame = CGRectMake((self.width-imageView.width)/2, (self.height-imageView.height)/2, imageView.width, imageView.height);
                [self addSubview:imageView];
            } else if (_centerItem.title != nil) {
                UIColor *textColor;
                if (_centerItem.textColor != nil) {
                    textColor = _centerItem.textColor;
                } else {
                    textColor = LIST_MAIN_TEXT_COLOR;
                }
                
                float fontSize;
                if (_centerItem.fontSize == 0) {
                    fontSize = 16;
                } else {
                    fontSize = _centerItem.fontSize;
                }

                UILabel *titlelabel = [[UILabel alloc] initWithFrame:CGRectMake((self.width-150)/2, 0.5, 150, self.height-1)];
                titlelabel.textAlignment = NSTextAlignmentCenter;
                titlelabel.textColor = textColor;
                titlelabel.font = [UIFont systemFontOfSize:fontSize];
                titlelabel.text = _centerItem.title;
                [self addSubview:titlelabel];
            }
        }
    }
    
    if (_rightItem) {
        if (_rightItem.customView != nil) {
            _rightItem.customView.frame = CGRectMake(self.width-_rightItem.customView.width,(self.height-_rightItem.customView.height)/2, _rightItem.customView.width, _rightItem.customView.height);
            [self addSubview:_rightItem.customView];
        } else {
            float contentInsets = 10;
            
            if (_rightItem.image != nil) {
                UIImageView *imageView = [[UIImageView alloc] initWithImage:_rightItem.image];
                imageView.frame = CGRectMake(self.width-imageView.width-contentInsets, (self.height-imageView.height)/2, imageView.width, imageView.height);
                [self addSubview:imageView];
                
                contentInsets += imageView.width + 10;
            }
            
            if (_rightItem.title != nil) {
                UIColor *textColor;
                if (_rightItem.textColor != nil) {
                    textColor = _rightItem.textColor;
                } else {
                    textColor = LIST_MAIN_TEXT_COLOR;
                }
                
                float fontSize;
                if (_rightItem.fontSize == 0) {
                    fontSize = 16;
                } else {
                    fontSize = _rightItem.fontSize;
                }
                
                UILabel *titlelabel = [[UILabel alloc] initWithFrame:CGRectMake(self.width-150-contentInsets, 0.5, 150, self.height-1)];
                titlelabel.textAlignment = NSTextAlignmentRight;
                titlelabel.textColor = textColor;
                titlelabel.font = [UIFont systemFontOfSize:fontSize];
                titlelabel.text = _rightItem.title;
                [self addSubview:titlelabel];
            }
        }
    }
}

@end
