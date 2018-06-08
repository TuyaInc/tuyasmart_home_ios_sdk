//
//  TYBaseLayout.h
//  TuyaSmart
//
//  Created by 冯晓 on 16/1/4.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPTopBarView.h"

@protocol TPTopBarViewDelegate <NSObject>

@optional
- (void)topBarLeftItemTap;
- (void)topBarCenterItemTap;
- (void)topBarRightItemTap;

@end


@interface TPBaseLayout : UIView

@property (nonatomic, weak) id<TPTopBarViewDelegate> topBarDelegate;
@property (nonatomic, strong) TPTopBarView *topBarView;

- (void)reloadData;

@end
