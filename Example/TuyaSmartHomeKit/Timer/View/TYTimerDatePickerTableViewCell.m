//
//  TYTimerDatePickerTableViewCell.m
//  TuyaSmartHomeKit_Example
//
//  Created by Sakata Gintoki on 2019/11/12.
//  Copyright © 2019 xuchengcheng. All rights reserved.
//

#import "TYTimerDatePickerTableViewCell.h"

@implementation TYTimerDatePickerTableViewCell {
    UIDatePicker *datePicker;
}

+ (CGFloat)cellHeight {
    return 200;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(15, 0, TY_ScreenWidth() - 30, 200)];
        datePicker.datePickerMode = UIDatePickerModeTime;
        [self.contentView addSubview:datePicker];
        [datePicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return self;
}

- (void)bindTimezonId:(NSString *)timezoneId time:(NSString *)time {
    
    datePicker.timeZone = [NSTimeZone timeZoneWithName:timezoneId];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"HH:mm";
    formatter.timeZone = [NSTimeZone timeZoneWithName:timezoneId];
    [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"]];
    if (!time.length) {
        time = time?:[formatter stringFromDate:[NSDate date]];
        if (self.timeChangeBlock) {
            self.timeChangeBlock(time);
        }
    }
    datePicker.date = [formatter dateFromString:time];
}

- (void)datePickerValueChanged:(UIDatePicker *)datePicker {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"HH:mm a";
    [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"]];
    formatter.timeZone = [NSTimeZone timeZoneWithName:datePicker.timeZone.name];
    NSString *date = [formatter stringFromDate:datePicker.date];
    
    NSArray *timeArray = [date componentsSeparatedByString:@" "];
    NSString *time;
    if (timeArray.count > 1) {
        time = [timeArray firstObject];
    } else {
        time = date;
    }
    if (self.timeChangeBlock) {
        self.timeChangeBlock(time);
    }
}

@end
