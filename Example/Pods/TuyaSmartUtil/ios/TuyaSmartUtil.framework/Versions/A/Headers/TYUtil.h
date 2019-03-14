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

+ (NSString *)currentWifiSSID;

+ (NSString *)currentWifiBSSID;

+ (uint32_t)getIntValueByHex:(NSString *)str;

+ (NSString *)getISOcountryCode;

+ (BOOL)compareVesionWithDeviceVersion:(NSString *)deviceVersion appVersion:(NSString *)appVersion;

+ (NSString *)md5WithString:(NSString *)string;

+ (NSString *)md5WithData:(NSData *)data;

+ (NSString *)md5hex:(NSString *)string;

@end
