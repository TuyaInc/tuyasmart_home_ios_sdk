//
//  TPDate.h
//  TYLibraryExample
//
//  Created by 冯晓 on 16/2/16.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TPDate : NSObject

+ (void)setTimeOffset:(double)offset;

+ (NSDate *)timestamp2date:(NSString *)timestamp;

+ (NSString *)date2timestamp:(NSDate *)date;

+ (NSString *)getTimeString;

+ (NSString *)getExpriesTime:(float)times;

+ (NSString *)time2String:(NSString *)timestamp format:(NSString *)format;

+ (NSDate *)string2date:(NSString *)timeStr format:(NSString *)format;

+ (NSString *)string2time:(NSString *)timeString format:(NSString *)format;

+ (int)getTimeInt:(NSString *)dateString setTimeFormat:(NSString *)timeFormatStr setTimeZome:(NSString *)timeZoneStr;

@end
