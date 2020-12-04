//
//  TYSlider.m
//  TuyaSmartPublic
//
//  Created by 冯晓 on 2018/2/3.
//  Copyright © 2018年 Tuya. All rights reserved.
//

#import "TYSlider.h"

@implementation TYSlider

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (CGRect)trackRectForBounds:(CGRect)bounds {
    bounds = [super trackRectForBounds:bounds];
    bounds.size.height = 4;
    return bounds;
}

- (CGRect)thumbRectForBounds:(CGRect)bounds trackRect:(CGRect)rect value:(float)value {
    rect.origin.x = rect.origin.x - 10 ;
    rect.size.width = rect.size.width + 20;
    return CGRectInset([super thumbRectForBounds:bounds trackRect:rect value:value], 10, 10);
}

@end
