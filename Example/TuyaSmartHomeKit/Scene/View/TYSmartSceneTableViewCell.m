//
//  TYSmartSceneTableViewCell.m
//  TuyaSmartPublic
//
//  Created by XuChengcheng on 16/7/4.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TYSmartSceneTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface TYSmartSceneTableViewCell()

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLable;
@property (nonatomic, strong) UILabel *subTitleLabel;

@end

@implementation TYSmartSceneTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, APP_SCREEN_WIDTH - 30, (APP_SCREEN_WIDTH - 30) * 140 / 343)];
        _iconImageView.layer.cornerRadius = 8;
        _iconImageView.layer.masksToBounds = YES;
        [self.contentView addSubview:_iconImageView];
        
        _titleLable = [TPViewUtil simpleLabel:CGRectMake(20 + 15, ((APP_SCREEN_WIDTH - 30) * 140 / 343 - 24) / 2.0, APP_SCREEN_WIDTH - 78 - 10 - 80, 24) bf:20 tc:[UIColor whiteColor] t:@""];
        [self.contentView addSubview:_titleLable];
        
        _executeButton = [[UIButton alloc] initWithFrame:CGRectMake(APP_SCREEN_WIDTH - 15 - 60 - 15, ((APP_SCREEN_WIDTH - 30) * 140 / 343 - 30) / 2.0, 60, 30)];
        [_executeButton setBackgroundColor:HEXCOLOR(0x44db5e)];
        [_executeButton setTitle:NSLocalizedString(@"ty_smart_scene_start", @"") forState:UIControlStateNormal];
        [_executeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _executeButton.layer.cornerRadius = 8.0;
        _executeButton.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        [self.contentView addSubview:_executeButton];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setModel:(TuyaSmartSceneModel *)model {
    _model = model;
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:model.background]];
    self.titleLable.text = model.name;
}



@end
