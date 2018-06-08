//
//  TYSmartSceneTableViewCell.m
//  TuyaSmartPublic
//
//  Created by XuChengcheng on 16/7/4.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TYSmartSceneTableViewCell.h"

@interface TYSmartSceneTableViewCell()

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLable;
@property (nonatomic, strong) UILabel *subTitleLabel;

@end

@implementation TYSmartSceneTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 21, 48 * 686 / 280, 48)];
        _iconImageView.image = [UIImage imageNamed:@"ty_index_custom"];
        [self.contentView addSubview:_iconImageView];
        
        _titleLable = [TPViewUtil simpleLabel:CGRectMake(_iconImageView.right + 15, 33, APP_SCREEN_WIDTH - 78 - 10 - 80, 17) f:17 tc:HEXCOLOR(0x303030) t:@""];
        [self.contentView addSubview:_titleLable];
        
        _subTitleLabel = [TPViewUtil simpleLabel:CGRectMake(78, 49, APP_SCREEN_WIDTH - 78 - 10 - 80, 12) f:12 tc:HEXCOLOR(0x77808a) t:@""];
        _subTitleLabel.textColor = HEXCOLOR(0xFF543E);
        [self.contentView addSubview:_subTitleLabel];
        
        _bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(15, 89.5, APP_CONTENT_WIDTH - 15, 0.5)];
        _bottomLineView.backgroundColor = HEXCOLOR(0xd8d8d8);
        _bottomLineView.hidden = NO;
        [self.contentView addSubview:_bottomLineView];
        
        _topLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_CONTENT_WIDTH, 0.5)];
        _topLineView.backgroundColor = HEXCOLOR(0xd8d8d8);
        _topLineView.hidden = YES;
        [self.contentView addSubview:_topLineView];
        
        _executeButton = [[UIButton alloc] initWithFrame:CGRectMake(APP_SCREEN_WIDTH - 15 - 60, 33, 60, 24)];
        [_executeButton setTitle:NSLocalizedString(@"ty_smart_scene_start", @"") forState:UIControlStateNormal];
        _executeButton.titleLabel.adjustsFontSizeToFitWidth = YES;
        [_executeButton setTitleColor:HEXCOLOR(0x44db5e) forState:UIControlStateNormal];
        [_executeButton setTitleColor:HEXCOLORA(0x8a8e91, 0.6) forState:UIControlStateDisabled];
        _executeButton.layer.cornerRadius = 12.0;
        _executeButton.layer.borderWidth = 1.0;
        _executeButton.titleLabel.font = [UIFont boldSystemFontOfSize:12];
        _executeButton.layer.borderColor = HEXCOLOR(0x44db5e).CGColor;
        [self.contentView addSubview:_executeButton];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setModel:(TuyaSmartSceneModel *)model {
    _model = model;
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:model.background]];
    
//    self.subTitleLabel.text = @"";
    
//    if (model.offline) {
//        self.subTitleLabel.text = NSLocalizedString(@"ty_smart_scene_device_error", @"");
//    }
//
//    if (model.deviceRemoved) {
//        self.subTitleLabel.text = NSLocalizedString(@"ty_smart_scene_device_null", @"");
//    }
//
//    if ((model.offline || model.deviceRemoved) && model.sceneId.length > 0) {
//        self.titleLable.frame = CGRectMake(78, 25, APP_SCREEN_WIDTH - 78 - 10 - 80, 17);
//        self.subTitleLabel.hidden = NO;
//    } else {
//        self.titleLable.frame = CGRectMake(78, 0, APP_SCREEN_WIDTH - 78 - 10 - 80, 90);
//        self.subTitleLabel.hidden = YES;
//    }
//
    self.titleLable.text = model.name;
}



@end
