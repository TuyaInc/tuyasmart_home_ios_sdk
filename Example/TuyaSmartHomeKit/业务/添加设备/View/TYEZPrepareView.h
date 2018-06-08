//
//  TYEZPrepareView.h
//  TuyaSmartPublic
//
//  Created by 高森 on 16/3/29.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TYEZPrepareView;

@protocol TYEZPrepareViewDelegate <NSObject>

- (void)helpAction:(TYEZPrepareView *)prepareView;
- (void)nextAction:(TYEZPrepareView *)prepareView;

@end

@interface TYEZPrepareView : UIView

@property (nonatomic, weak) id<TYEZPrepareViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame mode:(TYActivatorMode)mode;
- (void)setTipText:(NSString *)text;

@end
