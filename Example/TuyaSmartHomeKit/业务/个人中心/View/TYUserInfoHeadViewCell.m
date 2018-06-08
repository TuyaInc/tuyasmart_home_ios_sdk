//
//  TYUserInfoHeadViewCell.m
//  TuyaSmartPublic
//
//  Created by 高森 on 16/5/16.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TYUserInfoHeadViewCell.h"

@implementation TYUserInfoHeadViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.backgroundColor = LIST_BACKGROUND_COLOR;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UILabel *label = [TPViewUtil labelWithFrame:CGRectMake(15, 40, 100, 20) fontSize:15 color:LIST_MAIN_TEXT_COLOR];
    label.text = NSLocalizedString(@"head_icon", @"");
    [self.contentView addSubview:label];
    
//    UIImageView *arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell_view_arrow"]];
//    arrow.centerY = label.centerY;
//    arrow.right = APP_SCREEN_WIDTH - 20;
//    arrow.hidden = YES;
//    [self.contentView addSubview:arrow];
    
    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ty_user_icon_default"]];
    image.centerY = label.centerY;
    image.right = APP_SCREEN_WIDTH - 20;
    [self.contentView addSubview:image];
    
    return self;
}

@end
