//
//  TYActivatorTableViewCell.m
//  TuyaSmartPublic
//
//  Created by XuChengcheng on 16/9/21.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TYActivatorTableViewCell.h"

@interface TYActivatorTableViewCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UIImageView *warningView;

@end

@implementation TYActivatorTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = HEXCOLOR(0xF9F9F9);
        
        _titleLabel = [TPViewUtil simpleLabel:CGRectMake(26, 260, APP_SCREEN_WIDTH - 30 - 26 - 70, 22) f:16 tc:HEXCOLOR(0x4A4A4A) t:@""];
        [self.contentView addSubview:_titleLabel];
        
        _detailLabel = [TPViewUtil simpleLabel:CGRectMake(23, 40, APP_SCREEN_WIDTH - 30 - 23 - 70, 17) f:12 tc:HEXCOLOR(0x999999) t:@""];
        [self.contentView addSubview:_detailLabel];
        
        _renameButton = [[UIButton alloc] initWithFrame:CGRectMake(APP_SCREEN_WIDTH - 30 - 70, 0, 70, 75)];
        [_renameButton setImage:[UIImage imageNamed:@"Activator.bundle/ty_adddevice_rename"] forState:UIControlStateNormal];
        [self.contentView addSubview:_renameButton];
        
        _warningView = [[UIImageView alloc] initWithFrame:CGRectMake(APP_SCREEN_WIDTH - 30 - 24 - 18, 27, 18, 18)];
        _warningView.image = [UIImage imageNamed:@"Activator.bundle/ty_adddevice_failure"];
        _warningView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_warningView];
    }
    return self;
}

- (void)setDeviceModel:(TuyaSmartDeviceModel *)deviceModel error:(NSError *)error {
    self.titleLabel.text = deviceModel.name;
    self.detailLabel.text = error.localizedDescription;
    
    if (error) {
        self.titleLabel.top = 17.0;
        self.detailLabel.hidden = NO;
        self.warningView.hidden = NO;
        self.renameButton.hidden = YES;
    } else {
        self.titleLabel.top = 26.0;
        self.detailLabel.hidden = YES;
        self.warningView.hidden = YES;
        self.renameButton.hidden = NO;
    }
}

@end
