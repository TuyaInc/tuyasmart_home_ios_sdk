//
//  UserInfoTableViewCell.m
//  TuyaSmart
//
//  Created by fengyu on 15/2/28.
//  Copyright (c) 2015年 Tuya. All rights reserved.
//

#import "UserInfoTableViewCell.h"

@interface UserInfoTableViewCell()

@property(nonatomic,strong) UIView      *userInfoView;
@property(nonatomic,strong) UIImageView *headPicImageView;
@property(nonatomic,strong) UILabel     *nickNameLabel;
@property(nonatomic,strong) UILabel     *userNameLabel;
@property(nonatomic,strong) UIImageView *rightArrowImageView;

@end

@implementation UserInfoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.backgroundColor = MAIN_BACKGROUND_COLOR;
    
    [self addUserInfoView];
    
    return self;
}

- (void)addUserInfoView {
    _userInfoView = [TPViewUtil viewWithFrame:CGRectMake(0, 20, APP_SCREEN_WIDTH, 96) color:[UIColor whiteColor]];
    [_userInfoView addSubview:self.headPicImageView];
    [_userInfoView addSubview:self.nickNameLabel];
    [_userInfoView addSubview:self.userNameLabel];
    [_userInfoView addSubview:self.rightArrowImageView];

    [self.contentView addSubview:[TPViewUtil viewWithFrame:CGRectMake(0, 19.5, APP_SCREEN_WIDTH, 0.5) color:SEPARATOR_LINE_COLOR]];
    [self.contentView addSubview:_userInfoView];
    [self.contentView addSubview:[TPViewUtil viewWithFrame:CGRectMake(0, 115.5, APP_SCREEN_WIDTH, 0.5) color:SEPARATOR_LINE_COLOR]];
    
    if ([TuyaSmartUser sharedInstance].nickname.length > 0) {
        _nickNameLabel.text = [TuyaSmartUser sharedInstance].nickname;
    } else {
        _nickNameLabel.text = NSLocalizedString(@"click_set_neekname", nil);
    }

    if ([TuyaSmartUser sharedInstance].phoneNumber.length > 0) {
        _userNameLabel.text = [TuyaSmartUser sharedInstance].phoneNumber;
    } else if ([TuyaSmartUser sharedInstance].email.length > 0) {
        _userNameLabel.text = [TuyaSmartUser sharedInstance].email;
    } else {
        _userNameLabel.text = NSLocalizedString(@"click_bind_phone", nil);
    }

}

- (UIImageView *)headPicImageView {
    if (!_headPicImageView) {
        _headPicImageView = [TPViewUtil imageViewWithFrame:CGRectMake(15, 12, 72, 72) image:[UIImage imageNamed:@"ty_user_icon_default"]];
    }
    return _headPicImageView;
}

- (UILabel *)nickNameLabel {
    if (!_nickNameLabel) {
        _nickNameLabel = [TPViewUtil labelWithFrame:CGRectMake(96, 30, 200, 20) fontSize:15 color:LIST_MAIN_TEXT_COLOR];
    }
    return _nickNameLabel;
}

- (UILabel *)userNameLabel {
    if (!_userNameLabel) {
        _userNameLabel = [TPViewUtil labelWithFrame:CGRectMake(96, self.nickNameLabel.bottom + 4, 200, 20) fontSize:15 color:LIST_LIGHT_TEXT_COLOR];
    }
    return _userNameLabel;
}

- (UIImageView *)rightArrowImageView {
    if (!_rightArrowImageView) {
        _rightArrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell_view_arrow"]];
        _rightArrowImageView.frame = CGRectMake(APP_SCREEN_WIDTH-_rightArrowImageView.width-20, (96 - _rightArrowImageView.height)/2.f, _rightArrowImageView.width, _rightArrowImageView.height);
    }
    return _rightArrowImageView;
}


@end
