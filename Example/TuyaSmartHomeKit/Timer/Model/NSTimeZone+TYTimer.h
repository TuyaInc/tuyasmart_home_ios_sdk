//
//  NSTimeZone+TYTimer.h
//  TuyaSmartHomeKit_Example
//
//  Created by Sakata Gintoki on 2019/11/14.
//  Copyright © 2019 xuchengcheng. All rights reserved.
//


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 @return [NSTimeZone localTimeZone].name
 */
FOUNDATION_EXTERN NSString * TY_LocalTimeZoneName(void);
/**
 if timeZoneName is nil, use localTimeZone insted
 @return string like +08:00
 */
FOUNDATION_EXTERN NSString * TY_TimeDifferenceWithGMT(NSString * _Nullable timeZoneName);

@interface NSTimeZone (TYTimer)
/**
 @return string like +08:00
 */
- (NSString *)ty_timeDifferenceWithGMT;
@end

NS_ASSUME_NONNULL_END
