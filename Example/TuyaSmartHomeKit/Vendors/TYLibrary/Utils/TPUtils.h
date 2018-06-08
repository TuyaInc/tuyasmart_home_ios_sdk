//
//  TPUtils.h
//  TYLibraryExample
//
//  Created by 冯晓 on 16/2/16.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "TPDate.h"

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

void at_dispatch_async_on_default_global_thread(dispatch_block_t block);
void at_dispatch_async_on_main_thread(dispatch_block_t block);
void at_dispatch_sync_on_main_thread(dispatch_block_t block);


UIViewController *tp_topMostViewController();

@interface TPUtils : NSObject

+ (NSString *)getAppleLanguages;

+ (BOOL)isChinese;

+ (UIImage *)imageNamedLocalize:(NSString *)imageName;

+ (BOOL)IsEnableInternet;


+ (NSString *)getISOcountryCode;


@end


#pragma mark NSJSONSerialization Category

@interface NSString (TPJSONKit)
- (id)tp_objectFromJSONString;
- (id)tp_objectFromJSONString:(NSJSONReadingOptions)serializeOptions error:(NSError **)error;
@end

@interface NSArray (TPJSONKit)
- (NSString *)tp_JSONString;
- (NSString *)tp_JSONStringWithOptions:(NSJSONWritingOptions)serializeOptions error:(NSError **)error;
@end

@interface NSDictionary (TPJSONKit)
- (NSString *)tp_JSONString;
- (NSString *)tp_JSONStringWithOptions:(NSJSONWritingOptions)serializeOptions error:(NSError **)error;
@end

