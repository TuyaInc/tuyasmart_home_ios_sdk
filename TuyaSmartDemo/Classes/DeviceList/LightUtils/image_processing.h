//
//  image_processing.hpp
//  TuyaSmart
//
//  Created by 冯晓 on 15/12/11.
//  Copyright © 2015年 Tuya. All rights reserved.
//

#ifndef image_processing_h
#define image_processing_h

#ifdef __cplusplus
extern "C" {
#endif
    
    
    
    
    
#include <stdio.h>

    
void RGBToHSL(int red, int green, int blue, double *hue, double *saturation, double *lightness);

void HSLToRGB(double hue, double saturation, double lightness, int *red, int *green, int *blue);

void CalculateImageColorTemperature(int temperature, int *r_temperature, int *g_temperature, int *b_temperature);


void RGBToHSV(int red, int green, int blue, double *H, double *S, double *V);
    
    
void HSVToRGB(double H, double S, double V, int *red, int *green, int *blue);

// 输出校正
// gamma:[0.0, 10.0]
void Gamma(int *red, int *green, int *blue, double gamma);
    
    
// 混合操作(type: 0 变暗/ 1 变亮/ 2 叠加, strength: 范围0.0~1.0)
void ImageBlend(int inR0, int inG0, int inB0, int inR1, int inG1, int inB1, int *outR, int *outG, int *outB, int type, double strength);

    
#ifdef __cplusplus
};
#endif


#endif /* image_processing_h */


/*
 亮度 0 - 4095
 
 色温  17 -  117
 
 r g b  w
 1 1 1  17
*/