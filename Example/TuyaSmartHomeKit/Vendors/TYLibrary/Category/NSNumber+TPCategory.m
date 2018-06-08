//
//  NSNumber+TPCategory.m
//  TYLibraryExample
//
//  Created by 冯晓 on 16/3/3.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "NSNumber+TPCategory.h"

@implementation NSNumber (TPCategory)


+ (NSInteger)tp_randomIntBetweenMin:(NSInteger)minValue andMax:(NSInteger)maxValue {
    return (NSInteger)(minValue + [self tp_randomFloat] * (maxValue - minValue));
}

+ (CGFloat)tp_randomFloat {
    return (float) arc4random() / UINT_MAX;
}

+ (CGFloat)tp_randomFloatBetweenMin:(CGFloat)minValue andMax:(CGFloat)maxValue {
    return (((float) (arc4random() % ((unsigned)RAND_MAX + 1)) / RAND_MAX) * (maxValue - minValue)) + minValue;
}


@end
