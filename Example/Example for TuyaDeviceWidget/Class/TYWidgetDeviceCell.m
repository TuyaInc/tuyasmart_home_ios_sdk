//
//  TYWidgetDeviceCell.m
//  TuyaWidget
//
//  Created by lan on 2018/9/11.
//  Copyright © 2018年 Tuya. All rights reserved.
//

#import "TYWidgetDeviceCell.h"
#import "UIImageView+WebCache.h"

@interface TYWidgetDeviceCell()
@property (nonatomic, strong) UIView *offMask;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@end

@implementation TYWidgetDeviceCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initView];
    }
    return self;
}

- (void)initView {
    [self.iconImageView addSubview:self.offMask];
    [self.contentView addSubview:self.iconImageView];
    [self.contentView addSubview:self.nameLabel];
}

- (void)setModel:(TYWidgetDeviceModel *)model {
    _model = model;
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.deviceIcon]];
    self.iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.nameLabel.text = model.deviceName;
    
    [self setOn:self.model.dpValue];
}

- (void)setOn:(BOOL)on {
    if (on) {
        self.offMask.hidden = YES;
    } else {
        self.offMask.hidden = NO;
    }
}

- (void)switchStatus {
    [self.model switchStatus];
}

#pragma mark - getters

- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, 60, 60)];
        _iconImageView.centerX = self.width / 2.f;
        _iconImageView.tintColor = [UIColor redColor];
        _iconImageView.layer.cornerRadius = 15.f;
        _iconImageView.clipsToBounds = YES;
        _iconImageView.backgroundColor = [UIColor whiteColor];
    }
    return _iconImageView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(6, self.iconImageView.bottom + 5, self.width - 12, 20)];
        _nameLabel.font = [UIFont systemFontOfSize:12];
        if (IOS10) {
            _nameLabel.textColor = HEXCOLOR(0x030303);
        } else {
            _nameLabel.textColor = HEXCOLORA(0xFFFFFF, 0.5);
        }
        _nameLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _nameLabel;
}

- (UIView *)offMask {
    if (!_offMask) {
        _offMask = [[UIView alloc] initWithFrame:self.iconImageView.bounds];
        _offMask.backgroundColor = HEXCOLORA(0x000000, 0.4);
        _offMask.hidden = YES;
    }
    return _offMask;
}

@end
