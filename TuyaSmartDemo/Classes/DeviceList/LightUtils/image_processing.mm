//
//  image_processing.cpp
//  TuyaSmart
//
//  Created by 冯晓 on 15/12/11.
//  Copyright © 2015年 Tuya. All rights reserved.
//

#include "image_processing.h"
#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#include <memory.h>

#define CLAMP0255(x) (((x) < 0) ? 0 : ((x) > 255 ? 255 : (x)))
#define CLAMP0255_AB(x, a, b) (((x) < (a)) ? (a) : ((x) > (b) ? (b) : (x)))


#ifndef MAX
#define MAX(x, y)  (((x) >= (y)) ? (x) : (y))
#endif

#ifndef MIN
#define MIN(x, y)  (((x) >= (y)) ? (y) : (x))
#endif

bool IsEquals(double val1, double val2)
{
    return fabs(val1 - val2) < 1e-6;
}

// rgb转hsl
// hue: [-1, 5]
// saturation: [0, 1]
// lightness: [0, 1]
void RGBToHSL(int red, int green, int blue, double *hue, double *saturation, double *lightness)
{
    double max_val = 0.0, min_val = 0.0, delta = 0.0;
    double r = red / 255.0;
    double g = green / 255.0;
    double b = blue / 255.0;
    
    max_val = MAX(r, g);
    max_val = MAX(max_val, b);
    min_val = MIN(r, g);
    min_val = MIN(min_val, b);
    
    *lightness = (max_val + min_val) / 2.0;
    if (IsEquals(max_val, min_val))
    {
        *hue = 0.0;
        *saturation = 0.0;
    }
    else
    {
        delta = max_val - min_val;
        if (*lightness <= 0.5)
        {
            *saturation = delta / (max_val + min_val);
        }
        else
        {
            *saturation = delta / (2.0 - max_val - min_val);
        }
        
        if (IsEquals(r, max_val))
        {
            *hue = (g - b) / delta;
        }
        else if (IsEquals(g, max_val))
        {
            *hue = 2.0 + (b - r) / delta;
        }
        else if (IsEquals(b, max_val))
        {
            *hue = 4.0 + (r - g) / delta;
        }
    }
}


// hsl转rgb
// red: [0, 255]
// green: [0, 255]
// blue: [0, 255]
void HSLToRGB(double hue, double saturation, double lightness, int *red, int *green, int *blue)
{
    double r = 0.0, g = 0.0, b = 0.0;
    double max_val = 0.0, min_val = 0.0;
    
    if (hue > 5.0)
    {
        hue = hue - 6.0;
    }
    
    if (IsEquals(saturation, 0.0))
    {
        r = lightness;
        g = lightness;
        b = lightness;
    }
    else
    {
        if (lightness < 0.5)
        {
            min_val = lightness * (1.0 - saturation);
        }
        else
        {
            min_val = lightness - saturation * (1.0 - lightness);
        }
        
        max_val = 2 * lightness - min_val;
        
        if (hue < 1.0)
        {
            r = max_val;
            if (hue < 0.0)
            {
                g = min_val;
                b = g - hue * (max_val - min_val);
            }
            else
            {
                b = min_val;
                g = hue * (max_val - min_val) + b;
            }
        }
        else if (hue < 3.0)
        {
            g = max_val;
            if (hue < 2.0)
            {
                b = min_val;
                r = b - (hue - 2.0) * (max_val - min_val);
            }
            else
            {
                r = min_val;
                b = (hue - 2.0) * (max_val - min_val) + r;
            }
        }
        else
        {
            b = max_val;
            if (hue < 4.0)
            {
                r = min_val;
                g = r - (hue - 4.0) * (max_val - min_val);
            }
            else
            {
                g = min_val;
                r = (hue - 4.0) * (max_val - min_val) + g;
            }
        }
    }
    
    r = r * 255.0;
    g = g * 255.0;
    b = b * 255.0;
    *red = (int)CLAMP0255(r);
    *green = (int)CLAMP0255(g);
    *blue = (int)CLAMP0255(b);
}



// 计算图像色温
// 色温范围1000K至40000K(temperature: 实际输入值范围为10至400, 初始值: 65)
void CalculateImageColorTemperature(int temperature, int *r_temperature, int *g_temperature, int *b_temperature)
{
    double tempCalc = 0.0;
    temperature = MIN(400, MAX(10, temperature));
    // red
    if (temperature <= 66)
    {
        *r_temperature = 255;
    }
    else
    {
        tempCalc = temperature - 60;
        tempCalc = 329.698727446 * pow(tempCalc, -0.1332047592);
        *r_temperature = (int)CLAMP0255(tempCalc);
    }
    
    // green
    if (temperature <= 66)
    {
        tempCalc = temperature;
        tempCalc = 99.4708025861 * log(tempCalc) - 161.1195681661;
        *g_temperature = (int)CLAMP0255(tempCalc);
    }
    else
    {
        tempCalc = temperature - 60;
        tempCalc = 288.1221695283 * pow(tempCalc, -0.0755148492);
        *g_temperature = (int)CLAMP0255(tempCalc);
    }
    
    // blue
    if (temperature >= 66)
    {
        *b_temperature = 255;
    }
    else if (temperature <= 19)
    {
        *b_temperature = 0;
    }
    else
    {
        tempCalc = temperature - 10;
        tempCalc = 138.5177312231 * log(tempCalc) - 305.0447927307;
        *b_temperature = (int)CLAMP0255(tempCalc);
    }
}



// rgb转hsv
// 输入值范围
// r/g/b: [0, 255]
// 输出值范围
// hue: [0, 360]
// saturation: [0, 1]
// value: [0, 1]
void RGBToHSV(int red, int green, int blue, double *H, double *S, double *V)
{
    red   = (int)CLAMP0255(red);
    green = (int)CLAMP0255(green);
    blue  = (int)CLAMP0255(blue);
    
    double max_val = 0.0, min_val = 0.0, delta = 0.0;
    double R = (double)red / 255.0;
    double G = (double)green / 255.0;
    double B = (double)blue / 255.0;
    
    max_val = MAX(R, G);
    max_val = MAX(max_val, B);
    min_val = MIN(R, G);
    min_val = MIN(min_val, B);
    delta = max_val - min_val;
    
    *V = max_val;
    if (max_val > 0.0 && delta > 0.0)
    {
        if (max_val == R)
        {
            *H = (G - B) / delta;
        }
        else if (max_val == G)
            *H = 2 + (B - R) / delta;
        else
            *H = 4 + (R - G) / delta;
        
        *H *= 60;
        if (*H < 0)
        {
            *H += 360;
        }
        *S = delta / max_val;
    }
    else
    {
        *S = 0;
        *H = 0;
    }
    
    *H = CLAMP0255_AB(*H, 0.0, 360.0);
    *S = CLAMP0255_AB(*S, 0.0, 1.0);
    *V = CLAMP0255_AB(*V, 0.0, 1.0);
}

// hsv转rgb
// 输入值范围
// hue: [0, 360]
// saturation: [0, 1]
// value: [0, 1]
// 输出值范围
// r/g/b: [0, 255]
void HSVToRGB(double H, double S, double V, int *red, int *green, int *blue)
{
//    H = CLAMP0255_AB(H, 0.0, 360.0);
    S = CLAMP0255_AB(S, 0.0, 1.0);
    V = CLAMP0255_AB(V, 0.0, 1.0);
    
    if (IsEquals(S, 0.0))
    {
        *red = (int)CLAMP0255(V * 255);
        *green = (int)CLAMP0255(V * 255);
        *blue = (int)CLAMP0255(V * 255);
    }
    else
    {
        double C = S * V;
        double Min = V - C;
        double X = 0.0, R = 0.0, G = 0.0, B = 0.0;
        
        H -= 360*floor(H/360);
        H /= 60;
        X = C*(1 - fabs(H - 2*floor(H/2) - 1));
        
        switch((int)H)
        {
            case 0:
                R = Min + C;
                G = Min + X;
                B = Min;
                break;
            case 1:
                R = Min + X;
                G = Min + C;
                B = Min;
                break;
            case 2:
                R = Min;
                G = Min + C;
                B = Min + X;
                break;
            case 3:
                R = Min;
                G = Min + X;
                B = Min + C;
                break;
            case 4:
                R = Min + X;
                G = Min;
                B = Min + C;
                break;
            case 5:
                R = Min + C;
                G = Min;
                B = Min + X;
                break;
            default:
                R = G = B = 0.0;
                break;
        }
        
        *red = (int)CLAMP0255(R * 255);
        *green = (int)CLAMP0255(G * 255);
        *blue = (int)CLAMP0255(B * 255);
    }
}


// 输出校正
// gamma:[0.0, 10.0]
void Gamma(int *red, int *green, int *blue, double gamma)
{
    gamma = MIN(8.0, MAX(0.125, gamma));
    *red = (int)CLAMP0255(pow(*red / 255.0, gamma) * 255.0);
    *green = (int)CLAMP0255(pow(*green / 255.0, gamma) * 255.0);
    *blue = (int)CLAMP0255(pow(*blue / 255.0, gamma) * 255.0);
}


// 混合操作(type: 0 变暗/ 1 变亮/ 2 叠加, strength: 范围0.0~1.0)
void ImageBlend(int inR0, int inG0, int inB0, int inR1, int inG1, int inB1, int *outR, int *outG, int *outB, int type, double strength)
{
    int retR = 0, retG = 0, retB = 0;
    strength = MIN(1.0, MAX(0.0, strength));
    switch (type)
    {
        case 0:
            retR = MIN(inR0, inR1);
            retG = MIN(inG0, inG1);
            retB = MIN(inB0, inB1);
            *outR = inR0*(1.0 - strength) + retR*strength;
            *outG = inG0*(1.0 - strength) + retG*strength;
            *outB = inB0*(1.0 - strength) + retB*strength;
            *outR = (int)CLAMP0255(*outR);
            *outG = (int)CLAMP0255(*outG);
            *outB = (int)CLAMP0255(*outB);
            break;
        case 1:
            retR = MAX(inR0, inR1);
            retG = MAX(inG0, inG1);
            retB = MAX(inB0, inB1);
            *outR = inR0*(1.0 - strength) + retR*strength;
            *outG = inG0*(1.0 - strength) + retG*strength;
            *outB = inB0*(1.0 - strength) + retB*strength;
            *outR = (int)CLAMP0255(*outR);
            *outG = (int)CLAMP0255(*outG);
            *outB = (int)CLAMP0255(*outB);
            break;
        case 2:
            retR = (int)((inR0 < 128) ? (inR0*inR1) / 127 + 0.5 : 255 - ((255 - inR0)*(255 - inR1) / 127) + 0.5);
            retG = (int)((inG0 < 128) ? (inG0*inG1) / 127 + 0.5 : 255 - ((255 - inG0)*(255 - inG1) / 127) + 0.5);
            retB = (int)((inB0 < 128) ? (inB0*inB1) / 127 + 0.5 : 255 - ((255 - inB0)*(255 - inB1) / 127) + 0.5);
            *outR = inR0*(1.0 - strength) + retR*strength;
            *outG = inG0*(1.0 - strength) + retG*strength;
            *outB = inB0*(1.0 - strength) + retB*strength;
            *outR = (int)CLAMP0255(*outR);
            *outG = (int)CLAMP0255(*outG);
            *outB = (int)CLAMP0255(*outB);
            break;
        default:
            break;
    }
}

