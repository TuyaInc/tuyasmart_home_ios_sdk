//
//  TYSelectCityViewCell.m
//  TuyaSmartPublic
//
//  Created by 冯晓 on 2016/10/26.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TYSelectCityViewCell.h"

@interface TYSelectCityViewCell()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *selectImageView;

@end

@implementation TYSelectCityViewCell


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = NO;
        self.backgroundColor = LIST_BACKGROUND_COLOR;
        
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.selectImageView];
        
    }
    return self;
}


- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [TPViewUtil simpleLabel:CGRectMake(15, 0, APP_CONTENT_WIDTH - 46, 48) f:16 tc:LIST_MAIN_TEXT_COLOR t:@""];
    }
    return _titleLabel;
}

- (UIImageView *)selectImageView {
    if (!_selectImageView) {
        _selectImageView = [[UIImageView alloc] initWithFrame:CGRectMake(APP_CONTENT_WIDTH - 16 - 20, (48 - 10)/2, 16, 10)];
        _selectImageView.image = [UIImage imageNamed:@"smartScene.bundle/ty_device_chose"];
    }
    return _selectImageView;
}


- (void)setItem:(NSString *)name isSelect:(BOOL)isSelect {
    _titleLabel.text = name;
    
    _selectImageView.hidden = !isSelect;
    
    
}
@end
