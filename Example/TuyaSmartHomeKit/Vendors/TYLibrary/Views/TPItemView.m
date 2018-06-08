//
//  TPItemView.m
//  TuyaSmart
//
//  Created by fengyu on 15/9/6.
//  Copyright (c) 2015年 Tuya. All rights reserved.
//

#import "TPItemView.h"
#import "TPViewUtil.h"
#import "TPViews.h"

typedef enum {
    TPItemViewImagePositionLeft = 1,
    TPItemViewImagePositionCenter,
    TPItemViewImagePositionRight,
} TPItemViewImagePosition;


@interface TPItemView()

@property(nonatomic,strong) UIImageView *leftImageView;
@property(nonatomic,strong) UIImageView *centerImageView;
@property(nonatomic,strong) UIImageView *rightImageView;

@end

@implementation TPItemView

+ (TPItemView *)itemViewWithFrame:(CGRect)frame {
    return [[TPItemView alloc] initWithFrame:frame];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = LIST_BACKGROUND_COLOR;
        [self addGestureRecognizer:[TPViewUtil singleFingerClickRecognizer:self sel:@selector(itemViewTap)]];
    }
    return self;
}

- (void)itemViewTap {
    if ([self.delegate respondsToSelector:@selector(itemViewTap:)]) {
        [self.delegate itemViewTap:self];
    }
}

- (UIView *)topLine {
    if (!_topLine) {
        _topLine = [self customLine:CGPointMake(0, 0) width:self.width color:LIST_LINE_COLOR];
        [self addSubview:_topLine];
    }
    return _topLine;
}

- (UIView *)middleLine {
    if (!_middleLine) {
        _middleLine = [self customLine:CGPointMake(15, self.frame.size.height-0.5) width:self.width-15 color:LIST_LINE_COLOR];
        [self addSubview:_middleLine];
    }
    return _middleLine;
}

- (UIView *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [self customLine:CGPointMake(0, self.frame.size.height-0.5) width:self.width color:LIST_LINE_COLOR];
        [self addSubview:_bottomLine];
    }
    return _bottomLine;
}

- (UIView *)customLine:(CGPoint)origin width:(float)width color:(UIColor *)color {
    return [TPViewUtil viewWithFrame:CGRectMake(origin.x, origin.y, width, 0.5) color:color];
}

- (void)showTopLine {
    self.topLine.hidden = NO;
}

- (void)showMiddleLine {
    self.middleLine.hidden = NO;
}

- (void)showBottomLine {
    self.bottomLine.hidden = NO;
}

- (UILabel *)leftLabel {
    if (!_leftLabel) {
        UIView *labelView = [TPViewUtil viewWithFrame:CGRectMake(0, 0.5, 200, self.height-1) color:nil];
        
        _leftLabel = [TPViewUtil labelWithFrame:CGRectMake(15, 0, 200, self.height) fontSize:18 color:LIST_MAIN_TEXT_COLOR];
        _leftLabel.adjustsFontSizeToFitWidth = YES;
        
        [labelView addSubview:_leftLabel];
        [labelView addGestureRecognizer:[TPViewUtil singleFingerClickRecognizer:self sel:@selector(leftLabelTap)]];
        [self addSubview:labelView];
    }
    return _leftLabel;
}

- (UILabel *)rightLabel {
    if (!_rightLabel) {
        UIView *labelView = [TPViewUtil viewWithFrame:CGRectMake(self.width - 150, 0.5, 150, self.height-1) color:nil];
        
        _rightLabel = [TPViewUtil labelWithFrame:CGRectMake(0,0,115, self.height) fontSize:18 color:LIST_MAIN_TEXT_COLOR];
        _rightLabel.textAlignment = NSTextAlignmentRight;
        _rightLabel.adjustsFontSizeToFitWidth = YES;
        
        [labelView addSubview:_rightLabel];
        [labelView addGestureRecognizer:[TPViewUtil singleFingerClickRecognizer:self sel:@selector(rightLabelTap)]];
        [self addSubview:labelView];
    }
    return _rightLabel;
}

- (void)setRightLabelWidth:(float)width {
    UIView *labelView = self.rightLabel.superview;
    labelView.frame = CGRectMake(self.width-width, 0.5, width, self.height-1);
    self.rightLabel.frame = CGRectMake(0,0, width-35,labelView.height);
}

- (UILabel *)centerLabel {
    if (!_centerLabel) {
        UIView *labelView = [TPViewUtil viewWithFrame:CGRectMake((self.width - 150)/2, 0.5, 150, self.height-1) color:nil];
        
        _centerLabel = [TPViewUtil labelWithFrame:CGRectMake(0,0,150,self.height) fontSize:18 color:LIST_MAIN_TEXT_COLOR];
        _centerLabel.textAlignment = NSTextAlignmentCenter;
        _centerLabel.adjustsFontSizeToFitWidth = YES;
        
        [labelView addSubview:_centerLabel];
        [labelView addGestureRecognizer:[TPViewUtil singleFingerClickRecognizer:self sel:@selector(centerLabelTap)]];
        [self addSubview:labelView];
    }
    return _centerLabel;
}

- (void)leftLabelTap {
    if ([self.delegate respondsToSelector:@selector(itemViewLeftLabelTap:)]) {
        [self.delegate itemViewLeftLabelTap:self];
    } else if ([self.delegate respondsToSelector:@selector(itemViewTap:)]) {
        [self.delegate itemViewTap:self];
    }
}

- (void)centerLabelTap {
    if ([self.delegate respondsToSelector:@selector(itemViewCenterLabelTap:)]) {
        [self.delegate itemViewCenterLabelTap:self];
    } else if ([self.delegate respondsToSelector:@selector(itemViewTap:)]) {
        [self.delegate itemViewTap:self];
    }
}

- (void)rightLabelTap {
    if ([self.delegate respondsToSelector:@selector(itemViewRightLabelTap:)]) {
        [self.delegate itemViewRightLabelTap:self];
    } else if ([self.delegate respondsToSelector:@selector(itemViewTap:)]) {
        [self.delegate itemViewTap:self];
    }
}

- (UIImageView *) rightArrow {
    if (!_rightArrow) {
        _rightArrow = [self imageViewForItemView:TPItemViewImagePositionRight image:[UIImage imageNamed:@"tp_list_arrow_goto"]];
        [self addSubview:_rightArrow];
    }
    return _rightArrow;
}

- (void)showRightArrow {
    self.rightArrow.hidden = NO;
}

- (void)setLeftImage:(UIImage *)leftImage {
    _leftImageView = [self imageViewForItemView:TPItemViewImagePositionLeft image:leftImage];
    [_leftImageView addGestureRecognizer:[TPViewUtil singleFingerClickRecognizer:self sel:@selector(leftImageViewTap)]];
    [self addSubview:_leftImageView];
}

- (void)setCenterImage:(UIImage *)centerImage {
    _centerImageView = [self imageViewForItemView:TPItemViewImagePositionCenter image:centerImage];
    [_centerImageView addGestureRecognizer:[TPViewUtil singleFingerClickRecognizer:self sel:@selector(centerImageViewTap)]];
    [self addSubview:_centerImageView];
}

- (void)setRightImage:(UIImage *)rightImage {
    if (!_rightImageView) {
        _rightImageView = [self imageViewForItemView:TPItemViewImagePositionRight image:rightImage];
        [_rightImageView addGestureRecognizer:[TPViewUtil singleFingerClickRecognizer:self sel:@selector(rightImageViewTap)]];
        [self addSubview:_rightImageView];
    }
}

- (UIImageView *)imageViewForItemView:(TPItemViewImagePosition)position image:(UIImage *)image {
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    CGRect frame = imageView.frame;
    
    switch (position) {
        case TPItemViewImagePositionCenter : {
            frame.origin = CGPointMake((self.frame.size.width-frame.size.width)/2, (self.frame.size.height -frame.size.height)/2);
            break;
        }
        case TPItemViewImagePositionRight : {
            frame.origin = CGPointMake(self.frame.size.width - frame.size.width - 20, (self.frame.size.height -frame.size.height)/2);
            break;
        }
        default : {
            frame.origin = CGPointMake(20, (self.frame.size.height -frame.size.height)/2);
            break;
        }
    }
    
    imageView.frame = frame;
    return imageView;
}

- (void)leftImageViewTap {
    if ([self.delegate respondsToSelector:@selector(itemViewLeftImageTap:)]) {
        [self.delegate itemViewLeftImageTap:self];
    } else if ([self.delegate respondsToSelector:@selector(itemViewTap:)]) {
        [self.delegate itemViewTap:self];
    }
}

- (void)centerImageViewTap {
    if ([self.delegate respondsToSelector:@selector(itemViewCenterImageTap:)]) {
        [self.delegate itemViewCenterImageTap:self];
    } else if ([self.delegate respondsToSelector:@selector(itemViewTap:)]) {
        [self.delegate itemViewTap:self];
    }
}

- (void)rightImageViewTap {
    if ([self.delegate respondsToSelector:@selector(itemViewRightImageTap:)]) {
        [self.delegate itemViewRightImageTap:self];
    } else if ([self.delegate respondsToSelector:@selector(itemViewTap:)]) {
        [self.delegate itemViewTap:self];
    }
}

- (void)showSwitchBtn {
    _switchBtn = [[UISwitch alloc] init];
    _switchBtn.left = self.width - _switchBtn.width - 15;
    _switchBtn.top = (self.height - _switchBtn.height)/2;
    [self addSubview:_switchBtn];
}

@end
