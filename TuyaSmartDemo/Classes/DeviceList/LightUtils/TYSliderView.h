//
//  TYSliderView.h
//  TuyaSmartPublic
//
//  Created by 冯晓 on 2018/2/2.
//  Copyright © 2018年 Tuya. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TYSliderView;

@protocol TYSliderViewDelegate <NSObject>

- (void)didChangeSliderValue:(TYSliderView *)slider value:(double)value;

@end

@interface TYSliderView : UIView

@property (nonatomic, strong) UILabel *tipsLabel;
@property (nonatomic, strong) UILabel *percentLabel;
@property (nonatomic, strong) UILabel *valueLabel;
@property (nonatomic, assign) BOOL  isShowValue;
@property (nonatomic, assign) CGFloat  minValue;
@property (nonatomic, assign) CGFloat  maxValue;
@property (nonatomic, weak) id <TYSliderViewDelegate> delegate;

- (void)setSliderValue:(double)value;

@end
