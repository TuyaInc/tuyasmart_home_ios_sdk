//
//  TYAPResetView.h
//  TuyaSmartPublic
//
//  Created by 高森 on 16/3/29.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TYAPResetView;

@protocol TYAPResetViewDelegate <NSObject>

@required

- (void)helpAction:(TYAPResetView *)resetView;
- (void)nextAction:(TYAPResetView *)resetView;

@end

@interface TYAPResetView : UIView

@property (nonatomic, weak) id <TYAPResetViewDelegate> delegate;
@property (nonatomic, strong) UILabel *tipLabel;

@end
