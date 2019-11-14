//
//  UILabel+TYFactory.h
//  TYUIKit
//
//  Created by TuyaInc on 2019/5/14.
//

#import <UIKit/UIKit.h>

@interface UILabel (TYFactory)

+ (instancetype)ty_labelWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)color;
+ (instancetype)ty_labelWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)color frame:(CGRect)frame;

+ (instancetype)ty_labelWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)color widthMax:(CGFloat)width;

@end
