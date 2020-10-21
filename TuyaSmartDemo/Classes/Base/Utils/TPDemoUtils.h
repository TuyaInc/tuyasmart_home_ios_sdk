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


#define kNotificationSwitchHome         @"kNotificationSwitchHome"

#define WEAKSELF_AT __weak __typeof(&*self)weakSelf_AT = self;

#define TYSDKDemoLocalizedString(key, comment) \
    [NSBundle tysdkdemo_localizedStringForKey:(key) value:@"" table:nil]

CGFloat TYSDK_ScreenWidth(void);

UIViewController *tp_topMostViewController();

@interface TPDemoUtils : NSObject

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

@interface NSBundle (TYSDKDemoLanguage)

+ (NSBundle *)tysdkdemo_languageBundle;

+ (NSString *)tysdkdemo_localizedStringForKey:(NSString *)key value:(NSString *)value table:(NSString *)tableName;

@end

@interface UIImage (TYSDKDemoImage)

+ (UIImage *)tysdkdemo_imageNamed:(NSString *)name;

+ (UIImage *)tysdkdemo_imageNamed:(NSString *)name inBundle:(NSBundle *)bundle;

@end
