//
//  TYPanelLogViewCell.m
//  TuyaSmartKitDemo
//
//  Created by 冯晓 on 16/8/29.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TYPanelLogViewCell.h"


@interface TYPanelLogViewCell()


@end


@implementation TYPanelLogViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = NO;
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.contentLabel];
        
    }
    return self;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [TPViewUtil simpleLabel:CGRectMake(15, 6, APP_CONTENT_WIDTH - 30, 22) bf:12 tc:HEXCOLOR(0xD0021B) t:@""];
    }
    return _titleLabel;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [TPViewUtil simpleLabel:CGRectMake(15, self.titleLabel.bottom, APP_CONTENT_WIDTH - 30, 140 - 28) f:12 tc:HEXCOLOR(0xD0021B) t:@""];
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}



@end
