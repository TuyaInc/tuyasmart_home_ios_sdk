//
//  TYEditActionNoDataTableViewCell.m
//  TuyaSmartPublic
//
//  Created by XuChengcheng on 2016/10/11.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TYEditActionNoDataTableViewCell.h"

@implementation TYEditActionNoDataTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = MAIN_BACKGROUND_COLOR;
        
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.bounds = CGRectMake(0, 0, APP_CONTENT_WIDTH - 18 * 2, 60);
        shapeLayer.position = CGPointMake(APP_SCREEN_WIDTH / 2.0, 38);
        shapeLayer.path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, APP_CONTENT_WIDTH - 18 * 2, 60)].CGPath;
        shapeLayer.lineWidth = 0.5;
        shapeLayer.strokeColor = HEXCOLOR(0x9b9b9b).CGColor;
        shapeLayer.lineDashPattern = @[@(2), @(2)];
        shapeLayer.fillColor = HEXCOLOR(0xfafafa).CGColor;
        shapeLayer.opacity = 0.6;
        shapeLayer.masksToBounds = YES;
        [self.contentView.layer addSublayer:shapeLayer];
        
        _titleLabel = [TPViewUtil simpleLabel:CGRectMake(0, 0, APP_SCREEN_WIDTH, 76) f:13 tc:HEXCOLOR(0x9b9b9b) t:@""];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_titleLabel];
    }
    return self;
}

@end
