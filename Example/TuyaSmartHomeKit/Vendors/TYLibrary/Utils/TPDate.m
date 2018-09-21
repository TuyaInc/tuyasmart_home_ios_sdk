//
//  TPDate.m
//  TYLibraryExample
//
//  Created by 冯晓 on 16/2/16.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TPDate.h"

#define kATKeychainTopTimestamp         @"ATKeychainTopTimestamp"

@implementation TPDate

+ (void)setTimeOffset:(double)offset {
    
    [[NSUserDefaults standardUserDefaults] setDouble:offset forKey:kATKeychainTopTimestamp];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (double)getTimeOffset {
    return [[NSUserDefaults standardUserDefaults] doubleForKey:kATKeychainTopTimestamp];
}

+ (NSDate *)timestamp2date:(NSString *)timestamp {
    if ([timestamp intValue] < 0) {
        timestamp = [TPDate getTimeString];
    }
    return [NSDate dateWithTimeIntervalSince1970:[timestamp doubleValue]];
}

+ (NSString *)date2timestamp:(NSDate *)date {
    long longDate = [date timeIntervalSince1970];
    if (longDate < 0) {
        longDate = [[NSDate date] timeIntervalSince1970];
    }
    return [NSString stringWithFormat:@"%ld",longDate];
}

+ (NSString *)getExpriesTime:(float)times {
    
    double offSet = [TPDate getTimeOffset];
    return [NSString stringWithFormat:@"%.0f",[[NSDate date] timeIntervalSince1970] + offSet + times];
}

+ (NSString *)getTimeString {
    
    double offSet = [TPDate getTimeOffset];
    return [NSString stringWithFormat:@"%.0f", [[NSDate date] timeIntervalSince1970] + offSet];
}

+ (NSString *)time2String:(NSString *)timestamp format:(NSString *)format {
    if ([timestamp intValue] < 0) {
        timestamp = [TPDate getTimeString];
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSDate *theday = [NSDate dateWithTimeIntervalSince1970:[timestamp doubleValue]];
    NSString *day = [dateFormatter stringFromDate:theday];
    
    return day;
}



+ (NSDate *)string2date:(NSString *)timeStr format:(NSString *)format {
    if ([timeStr intValue] < 0) {
        timeStr = [TPDate getTimeString];
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:format]; //@"YYYY-MM-dd HH:mm:ss"
    
    //NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    //[formatter setTimeZone:timeZone];
    
    return [formatter dateFromString:timeStr];
}

+ (NSString *)string2time:(NSString *)timeString format:(NSString *)format {
    NSDate *date = [self string2date:timeString format:format];
    return [NSString stringWithFormat:@"%ld",(long)[date timeIntervalSince1970]];
}



+ (int)getTimeInt:(NSString *)dateString setTimeFormat:(NSString *)timeFormatStr setTimeZome:(NSString *)timeZoneStr{
    
    
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    [formatter setDateFormat:timeFormatStr];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:timeZoneStr]];
    
    NSDate *formatterDate = [formatter dateFromString:dateString];
    int timeInt = [formatterDate timeIntervalSince1970];
    return timeInt;
}


+ (BOOL)is24HourType {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[NSLocale currentLocale]];
    [formatter setDateStyle:NSDateFormatterNoStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    NSString *dateString = [formatter stringFromDate:[NSDate date]];
    NSRange amRange = [dateString rangeOfString:[formatter AMSymbol]];
    NSRange pmRange = [dateString rangeOfString:[formatter PMSymbol]];
    return amRange.location == NSNotFound && pmRange.location == NSNotFound;
}
@end
