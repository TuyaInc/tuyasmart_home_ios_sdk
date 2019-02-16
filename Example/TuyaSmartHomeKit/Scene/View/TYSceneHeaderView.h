//
//  TYSceneHeaderView.h
//  TYSmartSceneLibrary
//
//  Created by XuChengcheng on 2017/5/2.
//  Copyright © 2017年 xcc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TYSceneHeaderViewDelegate <NSObject>

@optional

- (void)TYSceneHeaderViewDidDismiss;

@end

@interface TYSceneHeaderView : UIView

@property (nonatomic, weak) id<TYSceneHeaderViewDelegate> delegate;

@end
