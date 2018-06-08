//
//  TPSegmentedControl.h
//  TuyaSmartPublic
//
//  Created by 冯晓 on 16/4/15.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TPSegmentedControl;

@protocol TPSegmentedControlDelegate <NSObject>

@required
- (BOOL)segmentControl:(TPSegmentedControl *)segmentControl canSelectIndex:(NSInteger)index;
- (void)segmentControl:(TPSegmentedControl *)segmentControl didSelectCurrentIndex:(NSInteger)index;

@end

@interface TPSegmentedControl : UIView

@property (nonatomic, strong) UIColor *color;
@property (nonatomic, strong) UIColor *hightLightColor;
@property (nonatomic, weak) id <TPSegmentedControlDelegate> delegate;
@property (nonatomic, assign) NSInteger index;

- (instancetype)initWithFrame:(CGRect)frame items:(NSArray <NSString *> *)items;

@end
