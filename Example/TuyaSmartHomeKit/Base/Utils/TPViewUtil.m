//
//  TPViewUtil.m
//  TYLibraryExample
//
//  Created by 冯晓 on 16/2/16.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TPViewUtil.h"


@implementation TPViewUtil


+ (UILabel *)simpleLabel:(CGRect)frame f:(int)size tc:(UIColor *)color t:(NSString *)text {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:size];
    if (color != nil) {
        label.textColor = color;
    }
    label.text = text;
    
    return label;
}

+ (UILabel *)simpleLabel:(CGRect)frame bf:(int)size tc:(UIColor *)color t:(NSString *)text {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:size];
    if (color != nil) {
        label.textColor = color;
    }
    label.text = text;
    
    return label;
}

+ (UILabel *)simpleLabel:(CGRect)frame font:(UIFont *)font tc:(UIColor *)color t:(NSString *)text
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.font = font;
    if (color != nil) {
        label.textColor = color;
    }
    label.text = text;
    
    return label;
}

+ (UIView *)viewWithFrame:(CGRect)frame color:(UIColor *)color {
    UIView *view = [[UIView alloc] initWithFrame:frame];
    if (color != nil) {
        view.backgroundColor = color;
    }
    return view;
}

+ (UIImageView *)imageViewWithFrame:(CGRect)frame image:(UIImage *)image {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.image = image;
    return imageView;
}

+ (UIImageView *)imageViewWithFrame:(CGRect)frame imageName:(NSString *)imageName {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.image = [UIImage imageNamed:imageName];
    return imageView;
}

+ (UIImageView *)rightArrowImageView:(CGRect)frame {
    UIImageView *rightArrowImageView = [[UIImageView alloc] initWithFrame:frame];
    rightArrowImageView.image = [UIImage imageNamed:@"tp_list_arrow_goto.png"];
    return rightArrowImageView;
}

+ (UILabel *)labelWithFrame:(CGRect)frame fontSize:(int)fontSize color:(UIColor *)color {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.font = [UIFont systemFontOfSize:fontSize];
    label.textColor = color;
    return label;
}

+ (UITextField *)textFieldWithFrame:(CGRect)frame fontSize:(int)fontSize color:(UIColor *)color {
    UITextField *textField = [[UITextField alloc] initWithFrame:frame];
    textField.font = [UIFont systemFontOfSize:fontSize];
    textField.textColor = color;
    return textField;
}

+ (UIButton *)buttonWithFrame:(CGRect)frame fontSize:(int)fontSize textColor:(UIColor *)textColor {
    return [self buttonWithFrame:frame fontSize:fontSize bgColor:nil textColor:textColor];
}

+ (UIButton *)buttonWithFrame:(CGRect)frame fontSize:(int)fontSize bgColor:(UIColor *)bgColor textColor:(UIColor *)textColor {
    return [self buttonWithFrame:frame fontSize:fontSize bgColor:bgColor textColor:textColor borderColor:nil];
}

+ (UIButton *)buttonWithFrame:(CGRect)frame fontSize:(int)fontSize bgColor:(UIColor *)bgColor textColor:(UIColor *)textColor borderColor:(UIColor *)borderColor {
    UIButton *button = [[UIButton alloc] initWithFrame:frame];
    if (bgColor != nil) {
        button.backgroundColor      = bgColor;
    }
    [button setTitleColor:textColor forState:UIControlStateNormal];
    button.titleLabel.font      = [UIFont systemFontOfSize:fontSize];
    [button.layer setMasksToBounds:YES];
    [button.layer setCornerRadius:5.0];
    
    if (borderColor != nil) {
        [button.layer setBorderWidth:0.5]; //边框宽度
        CGColorRef colorref = [borderColor CGColor];
        [button.layer setBorderColor:colorref];//边框颜色
    }
    
    return button;
}


+ (UITapGestureRecognizer *)singleFingerClickRecognizer:(id)target sel:(SEL)sel {
    UITapGestureRecognizer *recognizer  = [[UITapGestureRecognizer alloc] initWithTarget:target action:sel];
    recognizer.numberOfTouchesRequired  = 1;
    recognizer.numberOfTapsRequired     = 1;
    return recognizer;
}

+ (UITapGestureRecognizer *)singleFingerDoubleClickRecognizer:(id)target sel:(SEL)sel {
    UITapGestureRecognizer *recognizer  = [[UITapGestureRecognizer alloc] initWithTarget:target action:sel];
    recognizer.numberOfTouchesRequired  = 1;
    recognizer.numberOfTapsRequired     = 2;
    return recognizer;
}

+ (UIColor *)colorWithHexString:(NSString *)stringToConvert {
    
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if ([cString length] < 6)
        return [UIColor whiteColor];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor whiteColor];
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}


@end
