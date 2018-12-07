//
//  TYPanelStringViewCell.m
//  TuyaSmartKitDemo
//
//  Created by 冯晓 on 16/8/27.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TYPanelStringViewCell.h"

@interface TYPanelStringViewCell()


@end

@implementation TYPanelStringViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
//        UIView *borderView = [[UIView alloc] initWithFrame:CGRectMake(0, (self.bgView.height - 34)/2, 150, 34)];
//        borderView.right = APP_CONTENT_WIDTH - 15;
//        borderView.backgroundColor = [UIColor clearColor];
//        borderView.layer.borderWidth = 1.f;
//        borderView.layer.borderColor = HEXCOLOR(0xDDDDDD).CGColor;
//        [self.bgView addSubview:borderView];
//        
//        
//        
        
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(0, (self.bgView.height - 34)/2.f, 150, 34)];
        _textField.right = APP_CONTENT_WIDTH - 15;
        _textField.font = [UIFont systemFontOfSize:14];
        _textField.textColor = HEXCOLOR(0x303030);
        _textField.placeholder = @"输入";//todo
        _textField.secureTextEntry = NO;
        _textField.enablesReturnKeyAutomatically = YES;
        _textField.clearButtonMode = UITextFieldViewModeNever;
        _textField.leftView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 4, 0)];
        _textField.rightView = [self rightView];
        _textField.leftViewMode = UITextFieldViewModeAlways;
        _textField.rightViewMode = UITextFieldViewModeAlways;
        _textField.layer.borderWidth = 1;
        _textField.layer.borderColor = HEXCOLOR(0xDDDDDD).CGColor;
        [self.bgView addSubview:_textField];
        
    }
    return self;
}


- (UIView *)rightView {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 34, 34)];
    view.backgroundColor = HEXCOLOR(0xFF5800);
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ty_panel_arrows"]];
    imageView.left = (view.width - imageView.width)/2.f;
    imageView.top = (view.height - imageView.height)/2.f;
    [view addSubview:imageView];
    
    return view;

}


@end
