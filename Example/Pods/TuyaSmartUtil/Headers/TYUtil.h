//
//  TYUtil.h
//  TuyaSmartBaseKit
//
//  Created by 高森 on 2018/6/12.
//

#import <Foundation/Foundation.h>

void ty_dispatch_async_on_default_global_thread(dispatch_block_t block);
void ty_dispatch_async_on_main_thread(dispatch_block_t block);
void ty_dispatch_sync_on_main_thread(dispatch_block_t block);

@interface TYUtil : NSObject

#if TARGET_OS_IOS

+ (NSString *)currentWifiSSID;

+ (NSString *)currentWifiBSSID;

#endif

+ (uint32_t)getIntValueByHex:(NSString *)str;

+ (NSString *)getISOcountryCode;

+ (BOOL)compareVesionWithDeviceVersion:(NSString *)deviceVersion appVersion:(NSString *)appVersion;

@end


extern NSString * const TYUtilHostAppExtensionString;
extern NSString * const TYUtilTodayWidgetExtensionString;
extern NSString * const TYUtilIntentExtensionString;
extern NSString * const TYUtilIntentUIExtensionString;
extern NSString * const TYUtilWatchKitExtensionString;

/**
 *  @category TYUtil(AppExtension)
 *  To determine which process the code runs in (App/AppExtension/WatchKitExtension).
 *  运行时判断当前代码运行在哪个进程
 */
@interface TYUtil (AppExtension)

+ (NSString *)currentExtensionString;

+ (BOOL)isHostApp;

+ (BOOL)isAppExtension;

+ (BOOL)isWatchKitExtension;

@end
