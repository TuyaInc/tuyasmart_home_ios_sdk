//
//  TYUserInfoNickViewCell.m
//  TuyaSmartPublic
//
//  Created by 高森 on 16/5/16.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TYUserInfoNickViewCell.h"

@interface TYUserInfoNickViewCell()

@property (nonatomic, strong) UILabel *nickNameLabel;

@end

@implementation TYUserInfoNickViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.backgroundColor = LIST_BACKGROUND_COLOR;
    
    UILabel *label = [TPViewUtil labelWithFrame:CGRectMake(15, 15, 100, 20) fontSize:15 color:LIST_MAIN_TEXT_COLOR];
    label.text = NSLocalizedString(@"ty_add_share_nickname", @"");
    [self.contentView addSubview:label];
    
    UIImageView *arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell_view_arrow"]];
    arrow.centerY = label.centerY;
    arrow.right = APP_SCREEN_WIDTH - 20;
    [self.contentView addSubview:arrow];
    
    _nickNameLabel = [TPViewUtil labelWithFrame:CGRectMake(15, 15, 200, 20) fontSize:15 color:LIST_LIGHT_TEXT_COLOR];
    _nickNameLabel.right = arrow.left - 15;
    _nickNameLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_nickNameLabel];
    
    return self;
}

- (void)setNickName:(NSString *)nickname {
    _nickNameLabel.text = nickname;
}

@end
