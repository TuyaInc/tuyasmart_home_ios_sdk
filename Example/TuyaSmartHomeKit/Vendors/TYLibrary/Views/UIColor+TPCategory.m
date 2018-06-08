//
//  UIColor+TPCategory.m
//  TYLibraryExample
//
//  Created by 高森 on 16/2/22.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "UIColor+TPCategory.h"
#import "TPViewUtil.h"

@implementation UIColor (TPCategory)

- (UIImage *)tp_toImage {
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, self.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
