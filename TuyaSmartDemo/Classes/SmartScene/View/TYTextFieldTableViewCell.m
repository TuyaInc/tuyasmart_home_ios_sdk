//
//  TYTextFieldTableViewCell.m
//  TuyaSmartPublic
//
//  Created by XuChengcheng on 16/7/6.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TYTextFieldTableViewCell.h"

@interface TYTextFieldTableViewCell()

@end

@implementation TYTextFieldTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(16, (60 - 120 * 66 / 163) / 2.0, 120, 120 * 66 / 163)];
        _iconImageView.userInteractionEnabled = YES;
        _iconImageView.layer.cornerRadius = 6.0;
        _iconImageView.layer.masksToBounds = YES;
        [self.contentView addSubview:_iconImageView];
        
        _textField = [self getTextFieldView:CGRectMake(140, 21, APP_CONTENT_WIDTH - 10 - 130, 20)];
        [self.contentView addSubview:_textField];
    }
    return self;
}

- (UITextField *)getTextFieldView:(CGRect)frame{
    UITextField *textField = [[UITextField alloc] initWithFrame:frame];
    
    textField.font = [UIFont systemFontOfSize:14];
    textField.textColor = HEXCOLOR(0x303030);
    textField.secureTextEntry = NO;
    textField.enablesReturnKeyAutomatically = YES;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.leftView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 5, 0)];
    textField.leftViewMode = UITextFieldViewModeAlways;
    
    return textField;
}

- (BOOL)becomeFirstResponder {
    return [_textField becomeFirstResponder];
}


@end
