//
//  TYUserInfoPhoneViewCell.h
//  TuyaSmartPublic
//
//  Created by 高森 on 16/5/16.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TYUserInfoPhoneViewCell : UITableViewCell

- (void)setPhoneNumber:(NSString *)phone showArrow:(BOOL)showArrow;

@property (nonatomic, strong) UILabel     *rightLabel;

@end
