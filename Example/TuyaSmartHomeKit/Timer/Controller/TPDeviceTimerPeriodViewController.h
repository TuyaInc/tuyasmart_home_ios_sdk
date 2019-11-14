//
//  TPDeviceTimerPeriodViewController.h
//  fishNurse
//
//  Created by 冯晓 on 16/2/23.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TPBaseViewController.h"

#define TIMER_LOOPS_EVERYDAY @"1111111"
#define TIMER_LOOPS_WEEKEND  @"1000001"
#define TIMER_LOOPS_WEEKDAY  @"0111110"
#define TIMER_LOOPS_NEVER    @"0000000"

typedef NS_OPTIONS(NSUInteger, WeekDay) {
    WeekDaySun = 0,
    WeekDayMon = 1,
    WeekDayTue = 2,
    WeekDayWed = 3,
    WeekDayThu = 4,
    WeekDayFri = 5,
    WeekDaySat = 6
};

@class TPDeviceTimerPeriodViewController;

@protocol TPDeviceTimerPeriodViewControllerDelegate <NSObject>

- (void)setRepeatMode:(NSString *)loops loopsWeek:(NSString *)loopsWeek;

@end

@interface TPDeviceTimerPeriodViewController : TPBaseViewController

@property (nonatomic, weak) id <TPDeviceTimerPeriodViewControllerDelegate> delegate;
@property (nonatomic, strong) NSDictionary *timerConfig;

- (instancetype)initWithQuery:(NSDictionary *)query;

@end
