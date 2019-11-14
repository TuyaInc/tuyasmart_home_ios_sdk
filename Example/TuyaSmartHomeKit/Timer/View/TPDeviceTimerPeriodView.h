//
//  TPDeviceTimerPeriodView.h
//  fishNurse
//
//  Created by 冯晓 on 16/2/23.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPRepeatWeekView.h"

#define TIMER_LOOPS_EVERYDAY @"1111111"
#define TIMER_LOOPS_WEEKEND  @"1000001"
#define TIMER_LOOPS_WEEKDAY  @"0111110"
#define TIMER_LOOPS_NEVER    @"0000000"

@interface TPDeviceTimerPeriodView : UIView

@property(nonatomic,strong) TPRepeatWeekView *sunWeekView;
@property(nonatomic,strong) TPRepeatWeekView *monWeekView;
@property(nonatomic,strong) TPRepeatWeekView *tueWeekView;
@property(nonatomic,strong) TPRepeatWeekView *wedWeekView;
@property(nonatomic,strong) TPRepeatWeekView *thuWeekView;
@property(nonatomic,strong) TPRepeatWeekView *friWeekView;
@property(nonatomic,strong) TPRepeatWeekView *satWeekView;

+ (NSString *)repeatStringWeek:(NSString *)loops;
+ (NSArray *)weekArray;

@end
