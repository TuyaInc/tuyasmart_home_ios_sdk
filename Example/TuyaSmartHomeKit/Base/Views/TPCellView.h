//
//  TPViewCell.h
//  TuyaSmart
//
//  Created by fengyu on 15/9/8.
//  Copyright (c) 2015年 TP. All rights reserved.
//

#import "TPBaseView.h"
#import "TPCellViewItem.h"

@class TPCellView;

@protocol TPCellViewDelegate <NSObject>

- (void)TPCellViewTap:(TPCellView *)TPCellView;

@end

@interface TPCellView : TPBaseView

@property (nonatomic, weak) id<TPCellViewDelegate> delegate;

@property (nonatomic, assign) BOOL roundCorner;

@property (nonatomic, strong) TPCellViewItem *leftItem;
@property (nonatomic, strong) TPCellViewItem *centerItem;
@property (nonatomic, strong) TPCellViewItem *rightItem;

+ (TPCellView *)seperateCellView:(CGRect)frame  backgroundColor:(UIColor *)backgroundColor;

- (void)showRightArrow;

@end
