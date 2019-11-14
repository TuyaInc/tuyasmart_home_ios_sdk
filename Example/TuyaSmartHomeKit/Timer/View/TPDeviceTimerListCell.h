//
//  TPDeviceTimerListCell.h
//  fishNurse
//
//  Created by 冯晓 on 16/2/22.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TPTimerListDelagate <NSObject>

- (void)reloadData;

@optional

- (void)updateTimerStatus:(TYTimerModel *)model switcher:(UISwitch *)switcher;

@end

@interface TPDeviceTimerListCell : UITableViewCell

@property (nonatomic, weak) id<TPTimerListDelagate> delegate;
//@property(nonatomic,strong) UIView *bottomLineView;
- (void)setItem:(TYTimerModel *)model modeText:(NSString *)modeText;
+ (CGFloat)heightWithString:(NSString *)str;
@end
