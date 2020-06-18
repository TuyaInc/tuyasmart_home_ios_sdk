//
//  TPViewCell.h
//  TuyaSmart
//
//  Created by fengyu on 15/9/8.
//  Copyright (c) 2015年 TP. All rights reserved.
//

#import "TPDemoBaseView.h"
#import "TPDemoCellViewItem.h"

@class TPDemoCellView;

@protocol TPDemoCellViewDelegate <NSObject>

- (void)TPCellViewTap:(TPDemoCellView *)TPCellView;

@end

@interface TPDemoCellView : TPDemoBaseView

@property (nonatomic, weak) id<TPDemoCellViewDelegate> delegate;

@property (nonatomic, assign) BOOL roundCorner;

@property (nonatomic, strong) TPDemoCellViewItem *leftItem;
@property (nonatomic, strong) TPDemoCellViewItem *centerItem;
@property (nonatomic, strong) TPDemoCellViewItem *rightItem;

+ (TPDemoCellView *)seperateCellView:(CGRect)frame  backgroundColor:(UIColor *)backgroundColor;

- (void)showRightArrow;

@end
