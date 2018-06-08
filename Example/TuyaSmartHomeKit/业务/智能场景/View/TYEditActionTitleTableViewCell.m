//
//  TYEditActionTitleTableViewCell.m
//  TuyaSmartPublic
//
//  Created by XuChengcheng on 2016/10/11.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TYEditActionTitleTableViewCell.h"

@implementation TYEditActionTitleTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _titleLabel = [TPViewUtil simpleLabel:CGRectMake(20, 0, APP_SCREEN_WIDTH - 100, 48) f:16 tc:HEXCOLOR(0x303030) t:@""];
        [self.contentView addSubview:_titleLabel];
        
        _addImageView = [[UIImageView alloc] initWithFrame:CGRectMake(APP_CONTENT_WIDTH - 40, 14, 20, 20)];
        _addImageView.image = [UIImage imageNamed:@"smartScene.bundle/ty_scene_plus"];
        [self.contentView addSubview:_addImageView];
        
        _addBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, APP_CONTENT_WIDTH, 48)];
        [self.contentView addSubview:_addBtn];
    }
    return self;
}

@end
