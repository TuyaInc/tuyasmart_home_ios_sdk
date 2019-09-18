//
//  NSDate+TYOffset.h
//  TuyaSmartBaseKit
//
//  Created by 高森 on 2018/6/11.
//

#import <Foundation/Foundation.h>

@interface NSDate (TYSDKOffset)

// 云端时间戳，每次启动会去校准云端时间
+ (NSTimeInterval)tysdk_serverTimeIntervalSince1970;

+ (NSString *)tysdk_timeZone;

@end
