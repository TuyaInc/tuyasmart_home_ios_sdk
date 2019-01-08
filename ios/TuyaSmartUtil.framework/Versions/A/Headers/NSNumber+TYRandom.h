//
//  NSNumber+TYRandom.h
//  TuyaSmartBaseKit
//
//  Created by 高森 on 2018/6/14.
//

#import <Foundation/Foundation.h>

@interface NSNumber (TYRandom)

+ (NSInteger)ty_randomIntBetweenMin:(NSInteger)minValue andMax:(NSInteger)maxValue;

+ (float)ty_randomFloat;

+ (float)ty_randomFloatBetweenMin:(float)minValue andMax:(float)maxValue;

@end
