//
//  TYDeviceListViewCell.m
//  TuyaSmart
//
//  Created by 冯晓 on 16/1/4.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TYDemoDeviceListViewCell.h"
#import "UIImageView+WebCache.h"
#import "TPDemoViewUtil.h"
#import <TuyaSmartDeviceKit/TuyaSmartDeviceKit.h>

@interface TYDemoDeviceListViewCell()


@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UIImageView *statusImageView;
@property (nonatomic, strong) UILabel     *nameLabel;
@property (nonatomic, strong) UIImageView *rightArrowImageView;
@property (nonatomic, strong) UILabel     *groupTipLabel;


@end

@implementation TYDemoDeviceListViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.statusImageView];
        [self.contentView addSubview:self.iconImageView];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.rightArrowImageView];
        [self.contentView addSubview:self.groupTipLabel];
    }
    return self;
}

- (UILabel *)groupTipLabel {
    if (!_groupTipLabel) {
        _groupTipLabel = [TPDemoViewUtil labelWithFrame:CGRectMake(APP_CONTENT_WIDTH - 37 - 80, 0, 80, 80) fontSize:15 color:SUB_FONT_COLOR];
        _groupTipLabel.text = NSLocalizedString(@"group_item_flag", nil);
        _groupTipLabel.textAlignment = NSTextAlignmentRight;
    }
    return _groupTipLabel;
}

- (UIImageView *)statusImageView {
    if (!_statusImageView) {
        _statusImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 32, 12, 8)];
        _statusImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _statusImageView;
}

- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(40, 20, 40, 40)];
    }
    return _iconImageView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [TPDemoViewUtil labelWithFrame:CGRectMake(100, 30, APP_CONTENT_WIDTH - 100 - 22 - 10 - 50, 20) fontSize:15 color:MAIN_FONT_COLOR];
    }
    return _nameLabel;
}

- (UIImageView *)rightArrowImageView {
    if (!_rightArrowImageView) {
        _rightArrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell_view_arrow"]];
        _rightArrowImageView.frame = CGRectMake(APP_SCREEN_WIDTH-22, (80 - _rightArrowImageView.height)/2.f, _rightArrowImageView.width, _rightArrowImageView.height);
    }
    return _rightArrowImageView;
}

- (void)setItem:(id)item {
    _nameLabel.text = [item name];
  
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[item iconUrl]] placeholderImage:nil];
    
    if ([item isKindOfClass:[TuyaSmartDeviceModel class]]) {
        if ([item isOnline]) {
            if ([item isShare]) {
                _statusImageView.image = [UIImage imageNamed:@"ty_devicelist_share_green.png"];
            } else {
                _statusImageView.image = [UIImage imageNamed:@"ty_devicelist_dot_green.png"];
            }
        } else {
            if ([item isShare]) {
                _statusImageView.image = [UIImage imageNamed:@"ty_devicelist_share_gray.png"];
            } else {
                _statusImageView.image = [UIImage imageNamed:@"ty_devicelist_dot_gray.png"];
            }
        }
    } else {
        _statusImageView.image = [UIImage imageNamed:@"ty_devicelist_dot_green.png"];
    }
    
    _groupTipLabel.hidden = ![item isKindOfClass:[TuyaSmartGroupModel class]];

    if (_groupTipLabel.hidden) {
        //不是群组
        _nameLabel.width = APP_CONTENT_WIDTH - 100 - 22 - 10;

    } else {
        //群组
        _nameLabel.width = APP_CONTENT_WIDTH - 100 - 22 - 10 - 50;
    }
    
//    _nameLabel.backgroundColor = HEXCOLOR(0xff5500);
    
}

@end
