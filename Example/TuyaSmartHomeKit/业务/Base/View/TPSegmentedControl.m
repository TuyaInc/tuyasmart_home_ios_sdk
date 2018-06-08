//
//  TPSegmentedControl.m
//  TuyaSmartPublic
//
//  Created by 冯晓 on 16/4/15.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TPSegmentedControl.h"
#import "TPViewUtil.h"
#import "UIView+TPAdditions.h"

@interface TPSegmentedControl()

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) UIView  *lineView;

@end

@implementation TPSegmentedControl

- (instancetype)initWithFrame:(CGRect)frame items:(NSArray <NSString *> *)items {

    if (self = [super initWithFrame:frame]) {
        _items = items;
        _index = 0;
        
        [self reloadView];
        
    }
    
    return self;
    
}

- (void)reloadView {
    
    NSInteger count = _items.count;
    
    for (NSInteger i = 0 ; i < count ; i++) {
        
        UIButton *btn = [TPViewUtil buttonWithFrame:CGRectMake(i * self.width / count, 0, self.width / count, self.height) fontSize:13 bgColor:nil textColor:_color];
        [btn setTitleColor:(i == _index) ? _hightLightColor : _color forState:UIControlStateNormal];
        [btn setTitle:[_items objectAtIndex:i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i;
        [self addSubview:btn];
    }
    
    _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - 2, self.width / count, 2)];
    _lineView.backgroundColor = _hightLightColor;
    [self addSubview:_lineView];
    
}

- (void)setHightLightColor:(UIColor *)hightLightColor {
    _hightLightColor = hightLightColor;
    _lineView.backgroundColor = hightLightColor;
    [self setIndex:_index];
}

- (void)segmentAction:(UIButton *)button {
    if (_index != button.tag) {
        [self setIndex:button.tag];
    }
}


- (void)setIndex:(NSInteger)index {
    if (index >= _items.count) {
        return;
    }
    
    BOOL canSelect = YES;
    if (self.delegate && [self.delegate respondsToSelector:@selector(segmentControl:canSelectIndex:)]) {
        canSelect = [self.delegate segmentControl:self canSelectIndex:index];
    }
    if (canSelect == NO) {
        return;
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(segmentControl:didSelectCurrentIndex:)]) {
        [self.delegate segmentControl:self didSelectCurrentIndex:index];
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        _lineView.left = index * _lineView.width;
        
        
    } completion:^(BOOL finished) {
        _index = index;
    }];
    
    
    for (id view in self.subviews) {
        if ([view isMemberOfClass:[UIButton class]]) {
            UIButton *button = view;
            [button setTitleColor:(button.tag == index) ? _hightLightColor : _color forState:UIControlStateNormal];
            button.titleLabel.font      = (button.tag == index) ? [UIFont boldSystemFontOfSize:13] : [UIFont systemFontOfSize:13];
        }
    }
}

@end
