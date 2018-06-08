//
//  TYSceneActionView.h
//  TYSmartSceneLibrary
//
//  Created by XuChengcheng on 2017/4/30.
//  Copyright © 2017年 xcc. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol TYSceneActionViewDelegate <NSObject>

@optional

- (void)TYSceneActionViewDidDismiss;

@end

@interface TYSceneActionView : UIView

@property (nonatomic, weak) id<TYSceneActionViewDelegate> delegate;

- (void)showWithTitle:(NSString *)title actList:(NSArray *)actList;
- (void)updateCellStateWithDevId:(NSString *)devId dps:(NSDictionary *)dps;

@end
