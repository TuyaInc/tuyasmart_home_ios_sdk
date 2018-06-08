//
//  TYMemberListCell.m
//  TuyaSmart
//
//  Created by 冯晓 on 16/1/7.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TYMemberListCell.h"

@interface TYMemberListCell()

@property (nonatomic, strong) UILabel              *nickNameLabel;
@property (nonatomic, strong) UILabel              *userNameLabel;
@property (nonatomic, strong) UIImageView          *arrowImageView;

@end

@implementation TYMemberListCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.contentView.backgroundColor = LIST_BACKGROUND_COLOR;
    
    [self.contentView addSubview:self.nickNameLabel];
    [self.contentView addSubview:self.userNameLabel];
    [self.contentView addSubview:self.arrowImageView];
    
    return self;
}

- (UIImageView *)arrowImageView {
    if (!_arrowImageView) {
        _arrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ty_member_arrow"]];
        _arrowImageView.frame = CGRectMake(APP_CONTENT_WIDTH - 6 - 15, (60 - 12)/2, 6, 11);
    }
    return _arrowImageView;
}


- (UILabel *)nickNameLabel {
    if (!_nickNameLabel) {
        _nickNameLabel = [TPViewUtil labelWithFrame:CGRectMake(15, 0, 135, 60) fontSize:16 color:LIST_MAIN_TEXT_COLOR];
        _nickNameLabel.width = APP_CONTENT_WIDTH - 15 - 36 - 150;
    }
    return _nickNameLabel;
}

- (UILabel *)userNameLabel {
    if (!_userNameLabel) {
        _userNameLabel = [TPViewUtil labelWithFrame:CGRectMake(0, 0, 150, 60) fontSize:14 color:LIST_SUB_TEXT_COLOR];
        _userNameLabel.right = APP_CONTENT_WIDTH - 36;
        _userNameLabel.textAlignment = NSTextAlignmentRight;
    }
    return _userNameLabel;
}

- (void)setMember:(TuyaSmartShareMemberModel *)member {
    _member = member;
    _nickNameLabel.text = member.nickName;
    _userNameLabel.text = member.userName;
}



@end
