//
//  NSNumber+TPCategory.h
//  TYLibraryExample
//
//  Created by 冯晓 on 16/3/3.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface NSNumber (TPCategory)


+ (NSInteger)tp_randomIntBetweenMin:(NSInteger)minValue andMax:(NSInteger)maxValue;

+ (CGFloat)tp_randomFloat;

+ (CGFloat)tp_randomFloatBetweenMin:(CGFloat)minValue andMax:(CGFloat)maxValue;

@end
