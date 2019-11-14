//
//  UILabel+TYFactory.m
//  TYUIKit
//
//  Created by TuyaInc on 2019/5/14.
//

#import "UILabel+TYFactory.h"

@implementation UILabel (TYFactory)

+ (instancetype)ty_labelWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)color {
    return [self ty_labelWithText:text font:font textColor:color frame:CGRectZero];
}

+ (instancetype)ty_labelWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)color frame:(CGRect)frame {
    UILabel *label = [UILabel new];
    label.text = text;
    label.textColor = color;
    label.font = font;
    if (CGRectEqualToRect(frame, CGRectZero)) {
        [label sizeToFit];
    } else {
        label.frame = frame;
    }
    return label;
}

+ (instancetype)ty_labelWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)color widthMax:(CGFloat)width {
    UILabel *label = [UILabel new];
    label.text = text;
    label.textColor = color;
    label.font = font;
    label.numberOfLines = 0;
    CGSize size = [label sizeThatFits:CGSizeMake(width, MAXFLOAT)];
    label.frame = CGRectMake(0, 0, size.width, size.height);
    
    return label;
}

@end
