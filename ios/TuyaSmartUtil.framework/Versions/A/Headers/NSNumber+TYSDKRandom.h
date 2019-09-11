//
//  NSNumber+TYRandom.h
//  TuyaSmartBaseKit
//
//  Created by 高森 on 2018/6/14.
//

#import <Foundation/Foundation.h>

@interface NSNumber (TYSDKRandom)

+ (NSInteger)tysdk_randomIntBetweenMin:(NSInteger)minValue andMax:(NSInteger)maxValue;

+ (float)tysdk_randomFloat;

+ (float)tysdk_randomFloatBetweenMin:(float)minValue andMax:(float)maxValue;

@end
