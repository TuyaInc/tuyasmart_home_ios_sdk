//
//  TPViewConstants.h
//  TuyaSmart
//
//  Created by fengyu on 15/9/7.
//  Copyright (c) 2015年 Tuya. All rights reserved.
//

#ifndef TuyaSmart_TPViewConstants_h
#define TuyaSmart_TPViewConstants_h

#define TP_SYSTEM_VERSION ([[[UIDevice currentDevice] systemVersion] floatValue])

//是否是IPhoneX的设备

#define IPhoneX ([UIApplication sharedApplication].statusBarFrame.size.height >= 44)

// Color
#define HEXCOLORA(rgbValue, a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 blue:((float)(rgbValue & 0xFF)) / 255.0 alpha:a]
#define HEXCOLOR(rgbValue) HEXCOLORA(rgbValue, 1.0)

#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define RGBCOLOR(r,g,b) RGBACOLOR(r,g,b,1)

// Screen
#define APP_SCREEN_BOUNDS   [[UIScreen mainScreen] bounds]
#define APP_SCREEN_HEIGHT   (APP_SCREEN_BOUNDS.size.height)
#define APP_SCREEN_WIDTH    (APP_SCREEN_BOUNDS.size.width)
#define APP_STATUS_FRAME    [UIApplication sharedApplication].statusBarFrame

#define APP_TOP_BAR_HEIGHT    (IPhoneX ? 88 : 64)
#define APP_STATUS_BAR_HEIGHT (IPhoneX ? 44 : 20)
#define APP_TOOL_BAR_HEIGHT   49
#define APP_TAB_BAR_HEIGHT    (IPhoneX ? (49 + 34): 49)
#define APP_CONTENT_WIDTH     (APP_SCREEN_BOUNDS.size.width)
#define APP_CONTENT_HEIGHT    (APP_SCREEN_HEIGHT - APP_TOP_BAR_HEIGHT - APP_TAB_BAR_HEIGHT)
#define APP_VISIBLE_HEIGHT    (APP_SCREEN_HEIGHT - APP_TOP_BAR_HEIGHT)


#define TPLocalizedString(key,comment) (NSLocalizedStringFromTableInBundle(key, @"TPViewsLocalizable", [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"TPViews" ofType:@"bundle"]] , comment) ?: key)

#define kDefaultCurrentHomeId @"kDefaultCurrentHomeId"


#endif
