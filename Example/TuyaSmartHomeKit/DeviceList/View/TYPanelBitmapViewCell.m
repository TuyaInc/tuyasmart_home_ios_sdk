//
//  TYPanelBitmapViewCell.m
//  TuyaSmartKitDemo
//
//  Created by 冯晓 on 16/8/30.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TYPanelBitmapViewCell.h"

@interface TYPanelBitmapViewCell()

@property (nonatomic, strong) UIView *borderView;

@end

@implementation TYPanelBitmapViewCell
@synthesize textLabel = _textLabel;


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    

        [self.bgView addSubview:self.borderView];
        [self.borderView addSubview:self.textLabel];
        
    }
    return self;
}

- (UIView *)borderView {
    if (!_borderView) {
        
        _borderView = [[UIView alloc] initWithFrame:CGRectMake(0, (self.bgView.height - 34)/2, 150, 34)];
        _borderView.right = APP_CONTENT_WIDTH - 15;
        _borderView.backgroundColor = HEXCOLOR(0xF8F8F8);
        _borderView.layer.borderWidth = 1.f;
        _borderView.layer.borderColor = HEXCOLOR(0xDDDDDD).CGColor;
    }
    return _borderView;

}

- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [TPViewUtil simpleLabel:CGRectMake(4, 0, self.borderView.width - 8, self.borderView.height) f:14 tc:HEXCOLORA(0x303030, 0.5) t:@""];
    }
    return _textLabel;
}

@end
