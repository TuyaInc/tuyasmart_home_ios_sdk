//
//  TYLightColorUtils.m
//  TuyaSmart
//
//  Created by 冯晓 on 15/12/11.
//  Copyright © 2015年 Tuya. All rights reserved.
//

#import "TYLightColorUtils.h"

//#import <TYFoundationKit/TYFoundationKit.h>


@implementation TYLightColorUtils


void swap(double* a, double* b)
{
    double temp = *a;
    *a = *b;
    *b = temp;
}

RGBType RGBTypeMake(float r, float g, float b)
{
    RGBType rgb = {r, g, b};
    return rgb;
}


RGBWType RGBWTypeMake(float r, float g, float b,float w)
{
    RGBWType rgbw = {r, g, b,w};
    return rgbw;
}



/**
 *
 *
 *  @param value  0 - 255
 *  @param temper 0 - 255
 *
 *  @return
 */
+ (RGBType)calculateColor:(int)value temper:(int)temper {
    
    
    int r_temperature = 0;
    int g_temperature = 0;
    int b_temperature = 0;
    
    
    //色温 =》 RGB
    
    CalculateImageColorTemperature((int)((temper / 255.f) * 100 + 17 + 0.5f), &r_temperature, &g_temperature, &b_temperature);
    
    
    //RGB => HSV
    double H,S,V;
    
    
    //0 - 360  0 - 1 0 - 1
    RGBToHSV(r_temperature, g_temperature, b_temperature, &H, &S, &V);
    
    
    V += value / 255.f * 2 - 1;
    
    V = V < 0 ? 0 : (V > 1) ? 1 : V;
    
    int R,G,B;
    
    HSVToRGB(H, S, V, &R, &G, &B);
    
    RGBType res = {R,G,B};
    
    return res;
    
    
    /*
     public static int calculateColorByValueAndTemper(int value, int temper) {
     int r[] = new int[1];
     int g[] = new int[1];
     int b[] = new int[1];
     ImageProcessing.CalculateImageColorTemperature((int) ((temper / 255f) * 100 + 17 + 0.5f), r, g, b);
     float hsv[] = new float[3];
     Color.colorToHSV(Color.argb(255, r[0], g[0], b[0]), hsv);
     hsv[2] = hsv[2] + (value / 255.0f * 2 - 1);
     int color = Color.HSVToColor(hsv);
     //        r[0] = Color.red(color);
     //        g[0] = Color.green(color);
     //        b[0] = Color.blue(color);
     //        L.d(TAG, "白光模式： " + r[0] + "  " + g[0] + "  " + b[0]);
     //        ImageProcessing.Gamma(r, g, b, 2.0);
     //        return Color.argb(255, r[0], g[0], b[0]);
     return color;
     }
     */
}


/**
 *  转成硬件需要的值 硬件需要的值 都是0 -255
    转成 4位 的 16进制，不足的左边补0
 */
+ (NSString *)convertToHardwareValue:(int)value {
    //16进制
    NSString *res = [NSString stringWithFormat:@"%0x",value];
    
    //左边补0
    NSInteger count = 4 - res.length;
    
    if (count < 0) {
        count = 0;
    }
    
    for (NSInteger i = 0;i<count;i++) {
        res = [NSString stringWithFormat:@"0%@",res];
    }
    
    return res;
}

/**
 *  转成软件需要的值
 *  每隔4位截取，左边0去掉， 16进制 转成10进制
 
 
 */
+ (NSArray *)convertToSoftwareValue:(NSString *)value {
    
    if (value.length % 4 != 0) {
        return nil;
    }
    
    NSMutableArray *list = [NSMutableArray new];
    
    for (NSInteger i = 0 ; i < value.length ;i += 4) {
        NSRange range       = NSMakeRange(i, 4);
        NSString *subString = [value substringWithRange:range];

     
        
        NSMutableString *newString = [NSMutableString stringWithCapacity:0];
        
        
        
        for (int i = 0; i < [subString length]; i++) {
            NSString *temp = [subString substringWithRange:NSMakeRange(i, 1)];

            if (newString.length > 0) {
                [newString appendString:temp];
            } else {
                
                if ([temp isEqualToString:@"0"]) {
                    ;;
                } else {
                    [newString appendString:temp];
                }
            }
        }
        //十六机制  =》 十进制
        NSInteger subValue = [[NSString stringWithFormat:@"%ld", strtoul([newString UTF8String],0,16)] intValue];
        
//        subValue = subValue >> 4;
        
        [list addObject:@(subValue)];
    }
    return list;
}

@end
