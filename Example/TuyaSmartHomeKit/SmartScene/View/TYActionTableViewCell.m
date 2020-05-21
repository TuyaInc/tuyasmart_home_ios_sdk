//
//  TYActionTableViewCell.m
//  TuyaSmartPublic
//
//  Created by XuChengcheng on 16/7/25.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TYActionTableViewCell.h"

@interface TYActionTableViewCell()

@property (nonatomic, strong) UILabel *subTitleLabel;
@property (nonatomic, strong) UILabel *titleLable;
@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;
@property (nonatomic, strong) UILabel *errorLabel;
@property (nonatomic, strong) UIImageView *infoImageView;

@end

@implementation TYActionTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 56, 56)];
        [self.contentView addSubview:_iconImageView];
        
        _titleLable = [TPViewUtil simpleLabel:CGRectMake(56, 10, 120, 22) f:12 tc:HEXCOLOR(0x303030) t:@""];
        [self.contentView addSubview:_titleLable];
        
        _errorLabel = [TPViewUtil simpleLabel:CGRectMake(270 - 40 - 60, 0, 60, 56) f:11 tc:HEXCOLOR(0xff3b30) t:@""];
        _errorLabel.text = NSLocalizedString(@"ty_smart_scene_device_offline", @"");
        _errorLabel.textAlignment = NSTextAlignmentRight;
        _errorLabel.hidden = YES;
        [self.contentView addSubview:_errorLabel];
        
        _subTitleLabel = [TPViewUtil simpleLabel:CGRectMake(56, 28, 100, 18) f:11 tc:HEXCOLOR(0x9b9b9b) t:@""];
        [self.contentView addSubview:_subTitleLabel];

        _infoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(238, 19, 18, 18)];
        _infoImageView.hidden = YES;
        _infoImageView.image = [UIImage imageNamed:@"ty_scene_error"];
        [self.contentView addSubview:_infoImageView];
        
        _indicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(238, 19, 18, 18)];
        _indicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        [self.contentView addSubview:_indicatorView];
    }
    return self;
}

- (void)setModel:(TuyaSmartSceneActionModel *)model {
    _errorLabel.hidden = YES;
    _titleLable.text = model.entityName;
    _subTitleLabel.text = model.actionDisplay;
    if (model.status == TYSceneActionStatusLoading) {
        [_indicatorView startAnimating];
    } else if (model.status == TYSceneActionStatusSuccess) {
        [_indicatorView stopAnimating];
        _infoImageView.hidden = NO;
        _infoImageView.image = [UIImage imageNamed:@"ty_scene_switch"];
    } else if (model.status == TYSceneActionStatusOffline) {
        [_indicatorView stopAnimating];
        _infoImageView.hidden = NO;
        _errorLabel.hidden = NO;
        _errorLabel.text = NSLocalizedString(@"ty_smart_scene_device_offline", @"");
        _infoImageView.image = [UIImage imageNamed:@"ty_scene_error"];
    } else if (model.status == TYSceneActionStatusTimeout) {
        [_indicatorView stopAnimating];
        _infoImageView.hidden = NO;
        _errorLabel.hidden = NO;
        _errorLabel.text = NSLocalizedString(@"ty_smart_scene_feedback_no_respond", @"");
        _infoImageView.image = [UIImage imageNamed:@"ty_scene_error"];
    }
}

@end
