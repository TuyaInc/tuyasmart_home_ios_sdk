//
//  UserItemTableViewCell.m
//  TuyaSmart
//
//  Created by fengyu on 15/2/28.
//  Copyright (c) 2015年 Tuya. All rights reserved.
//

#import "UserItemTableViewCell.h"
#import "TPItemView.h"

@implementation UserItemTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.backgroundColor = MAIN_BACKGROUND_COLOR;

    _itemView = [TPItemView itemViewWithFrame:CGRectMake(0, 0, APP_SCREEN_WIDTH, 44)];
    _itemView.leftLabel.frame = CGRectMake(60, 6, 200, 32);
    _itemView.leftLabel.textColor = LIST_MAIN_TEXT_COLOR;
    _itemView.leftLabel.font = [UIFont systemFontOfSize:15];
    [_itemView showRightArrow];
    [self addSubview:_itemView];
    
    return self;
}

-(void)setUp:(MenuItem *)item {
    _itemView.leftImage = item.icon;
    _itemView.leftLabel.text = item.title;

    switch (item.type) {
        case MenuItemTypeFirst:{
            _itemView.topLine.hidden    = NO;
            _itemView.middleLine.hidden = NO;
            _itemView.bottomLine.hidden = YES;
            break;
        }
        case MenuItemTypeLast: {
            _itemView.topLine.hidden    = YES;
            _itemView.middleLine.hidden = YES;
            _itemView.bottomLine.hidden = NO;
            break;
        }
        default: {
            _itemView.topLine.hidden    = YES;
            _itemView.middleLine.hidden = NO;
            _itemView.bottomLine.hidden = YES;
            break;
        }
    }
}

@end
