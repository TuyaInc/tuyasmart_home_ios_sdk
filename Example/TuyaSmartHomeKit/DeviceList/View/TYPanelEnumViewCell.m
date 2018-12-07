//
//  TYPanelEnumViewCell.m
//  TuyaSmartKitDemo
//
//  Created by 冯晓 on 16/8/27.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TYPanelEnumViewCell.h"

@interface TYPanelEnumViewCell()



@end

@implementation TYPanelEnumViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        
        UIView *borderView = [[UIView alloc] initWithFrame:CGRectMake(0, (self.bgView.height - 34)/2, 150, 34)];
        borderView.right = APP_CONTENT_WIDTH - 15;
        borderView.backgroundColor = [UIColor clearColor];
        borderView.layer.borderWidth = 1.f;
        borderView.layer.borderColor = HEXCOLOR(0xDDDDDD).CGColor;
        borderView.layer.cornerRadius = 4;
        [self.bgView addSubview:borderView];
        
        
        _switchLabel = [TPViewUtil simpleLabel:CGRectMake(10, 0, borderView.width - 10 - 16, borderView.height) f:14 tc:HEXCOLOR(0x303030) t:@"高档"];
        _switchLabel.userInteractionEnabled = YES;
        [borderView addSubview:_switchLabel];
        
        
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, (borderView.height - 14)/2.f, 6, 14)];
        imageView.right = borderView.width - 10;
        imageView.image = [UIImage imageNamed:@"ty_panel_select"];
        [borderView addSubview:imageView];
        
    }
    return self;
}


@end
