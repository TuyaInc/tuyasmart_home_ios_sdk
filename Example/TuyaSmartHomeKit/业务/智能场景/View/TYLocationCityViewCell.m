//
//  TYLocationCityViewCell.m
//  TuyaSmartPublic
//
//  Created by 冯晓 on 2016/11/1.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TYLocationCityViewCell.h"

@interface TYLocationCityViewCell()


@property (nonatomic, strong) UIImageView *locationIcon;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation TYLocationCityViewCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = NO;
        self.backgroundColor = LIST_BACKGROUND_COLOR;
        
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.locationIcon];
        
    }
    return self;
}


- (UIImageView *)locationIcon {
    if (!_locationIcon) {
        _locationIcon = [[UIImageView alloc] initWithFrame:CGRectMake(15, (48 - 20)/2, 14, 20)];
        _locationIcon.image = [UIImage imageNamed:@"smartScene.bundle/ty_device_location"];
        _locationIcon.userInteractionEnabled = YES;
    }
    return _locationIcon;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [TPViewUtil simpleLabel:CGRectMake(self.locationIcon.right + 10, 0, APP_CONTENT_WIDTH - self.locationIcon.right - 10, 48) f:16 tc:LIST_MAIN_TEXT_COLOR t:NSLocalizedString(@"ty_smart_positioning", nil)];
    }
    return _titleLabel;
}

- (void)setItem:(NSString *)item {
    _titleLabel.text = item;
}

@end
