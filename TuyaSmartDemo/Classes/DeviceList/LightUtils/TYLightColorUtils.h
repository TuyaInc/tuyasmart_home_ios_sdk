//
//  TYLightColorUtils.h
//  TuyaSmart
//
//  Created by 冯晓 on 15/12/11.
//  Copyright © 2015年 Tuya. All rights reserved.
//

#import "image_processing.h"

typedef struct {float r, g, b,w;} RGBWType;
typedef struct {float r, g, b;} RGBType;
typedef struct {float h, s, v;} HSVType;

void swap(double* a, double* b);

RGBType RGBTypeMake(float r, float g, float b);

RGBWType RGBWTypeMake(float r, float g, float b,float w);

@interface TYLightColorUtils : NSObject


/*
 value 亮度 0 - 4095
 
 temper 色温  17 -  117
 
 */
+ (RGBType)calculateColor:(int)value temper:(int)temper;

+ (NSString *)convertToHardwareValue:(int)value;

+ (NSArray *)convertToSoftwareValue:(NSString *)value;

@end


