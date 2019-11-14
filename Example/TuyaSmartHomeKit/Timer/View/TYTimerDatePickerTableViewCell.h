//
//  TYTimerDatePickerTableViewCell.h
//  TuyaSmartHomeKit_Example
//
//  Created by Sakata Gintoki on 2019/11/12.
//  Copyright © 2019 xuchengcheng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TYTimerDatePickerTableViewCell : UITableViewCell

@property (nonatomic, copy) void(^timeChangeBlock)(NSString *time);

- (void)bindTimezonId:(NSString *)timezoneId time:(NSString *)time;
+ (CGFloat)cellHeight;
@end

NS_ASSUME_NONNULL_END
