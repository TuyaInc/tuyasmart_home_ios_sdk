//
//  TPDeviceTimerListCell.m
//  fishNurse
//
//  Created by 冯晓 on 16/2/22.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TPDeviceTimerListCell.h"
#import "TPDeviceTimerPeriodView.h"

@interface TPDeviceTimerListCell()

@property (nonatomic, strong) UILabel      *titleLabel;
@property (nonatomic, strong) UILabel      *loopsLabel;
@property (nonatomic, strong) UILabel      *operateLabel;
@property (nonatomic, strong) TYTimerModel *model;
@property (nonatomic, strong) UILabel *appendixLabel;

@end

@implementation TPDeviceTimerListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.appendixLabel];
    }
    return self;
}

- (UILabel *)appendixLabel {
    if (!_appendixLabel) {
        _appendixLabel = [UILabel new];
        _appendixLabel.font = [UIFont systemFontOfSize:11];
        _appendixLabel.textColor = SUB_FONT_COLOR;
        _appendixLabel.frame = CGRectMake(18, 40, TY_ScreenWidth() - 30 - 50 - 10, 11);
        _appendixLabel.numberOfLines = 0;
    }
    return _appendixLabel;
}

+ (CGFloat)heightWithString:(NSString *)str {
    CGSize size = [str ty_boundingSizeWithFont:[UIFont systemFontOfSize:11] constrainedToSize:CGSizeMake(TY_ScreenWidth() - 30 - 50 - 10, 2000) lineBreakMode:NSLineBreakByCharWrapping];
    
    return size.height;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel ty_labelWithText:@"" font:[UIFont systemFontOfSize:16] textColor:TY_HexColor(0x303030) frame:CGRectMake(15, 14, TY_ScreenWidth() - 15 - 65 - 10, 22)];
    }
    return _titleLabel;
}

- (UILabel *)operateLabel {
    if (!_operateLabel) {
        _operateLabel = [UILabel ty_labelWithText:nil font:[UIFont systemFontOfSize:11] textColor:SUB_FONT_COLOR frame:CGRectMake(18, 56, TY_ScreenWidth() - 15 - 65 - 10, 11)];
        _operateLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _operateLabel;
}

- (UILabel *)loopsLabel {
    if (!_loopsLabel) {
        _loopsLabel = [UILabel ty_labelWithText:@"" font:[UIFont systemFontOfSize:11] textColor:TY_HexColor(0x626262) frame:CGRectMake(18, 40, TY_ScreenWidth() - 15 - 65 - 10, 11)];
    }
    return _loopsLabel;
}

- (void)setItem:(TYTimerModel *)model modeText:(NSString *)modeText {
    _model = model;
    
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    inputFormatter.dateFormat = @"HH:mm";
    inputFormatter.timeZone = [NSTimeZone timeZoneWithName:model.timezoneId];
    NSDate *inputDate = [inputFormatter dateFromString:model.time];
    [inputFormatter setDateFormat:@"hh:mm a"];
    NSString *time = [inputFormatter stringFromDate:inputDate];
    if (time.length <= 0) {
        time = model.time;
    }
    self.titleLabel.text = time;

    NSString *appendixStr = model.aliasName;
    NSString *loopStr = ([model.loops isEqualToString:TIMER_LOOPS_NEVER])?NSLocalizedString(@"clock_timer_once", @""):[TPDeviceTimerPeriodView repeatStringWeek:model.loops];
    if (appendixStr.length) {
        appendixStr = [appendixStr stringByAppendingString:[NSString stringWithFormat:@"\n%@",loopStr]];
    } else {
        appendixStr = loopStr;
    }
    if (modeText.length) {
        appendixStr = [appendixStr stringByAppendingString:[NSString stringWithFormat:@"\n%@",modeText]];
    }
    CGFloat height = [[self class] heightWithString:appendixStr];
    self.appendixLabel.frame = CGRectMake(18, 40, TY_ScreenWidth() - 30 - 50 - 10, height);
    self.appendixLabel.text = appendixStr;
    
    [self updateTextStatus];

}

- (void)updateTextStatus {

}

- (NSString *)accessibilityIdentifier {
    return @"schedule_change";
}

@end
