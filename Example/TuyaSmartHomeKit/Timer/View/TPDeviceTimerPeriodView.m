//
//  TPDeviceTimerPeriodView.m
//  fishNurse
//
//  Created by 冯晓 on 16/2/23.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TPDeviceTimerPeriodView.h"

@interface TPDeviceTimerPeriodView()

@end

@implementation TPDeviceTimerPeriodView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.frame = frame;
    
    [self setBackgroundColor:MAIN_BACKGROUND_COLOR];
    [self addRepeatModeView];
    
    return self;
}

- (void)addRepeatModeView {
    UIView *repeatModeView = [UIView new];
    repeatModeView.frame = CGRectMake(0, 16, TY_ScreenWidth(), 44 * 7);
    repeatModeView.backgroundColor = [UIColor whiteColor];
    
//    UIView *separator = [[UIView alloc] initWithFrame:CGRectMake(0, 0, TY_ScreenWidth(), 0.5)];
//    separator.backgroundColor = SEPARATOR_LINE_COLOR;
//
//    [repeatModeView addSubview:separator];
    
    _sunWeekView = [[TPRepeatWeekView alloc] initWithFrame:CGRectMake(0, 0.5, TY_ScreenWidth(), 43.5) weekDay:0];
    [repeatModeView addSubview:_sunWeekView];
    
    _monWeekView = [[TPRepeatWeekView alloc] initWithFrame:CGRectMake(0, 44, TY_ScreenWidth(), 44) weekDay:1];
    [repeatModeView addSubview:_monWeekView];
    
    _tueWeekView = [[TPRepeatWeekView alloc] initWithFrame:CGRectMake(0, 44*2, TY_ScreenWidth(), 44) weekDay:2];
    [repeatModeView addSubview:_tueWeekView];
    
    _wedWeekView = [[TPRepeatWeekView alloc] initWithFrame:CGRectMake(0, 44*3, TY_ScreenWidth(), 44) weekDay:3];
    [repeatModeView addSubview:_wedWeekView];
    
    _thuWeekView = [[TPRepeatWeekView alloc] initWithFrame:CGRectMake(0, 44*4, TY_ScreenWidth(), 44) weekDay:4];
    [repeatModeView addSubview:_thuWeekView];
    
    _friWeekView = [[TPRepeatWeekView alloc] initWithFrame:CGRectMake(0, 44*5, TY_ScreenWidth(), 44) weekDay:5];
    [repeatModeView addSubview:_friWeekView];
    
    _satWeekView = [[TPRepeatWeekView alloc] initWithFrame:CGRectMake(0, 44*6, TY_ScreenWidth(), 44) weekDay:6];
    [repeatModeView addSubview:_satWeekView];
    
//    UIView *separatorLine = [UIView new];
//    separatorLine.frame = CGRectMake(0, 44 * 7 - 0.5, TY_ScreenWidth(), 0.5);
//    separatorLine.backgroundColor = SEPARATOR_LINE_COLOR;
//    [repeatModeView addSubview:separatorLine];
    [self addSubview:repeatModeView];
}

- (UIView *)weekView:(CGRect)frame weekDay:(NSInteger)weekDay {
    UIView *weekView   =  [[UIView alloc] initWithFrame:frame];
    weekView.backgroundColor = [UIColor whiteColor];
    
    UILabel *weekLabel = [UILabel ty_labelWithText:nil font:[UIFont systemFontOfSize:16] textColor:TY_HexColor(0x1E1E1E) frame:CGRectMake(15, 14, 100, 16)];
    weekLabel.text = [[TPDeviceTimerPeriodView weekArray] objectAtIndex:weekDay];
    [weekView addSubview:weekLabel];
    
    UIImageView *selectedImageView = [[UIImageView alloc] initWithFrame:CGRectMake(TY_ScreenWidth() - 35, 17, 13, 10)];
    selectedImageView.image = [UIImage imageNamed:@"TYSmartBusinessLibraryRes.bundle/tysmart_selected"];
    [weekView addSubview:selectedImageView];
    
    if (weekDay != 6) {
        UIView *separatorLine = [UIView new];
        separatorLine.frame = CGRectMake(15, frame.size.height - 0.5, frame.size.width - 15, 0.5);
        separatorLine.backgroundColor = SEPARATOR_LINE_COLOR;
        [weekView addSubview:separatorLine];
    }
    
    return weekView;
}

+ (NSString *)repeatStringWeek:(NSString *)loops {
    if (loops.length < 7) {
        return @"";
    }
    if ([loops isEqualToString:TIMER_LOOPS_NEVER]) {
        return NSLocalizedString(@"clock_timer_once", @"");
    } else if ([loops isEqualToString:TIMER_LOOPS_WEEKEND]) {
        return NSLocalizedString(@"clock_timer_weekEND", @"");
    } else if ([loops isEqualToString:TIMER_LOOPS_WEEKDAY]) {
        return NSLocalizedString(@"clock_timer_weekday", @"");
    } else if ([loops isEqualToString:TIMER_LOOPS_EVERYDAY]) {
        return NSLocalizedString(@"clock_timer_everyday", @"");
    } else {
        NSString *repeatString = @"";
        for (int i=0; i<=6; i++) {
            if ([[loops substringWithRange:NSMakeRange(i, 1)] isEqualToString:@"1"]) {
                repeatString = [repeatString stringByAppendingString:[[self weekArray] objectAtIndex:i]];
                repeatString = [repeatString stringByAppendingString:@" "];
            }
        }
        return repeatString;
    }
}

+ (NSArray *)weekArray {
    return @[
             NSLocalizedString(@"sunday", @""),
             NSLocalizedString(@"monday", @""),
             NSLocalizedString(@"tuesday", @""),
             NSLocalizedString(@"wednesday", @""),
             NSLocalizedString(@"thursday", @""),
             NSLocalizedString(@"friday", @""),
             NSLocalizedString(@"saturday", @"")];
}

- (void)setSelected:(NSInteger)weekDay selected:(BOOL)selected {
    
}

@end
