//
//  TYEditActionTableViewCell.m
//  TuyaSmartPublic
//
//  Created by XuChengcheng on 16/7/12.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TYEditActionTableViewCell.h"

@interface TYEditActionTableViewCell()

@property (nonatomic, strong) UIImageView *rightArrowImageView;

@end

@implementation TYEditActionTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 12, 40, 40)];
        [self.contentView addSubview:_iconImageView];
        
        _titleLable = [TPViewUtil simpleLabel:CGRectMake(62, 14, APP_SCREEN_WIDTH - 62 - 80 - 37, 22) f:16 tc:HEXCOLOR(0x303030) t:@""];
        [self.contentView addSubview:_titleLable];
        
        _subTitleLabel = [TPViewUtil simpleLabel:CGRectMake(62, 36, APP_SCREEN_WIDTH - 62 - 80 - 37, 18) f:12 tc:HEXCOLOR(0x626262) t:@""];
        [self.contentView addSubview:_subTitleLabel];
        
        _offlineLabel = [TPViewUtil simpleLabel:CGRectMake(APP_CONTENT_WIDTH - 37 - 80, 0, 80, 64) f:14 tc:HEXCOLOR(0x626262) t:@""];
        _offlineLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_offlineLabel];
        
        self.rightArrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"smartScene.bundle/cell_view_arrow"]];
        self.rightArrowImageView.frame = CGRectMake(APP_SCREEN_WIDTH - 22, (64 - self.rightArrowImageView.height) / 2.f, self.rightArrowImageView.width, self.rightArrowImageView.height);
        [self.contentView addSubview:self.rightArrowImageView];
        
        UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 63.5, APP_CONTENT_WIDTH, 0.5)];
        bottomLineView.backgroundColor = HEXCOLOR(0xd8d8d8);
        [self.contentView addSubview:bottomLineView];
        
        NSMutableArray *rightUtilityButtons = [NSMutableArray array];
        [rightUtilityButtons sw_addUtilityButtonWithColor:[UIColor redColor]
                                                    title:NSLocalizedString(@"operation_delete", @"")];
        self.rightUtilityButtons = rightUtilityButtons;
    }
    return self;
}
@end
