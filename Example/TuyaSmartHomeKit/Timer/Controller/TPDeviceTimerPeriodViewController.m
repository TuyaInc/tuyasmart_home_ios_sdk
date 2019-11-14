//
//  TPDeviceTimerPeriodViewController.m
//  fishNurse
//
//  Created by 冯晓 on 16/2/23.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TPDeviceTimerPeriodViewController.h"
#import "TPDeviceTimerPeriodView.h"

@interface TPDeviceTimerPeriodViewController()

@property (nonatomic,strong) TPDeviceTimerPeriodView *repeatModeView;

@property (nonatomic, strong) NSString *loops;

@end

@implementation TPDeviceTimerPeriodViewController

- (instancetype)initWithQuery:(NSDictionary *)query {
    if (self = [super init]) {
        if ([query objectForKey:@"loops"]) {
            _loops = [query objectForKey:@"loops"];
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.topBarView.leftItem = self.leftBackItem;
    [self initView];
}

-(void)initView {
    [self initRepeatModeView];
    [self initWeekView];
}

-(void)initRepeatModeView {
    _repeatModeView = [[TPDeviceTimerPeriodView alloc] initWithFrame:CGRectMake(0, 100, TY_ScreenWidth(), [UIApplication sharedApplication].keyWindow.bounds.size.height - 100)];
    [_repeatModeView.sunWeekView addGestureRecognizer:[self singleFingerClickRecognizer:self sel:@selector(sunWeekViewTap:)]];
    [_repeatModeView.monWeekView addGestureRecognizer:[self singleFingerClickRecognizer:self sel:@selector(monWeekViewTap:)]];
    [_repeatModeView.tueWeekView addGestureRecognizer:[self singleFingerClickRecognizer:self sel:@selector(tueWeekViewTap:)]];
    [_repeatModeView.wedWeekView addGestureRecognizer:[self singleFingerClickRecognizer:self sel:@selector(wedWeekViewTap:)]];
    [_repeatModeView.thuWeekView addGestureRecognizer:[self singleFingerClickRecognizer:self sel:@selector(thuWeekViewTap:)]];
    [_repeatModeView.friWeekView addGestureRecognizer:[self singleFingerClickRecognizer:self sel:@selector(friWeekViewTap:)]];
    [_repeatModeView.satWeekView addGestureRecognizer:[self singleFingerClickRecognizer:self sel:@selector(satWeekViewTap:)]];;
    [self.view addSubview:_repeatModeView];
    
    self.title = NSLocalizedString(@"repeat", @"");
}

- (UITapGestureRecognizer *)singleFingerClickRecognizer:(id)target sel:(SEL)sel {
    UITapGestureRecognizer *recognizer  = [[UITapGestureRecognizer alloc] initWithTarget:target action:sel];
    recognizer.numberOfTouchesRequired  = 1;
    recognizer.numberOfTapsRequired     = 1;
    return recognizer;
}

- (void)initWeekView {
    [_repeatModeView.sunWeekView setSelected:[self isRepeatDay:WeekDaySun]];
    [_repeatModeView.monWeekView setSelected:[self isRepeatDay:WeekDayMon]];
    [_repeatModeView.tueWeekView setSelected:[self isRepeatDay:WeekDayTue]];
    [_repeatModeView.wedWeekView setSelected:[self isRepeatDay:WeekDayWed]];
    [_repeatModeView.thuWeekView setSelected:[self isRepeatDay:WeekDayThu]];
    [_repeatModeView.friWeekView setSelected:[self isRepeatDay:WeekDayFri]];
    [_repeatModeView.satWeekView setSelected:[self isRepeatDay:WeekDaySat]];
}

- (BOOL)isRepeatDay:(WeekDay)weekday {
    if ([[_loops substringWithRange:NSMakeRange(weekday, 1)] isEqualToString:@"1"]) {
        return YES;
    } else {
        return NO;
    }
}

- (void)sunWeekViewTap:(UIGestureRecognizer *)sender {
    [_repeatModeView.sunWeekView setSelected:!_repeatModeView.sunWeekView.isSelected];
}

- (void)monWeekViewTap:(UIGestureRecognizer *)sender {
    [_repeatModeView.monWeekView setSelected:!_repeatModeView.monWeekView.isSelected];
}

- (void)tueWeekViewTap:(UIGestureRecognizer *)sender {
    [_repeatModeView.tueWeekView setSelected:!_repeatModeView.tueWeekView.isSelected];
}

- (void)wedWeekViewTap:(UIGestureRecognizer *)sender {
    [_repeatModeView.wedWeekView setSelected:!_repeatModeView.wedWeekView.isSelected];
}

- (void)thuWeekViewTap:(UIGestureRecognizer *)sender {
    [_repeatModeView.thuWeekView setSelected:!_repeatModeView.thuWeekView.isSelected];
}

- (void)friWeekViewTap:(UIGestureRecognizer *)sender {
    [_repeatModeView.friWeekView setSelected:!_repeatModeView.friWeekView.isSelected];
}

- (void)satWeekViewTap:(UIGestureRecognizer *)sender {
    [_repeatModeView.satWeekView setSelected:!_repeatModeView.satWeekView.isSelected];
}

- (void)backButtonTap {
    if ([self.delegate respondsToSelector:@selector(setRepeatMode:loopsWeek:)]) {
        _loops = [self repeatString];
        [self.delegate setRepeatMode:_loops loopsWeek:[self repeatStringWeek]];
    }
    [self.navigationController popViewControllerAnimated:YES];
}


- (NSString *)repeatStringWeek {
    if (_loops.length < 7) {
        return @"";
    }
    if ([_loops isEqualToString:TIMER_LOOPS_NEVER]) {
        return NSLocalizedString(@"clock_timer_once", @"");
    } else if ([_loops isEqualToString:TIMER_LOOPS_WEEKEND]) {
        return NSLocalizedString(@"clock_timer_weekEND", @"");
    } else if ([_loops isEqualToString:TIMER_LOOPS_WEEKDAY]) {
        return NSLocalizedString(@"clock_timer_weekday", @"");
    } else if ([_loops isEqualToString:TIMER_LOOPS_EVERYDAY]) {
        return NSLocalizedString(@"clock_timer_everyday", @"");
    } else {
        NSString *repeatString = @"";
        for (int i=0; i<=6; i++) {
            if ([[_loops substringWithRange:NSMakeRange(i, 1)] isEqualToString:@"1"]) {
                repeatString = [repeatString stringByAppendingString:[[TPDeviceTimerPeriodView weekArray] objectAtIndex:i]];
                repeatString = [repeatString stringByAppendingString:@" "];
            }
        }
        return repeatString;
    }
}

- (NSString *)repeatString {
    
    NSString *repeatString = @"";
    
    if (_repeatModeView.sunWeekView.isSelected) {
        repeatString = [repeatString stringByAppendingString:@"1"];
    } else {
        repeatString = [repeatString stringByAppendingString:@"0"];
    }
    
    if (_repeatModeView.monWeekView.isSelected) {
        repeatString = [repeatString stringByAppendingString:@"1"];
    } else {
        repeatString = [repeatString stringByAppendingString:@"0"];
    }
    
    if (_repeatModeView.tueWeekView.isSelected) {
        repeatString = [repeatString stringByAppendingString:@"1"];
    } else {
        repeatString = [repeatString stringByAppendingString:@"0"];
    }
    
    if (_repeatModeView.wedWeekView.isSelected) {
        repeatString = [repeatString stringByAppendingString:@"1"];
    } else {
        repeatString = [repeatString stringByAppendingString:@"0"];
    }
    
    if (_repeatModeView.thuWeekView.isSelected) {
        repeatString = [repeatString stringByAppendingString:@"1"];
    } else {
        repeatString = [repeatString stringByAppendingString:@"0"];
    }
    
    if (_repeatModeView.friWeekView.isSelected) {
        repeatString = [repeatString stringByAppendingString:@"1"];
    } else {
        repeatString = [repeatString stringByAppendingString:@"0"];
    }
    
    if (_repeatModeView.satWeekView.isSelected) {
        repeatString = [repeatString stringByAppendingString:@"1"];
    } else {
        repeatString = [repeatString stringByAppendingString:@"0"];
    }

    
    return repeatString;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
