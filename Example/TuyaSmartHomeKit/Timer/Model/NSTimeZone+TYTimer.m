//
//  NSTimeZone+TYTimer.m
//  TuyaSmartHomeKit_Example
//
//  Created by Sakata Gintoki on 2019/11/14.
//  Copyright © 2019 xuchengcheng. All rights reserved.
//

#import "NSTimeZone+TYTimer.h"

inline NSString * TY_LocalTimeZoneName(void) {
    return [NSTimeZone localTimeZone].name;
}
inline NSString * TY_TimeDifferenceWithGMT(NSString *timeZoneName) {
    NSTimeZone *timeZone = timeZoneName ? [NSTimeZone timeZoneWithName:timeZoneName] : [NSTimeZone localTimeZone];
    return [timeZone ty_timeDifferenceWithGMT];
}

@implementation NSTimeZone (TYTimer)
- (NSString *)ty_timeDifferenceWithGMT {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"xxx"];   //+08:00
    [formatter setTimeZone:self];
    return [formatter stringFromDate:[NSDate date]];
}
@end
