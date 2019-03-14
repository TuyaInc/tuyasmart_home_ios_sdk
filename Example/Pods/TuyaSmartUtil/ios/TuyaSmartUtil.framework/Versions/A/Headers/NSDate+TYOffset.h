//
//  NSDate+TYOffset.h
//  TuyaSmartBaseKit
//
//  Created by 高森 on 2018/6/11.
//

#import <Foundation/Foundation.h>

void ty_setTimeOffset(double offset);

@interface NSDate (TYOffset)

+ (NSTimeInterval)ty_timeIntervalSince1970;

+ (NSString *)ty_timeZone;

@end
