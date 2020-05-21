//
//  TYTextFieldTableViewCell.h
//  TuyaSmartPublic
//
//  Created by XuChengcheng on 16/7/6.
//  Copyright © 2016年 Tuya. All rights reserved.
//


@interface TYTextFieldTableViewCell : UITableViewCell

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIImageView *iconImageView;

- (BOOL)becomeFirstResponder;

@end
