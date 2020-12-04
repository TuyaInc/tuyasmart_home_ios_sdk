//
//  TYSliderView.m
//  TuyaSmartPublic
//
//  Created by 冯晓 on 2018/2/2.
//  Copyright © 2018年 Tuya. All rights reserved.
//

#import "TYSliderView.h"
#import "TYSlider.h"
#import "UIColor+TYHex.h"
#import "TPDemoViewConstants.h"
#import "UILabel+TYFactory.h"


@interface TYSliderView()

@property (nonatomic, strong) TYSlider *slider;

@end

@implementation TYSliderView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.tipsLabel];
        [self addSubview:self.slider];
        [self addSubview:self.percentLabel];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        [self.slider addGestureRecognizer:tap];
    }
    
    return self;
}

- (void)tap:(UITapGestureRecognizer *)reg {
    CGFloat sliderW = self.slider.width;
    CGFloat sliderX = [reg locationInView:self.slider].x;

    CGFloat percentValue = sliderX / sliderW;

    percentValue = MIN(MAX(0, percentValue),1);
    [self setSliderValue:percentValue];
    
    [self sliderDragEnd];
}

- (UILabel *)tipsLabel {
    
    if (!_tipsLabel) {
        _tipsLabel = [UILabel ty_labelWithText:@"" font:[UIFont systemFontOfSize:10] textColor:TY_HexColor(0x6480B3) frame:CGRectMake(4, 0, self.width, 16)];
    }
    return _tipsLabel;
    
}

- (UILabel *)percentLabel {
    if (!_percentLabel) {
        _percentLabel =  [UILabel ty_labelWithText:@"" font:[UIFont systemFontOfSize:10] textColor:TY_HexColor(0x6480B3) frame:CGRectMake(self.width - 15 - 20, self.height - 24, 30, 24)];
    }
    return _percentLabel;
}

- (TYSlider *)slider {
    if (!_slider) {
        _slider = [[TYSlider alloc] initWithFrame:CGRectMake(0, self.height - 24, self.width - 55, 24)];
        _slider.minimumValue = 0.f;
        _slider.maximumValue = 1.f;
        _slider.minimumTrackTintColor = TY_HexColor(0x6480B3);
        _slider.maximumTrackTintColor = TY_HexAlphaColor(0x6480B3, 0.1);
        _slider.thumbTintColor = [UIColor clearColor];
        
        UIImage *image = [UIImage tysdkdemo_DeviceListImageNamed:@"ty_slider_thumb"];
        [_slider setThumbImage:image forState:UIControlStateNormal];
        [_slider setThumbImage:image forState:UIControlStateSelected];
        [_slider setThumbImage:image forState:UIControlStateHighlighted];
        
        UIControlEvents events = (UIControlEventTouchUpInside |
                                  UIControlEventTouchUpOutside |
                                  UIControlEventTouchCancel
                                  );
        [_slider addTarget:self action:@selector(sliderDragEnd) forControlEvents:events];
        [_slider addTarget:self action:@selector(valueChange) forControlEvents:(UIControlEventValueChanged)];
    }
    return _slider;
}

- (void)valueChange {
    self.percentLabel.text = [NSString stringWithFormat:@"%.0f%%",_slider.value * 100];
    
}

- (void)sliderDragEnd{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didChangeSliderValue:value:)]) {
        [self.delegate didChangeSliderValue:self value:_slider.value];
    }
}

- (void)setSliderValue:(double)value {
    _slider.value = value;
    self.percentLabel.text = [NSString stringWithFormat:@"%.0f%%",value * 100];
}

- (void)setMinValue:(CGFloat)minValue {
    _slider.minimumValue = minValue;
}

- (void)setMaxValue:(CGFloat)maxValue {
    _slider.maximumValue = maxValue;
    
}
@end
