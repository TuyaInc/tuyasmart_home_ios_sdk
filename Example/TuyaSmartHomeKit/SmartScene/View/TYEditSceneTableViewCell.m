//
//  TYEditSceneTableViewCell.m
//  TuyaSmartPublic
//
//  Created by XuChengcheng on 16/7/6.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TYEditSceneTableViewCell.h"

@interface TYEditSceneTableViewCell()

@property (nonatomic, strong) UIImageView *arrowImageView;
@end

@implementation TYEditSceneTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _titleLable = [TPViewUtil simpleLabel:CGRectMake(15, 0, APP_SCREEN_WIDTH - 200, 48) f:16 tc:HEXCOLOR(0x303030) t:@""];
        [self.contentView addSubview:_titleLable];
        
        _subTitleLabel = [TPViewUtil simpleLabel:CGRectMake(APP_CONTENT_WIDTH - 37 - 150, 0, 150, 48) f:14 tc:HEXCOLOR(0x9b9b9b) t:@""];
        CGFloat width =  [_subTitleLabel.text sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]}].width;
        _subTitleLabel.frame = CGRectMake(APP_CONTENT_WIDTH - 37 - width - 34, 0, width, 48);
        [self.contentView addSubview:_subTitleLabel];

        _arrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell_view_arrow"]];
        _arrowImageView.right = APP_CONTENT_WIDTH - 15;
        _arrowImageView.top = (48 - _arrowImageView.height) / 2.f;
        [self.contentView addSubview:_arrowImageView];
    }
    return self;
}


@end
