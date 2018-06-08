//
//  TYSelectConditionTableViewCell.m
//  TuyaSmartPublic
//
//  Created by XuChengcheng on 2016/12/30.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TYSelectConditionTableViewCell.h"


@implementation TYSelectConditionTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _titleLable = [TPViewUtil simpleLabel:CGRectMake(15, 0, APP_SCREEN_WIDTH - 200, 48) f:16 tc:HEXCOLOR(0x303030) t:@""];
        [self.contentView addSubview:_titleLable];
        
        _subTitleLabel = [TPViewUtil simpleLabel:CGRectMake(APP_CONTENT_WIDTH - 37 - 150, 0, 150, 48) f:14 tc:HEXCOLOR(0x9b9b9b) t:@""];
        _subTitleLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_subTitleLabel];
    }
    return self;
}

@end
