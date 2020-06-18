//
//  TPItemView.h
//  TuyaSmart
//
//  Created by fengyu on 15/9/6.
//  Copyright (c) 2015年 Tuya. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TPDemoItemView;

@protocol TPItemViewDelegate <NSObject>

@optional

- (void)itemViewTap:(TPDemoItemView *)itemView;

- (void)itemViewLeftLabelTap:(TPDemoItemView *)itemView;
- (void)itemViewCenterLabelTap:(TPDemoItemView *)itemView;
- (void)itemViewRightLabelTap:(TPDemoItemView *)itemView;

- (void)itemViewLeftImageTap:(TPDemoItemView *)itemView;
- (void)itemViewCenterImageTap:(TPDemoItemView *)itemView;
- (void)itemViewRightImageTap:(TPDemoItemView *)itemView;

@end

@interface TPDemoItemView : UIView

@property (nonatomic, weak) id<TPItemViewDelegate> delegate;

@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) UILabel *rightLabel;
@property (nonatomic, strong) UILabel *centerLabel;

@property (nonatomic, strong) UIImage *leftImage;
@property (nonatomic, strong) UIImage *centerImage;
@property (nonatomic, strong) UIImage *rightImage;

@property (nonatomic, strong) UIView *topLine;
@property (nonatomic, strong) UIView *middleLine;
@property (nonatomic, strong) UIView *bottomLine;

@property (nonatomic, strong) UIImageView *rightArrow;

@property (nonatomic, strong) UISwitch *switchBtn;

+ (TPDemoItemView *)itemViewWithFrame:(CGRect)frame;

- (void)showTopLine;
- (void)showMiddleLine;
- (void)showBottomLine;

- (void)showRightArrow;
- (void)showSwitchBtn;

- (void)setRightLabelWidth:(float)width;

@end
