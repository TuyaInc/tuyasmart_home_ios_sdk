//
//  TPViewUtil.h
//  TYLibraryExample
//
//  Created by 冯晓 on 16/2/16.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TPViewUtil : NSObject

#pragma mark - UILabel

+ (UILabel *)simpleLabel:(CGRect)frame f:(int)size tc:(UIColor *)color t:(NSString *)text;

+ (UILabel *)simpleLabel:(CGRect)frame bf:(int)size tc:(UIColor *)color t:(NSString *)text;

+ (UILabel *)simpleLabel:(CGRect)frame font:(UIFont *)font tc:(UIColor *)color t:(NSString *)text;

+ (UILabel *)labelWithFrame:(CGRect)frame fontSize:(int)fontSize color:(UIColor *)color;

#pragma mark - UIView

+ (UIView *)viewWithFrame:(CGRect)frame color:(UIColor *)color;

#pragma mark - UIImageView

+ (UIImageView *)imageViewWithFrame:(CGRect)frame image:(UIImage *)image;

+ (UIImageView *)imageViewWithFrame:(CGRect)frame imageName:(NSString *)imageName;

+ (UIImageView *)rightArrowImageView:(CGRect)frame;

#pragma mark - UItextField

+ (UITextField *)textFieldWithFrame:(CGRect)frame fontSize:(int)fontSize color:(UIColor *)color;

#pragma mark - UIButton

+ (UIButton *)buttonWithFrame:(CGRect)frame fontSize:(int)fontSize textColor:(UIColor *)textColor;

+ (UIButton *)buttonWithFrame:(CGRect)frame fontSize:(int)fontSize bgColor:(UIColor *)bgColor textColor:(UIColor *)textColor;

+ (UIButton *)buttonWithFrame:(CGRect)frame fontSize:(int)fontSize bgColor:(UIColor *)bgColor textColor:(UIColor *)textColor borderColor:(UIColor *)borderColor;


+ (UITapGestureRecognizer *)singleFingerClickRecognizer:(id)target sel:(SEL)sel;

+ (UITapGestureRecognizer *)singleFingerDoubleClickRecognizer:(id)target sel:(SEL)sel;

+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;

@end
