//
//  TYSelectDPTableViewCell.m
//  TuyaSmartPublic
//
//  Created by XuChengcheng on 16/7/7.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TYSelectDPTableViewCell.h"

@implementation TYSelectDPTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _titleLabel = [TPViewUtil simpleLabel:CGRectMake(15, 0, APP_SCREEN_WIDTH - 200, 48) f:16 tc:HEXCOLOR(0x303030) t:@""];
        [self.contentView addSubview:_titleLabel];
        
        _selectedImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ty_scene_selected"]];
        _selectedImageView.frame = CGRectMake(APP_SCREEN_WIDTH - 30, (48 - _selectedImageView.height) / 2.f, _selectedImageView.width, _selectedImageView.height);
        _selectedImageView.hidden = YES;
        [self.contentView addSubview:_selectedImageView];
    }
    return self;
}


@end
