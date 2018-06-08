//
//  TYContectToAPView.h
//  TuyaSmart
//
//  Created by fengyu on 15/4/10.
//  Copyright (c) 2015年 Tuya. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TYContectToAPView;

@protocol TYConnectToAPViewDelegate <NSObject>

- (void)helpAction:(TYContectToAPView *)connectToAPView;
- (void)nextAction:(TYContectToAPView *)connectToAPView;

@end

@interface TYContectToAPView : UIView

@property (nonatomic, assign) id<TYConnectToAPViewDelegate> delegate;

@end
