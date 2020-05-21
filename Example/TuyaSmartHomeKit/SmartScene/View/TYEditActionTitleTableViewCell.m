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
        
        _titleLabel = [TPViewUtil simpleLabel:CGRectMake(16, 0, APP_SCREEN_WIDTH - 100, 48) f:16 tc:HEXCOLOR(0x303030) t:@""];
        [self.contentView addSubview:_titleLabel];
        
        UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 47.5, APP_CONTENT_WIDTH, 0.5)];
        bottomLineView.backgroundColor = HEXCOLOR(0xd8d8d8);
        [self.contentView addSubview:bottomLineView];
    }
    return self;
}

@end
