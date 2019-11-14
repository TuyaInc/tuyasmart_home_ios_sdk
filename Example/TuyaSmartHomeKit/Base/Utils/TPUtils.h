//
//  TPUtils.h
//  TYLibraryExample
//
//  Created by 冯晓 on 16/2/16.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#undef	TP_SINGLETON
#define TP_SINGLETON( __class ) \
+ (__class *)sharedInstance;

#undef	TP_DEF_SINGLETON
#define TP_DEF_SINGLETON( __class ) \
+ (__class *)sharedInstance \
{ \
static dispatch_once_t once; \
static __class * __singleton__; \
dispatch_once( &once, ^{ __singleton__ = [[__class alloc] init]; } ); \
return __singleton__; \
}




#define WEAKSELF_AT __weak __typeof(&*self)weakSelf_AT = self;

CGFloat TY_ScreenWidth(void);

UIViewController *tp_topMostViewController();

@interface TPUtils : NSObject

// App-Prefs:root=xxx 过机审需要字符串加密
+ (NSURL *)prefsUrlWithQuery:(NSDictionary *)query;

+ (NSURL *)wifiSettingUrl;

+ (NSString *)currentWifiSSID;
+ (NSString *)getAppleLanguages;

+ (BOOL)isChinese;

+ (UIImage *)imageNamedLocalize:(NSString *)imageName;

+ (BOOL)IsEnableInternet;


+ (NSString *)getISOcountryCode;


@end

@interface NSString (TPJSONKit)
- (id)tp_objectFromJSONString;
- (id)tp_objectFromJSONString:(NSJSONReadingOptions)serializeOptions error:(NSError **)error;
@end

