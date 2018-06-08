//
//  TYReceiveMemberDeviceListCell.m
//  TuyaSmart
//
//  Created by 冯晓 on 16/1/6.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TYReceiveMemberDeviceListCell.h"

@interface TYReceiveMemberDeviceListCell()

@property (nonatomic,strong) UIImageView *iconImageView;
@property (nonatomic,strong) UILabel     *titleLabel;
@property (nonatomic,strong) UIView      *line;
@property (nonatomic,strong) TuyaSmartShareDeviceModel *model;

@end

@implementation TYReceiveMemberDeviceListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = NO;
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:self.iconImageView];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.switchView];
        [self.contentView addSubview:self.line];
        
    }
    return self;
}

- (UIView *)line {
    if (!_line) {
        _line = [[UIView alloc] initWithFrame:CGRectMake(15, 59.5, APP_CONTENT_WIDTH, 0.5)];
        _line.backgroundColor = SEPARATOR_LINE_COLOR;
    }
    return _line;
}

- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 40, 40)];
    }
    return _iconImageView;
}


- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [TPViewUtil simpleLabel:CGRectMake(self.iconImageView.right + 10, 8, APP_CONTENT_WIDTH - _iconImageView.right - 10, 44) f:14 tc:LIST_MAIN_TEXT_COLOR t:@""];
    }
    return _titleLabel;
}

- (UISwitch *)switchView {
    if (!_switchView) {
        _switchView = [[UISwitch alloc] initWithFrame:CGRectMake(APP_SCREEN_WIDTH - 66, 14.5, 51, 31)];
        _switchView.hidden = YES;
        [_switchView addTarget:self action:@selector(shareDevice:) forControlEvents:UIControlEventValueChanged];
    }
    return _switchView;
}

- (void)shareDevice:(UISwitch *)shareSwitch {
    [self.delegate didSettingDeviceSwitch:shareSwitch isOn:shareSwitch.isOn model:_model];
}

- (void)setModel:(TuyaSmartShareDeviceModel *)model type:(NSInteger)type {
    _model = model;
    self.titleLabel.text = model.name;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.iconUrl] placeholderImage:nil];
    self.switchView.hidden = type != 0;
    self.switchView.on = model.share;
}

@end
