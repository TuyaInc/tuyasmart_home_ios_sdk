//
//  TYTimerCommonTableViewCell.h
//  TuyaSmartHomeKit_Example
//
//  Created by Sakata Gintoki on 2019/11/13.
//  Copyright © 2019 xuchengcheng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TYTimerCommonTableViewCell : UITableViewCell

- (CGFloat)cellHeightWithLeft:(NSString *)left right:(NSString *)right;
- (void)setDataWithLeft:(NSString *)leftText rightText:(NSString *)rightText;
@end

NS_ASSUME_NONNULL_END
