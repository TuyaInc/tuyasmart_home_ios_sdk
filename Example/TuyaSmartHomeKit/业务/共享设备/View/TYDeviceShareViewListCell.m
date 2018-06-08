//
//  TYDeviceShareViewListCell.m
//  TuyaSmart
//
//  Created by 冯晓 on 16/1/7.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TYDeviceShareViewListCell.h"

@interface TYDeviceShareViewListCell()

@property (nonatomic,strong) UIView *memberView;
@property (nonatomic,strong) UIImageView *iconImageView;
@property (nonatomic,strong) UILabel *nickNameLabel;
@property (nonatomic,strong) UILabel *userNameLabel;

@end


@implementation TYDeviceShareViewListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.contentView.backgroundColor = MAIN_BACKGROUND_COLOR;
//    self.contentView.backgroundColor = [UIColor clearColor];
    
    [self.contentView addSubview:self.memberView];
    [self.memberView addSubview:self.iconImageView];
    [self.memberView addSubview:self.nickNameLabel];
    [self.memberView addSubview:self.userNameLabel];
    
//    [self.contentView addSubview:[TPViewUtil viewWithFrame:CGRectMake(0, 80, self.width, 10) color:MAIN_BACKGROUND_COLOR]];
    
    return self;
}

- (UIView *)memberView {
    if (!_memberView) {
        _memberView = [TPViewUtil viewWithFrame:CGRectMake(8, 0, APP_SCREEN_WIDTH - 16, 80) color:[UIColor whiteColor]];
    }
    return _memberView;
}

- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(16, 14, 52, 52)];
        _iconImageView.layer.cornerRadius = 26;
        _iconImageView.layer.masksToBounds = YES;
    }
    return _iconImageView;
}

- (UILabel *)nickNameLabel {
    if (!_nickNameLabel) {
        _nickNameLabel = [TPViewUtil labelWithFrame:CGRectMake(84, 18, 200, 20) fontSize:16 color:MAIN_FONT_COLOR];
    }
    return _nickNameLabel;
}

- (UILabel *)userNameLabel {
    if (!_userNameLabel) {
        _userNameLabel = [TPViewUtil labelWithFrame:CGRectMake(84, 44, 200, 20) fontSize:14 color:LIGHT_FONT_COLOR];
    }
    return _userNameLabel;
}

- (void)setUp:(TuyaSmartShareMemberModel *)model {
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:model.iconUrl] placeholderImage:[UIImage imageNamed:@"ty_user_icon_default"]];
    _nickNameLabel.text = model.nickName;
    _userNameLabel.text = model.userName;
}

@end
