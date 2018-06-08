//
//  TYUserInfoPassCell.m
//  TuyaSmartPublic
//
//  Created by 冯晓 on 16/6/3.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TYUserInfoPassCell.h"

@interface TYUserInfoPassCell()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation TYUserInfoPassCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.backgroundColor = LIST_BACKGROUND_COLOR;
    
    _titleLabel = [TPViewUtil labelWithFrame:CGRectMake(15, 15, 200, 20) fontSize:15 color:LIST_MAIN_TEXT_COLOR];
    [self.contentView addSubview:_titleLabel];
    
    
    UIImageView *arrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell_view_arrow"]];
    arrowImageView.centerY = _titleLabel.centerY;
    arrowImageView.right = APP_SCREEN_WIDTH - 20;
    [self.contentView addSubview:arrowImageView];
    
    _contentLabel = [TPViewUtil labelWithFrame:CGRectMake(15, 15, 200, 20) fontSize:15 color:LIST_LIGHT_TEXT_COLOR];
    _contentLabel.right = arrowImageView.left - 15;
    _contentLabel.textAlignment = NSTextAlignmentRight;
    _contentLabel.textColor = HEXCOLOR(0xff4800);
    [self.contentView addSubview:_contentLabel];
    
    return self;
}


- (void)setTitle:(NSString *)title content:(NSString *)content {
    _titleLabel.text = title;
    _contentLabel.text = content;
    
}





@end
