//
//  TYTimerSwitchTableViewCell.h
//  TuyaSmartHomeKit_Example
//
//  Created by Sakata Gintoki on 2019/11/13.
//  Copyright © 2019 xuchengcheng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TYTimerSwitchTableViewCell : UITableViewCell

@property (nonatomic, copy) void(^switchBlock)(BOOL on);
- (void)setOn:(BOOL)on;
+ (CGFloat)cellHeight;
@end

NS_ASSUME_NONNULL_END
