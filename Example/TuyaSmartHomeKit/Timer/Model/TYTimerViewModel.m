//
//  TYTimerViewModel.m
//  TuyaSmartHomeKit_Example
//
//  Created by Sakata Gintoki on 2019/11/11.
//  Copyright © 2019 xuchengcheng. All rights reserved.
//

#import "TYTimerViewModel.h"
#import "TPDeviceTimerPeriodView.h"
#import "NSTimeZone+TYTimer.h"

NSString *TimerTableCellTypePicker = @"TimerTableCellTypePicker";
NSString *TimerTableCellTypeRepeat = @"TimerTableCellTypeRepeat";
NSString *TimerTableCellTypeAlias = @"TimerTableCellTypeAlias";
NSString *TimerTableCellTypeNotification = @"TimerTableCellTypeNotification";
NSString *TimerTableCellTypeBlank = @"TimerTableCellTypeBlank";

@interface TYTimerViewModel ()
@property (nonatomic, copy) NSString                *devId;
@property (nonatomic, copy) NSString                *category;
@property (nonatomic, strong) NSDictionary          *propertyDic;
@property (nonatomic, strong) TYTimerModel          *timer;
@property (nonatomic, strong) NSArray               *commonArray;

@property (nonatomic, strong) TuyaSmartTimer        *timerService;
@property (nonatomic, assign) BOOL                  forUpdate;

@end

@implementation TYTimerViewModel

- (instancetype)initWithDevId:( NSString * _Nonnull)devId category:(NSString * _Nonnull)category propertyDic:(NSDictionary * _Nonnull)propertyDic timerModel:(nullable TYTimerModel *)timerModel {
    if (self = [super init]) {
        self.devId = devId;
        self.category = category;
        self.propertyDic = propertyDic;
        if (timerModel) {
            self.timer = timerModel;
            self.forUpdate = YES;
        } else {
            self.timer = [TYTimerModel new];
            NSMutableDictionary *dps = [NSMutableDictionary dictionary];
            for (TYDeviceProperty *property in self.propertyDic.allValues) {
                if ([property defaultKey] != [NSNull null]) {
                    [dps setObject:[property defaultKey] forKey:property.dpId];
                }
            }
            _timer.loops = TIMER_LOOPS_NEVER;
            _timer.dps = dps;
            TuyaSmartDeviceModel *model = [TuyaSmartDevice deviceWithDeviceId:self.devId].deviceModel;
            self.timer.timerId = model.timezoneId;
        }
        [self constructCommonArray];
    }
    return self;
}

- (void)constructCommonArray {
    TuyaSmartDeviceModel *model = [TuyaSmartDevice deviceWithDeviceId:self.devId].deviceModel;
    if ((model != nil && ![model.gwType isEqualToString:@"v"])) {
        self.commonArray = @[
            TimerTableCellTypePicker,
            TimerTableCellTypeBlank,
            TimerTableCellTypeRepeat,
            TimerTableCellTypeAlias,
            TimerTableCellTypeNotification,
            TimerTableCellTypeBlank
        ];
    } else {
        self.commonArray = @[
            TimerTableCellTypePicker,
            TimerTableCellTypeBlank,
            TimerTableCellTypeRepeat,
            TimerTableCellTypeAlias,
            TimerTableCellTypeBlank
        ];
    }
}

- (TYDeviceProperty *)devicePropertyAtIndex:(NSInteger)index {
    if (index < self.commonArray.count) {
        return nil;
    }
    NSInteger trueIndex = index - self.commonArray.count;
    TYDeviceProperty *property = nil;
    if (trueIndex < self.propertyDic.allValues.count) {
        property = [self.propertyDic.allValues objectAtIndex:trueIndex];
    }
    return property;
}

- (NSString *)dpValueAtIndex:(NSInteger)index {
    TYDeviceProperty * property = [self devicePropertyAtIndex:index];
    NSString *rightText = @"";
    if ([_timer.dps objectForKey:property.dpId] != nil) {
        rightText = [property valueForKey:[_timer.dps objectForKey:property.dpId]];
    } else {
        rightText = [property valueAtIndex:property.seledted];
    }
    return rightText;
}

- (NSString *)loopsString {
    NSString *result = self.timer.loops ? [TPDeviceTimerPeriodView repeatStringWeek:self.timer.loops] : @"Once";
    return result;
}

- (TY_Timer_Cell_Type_identifier)identifierWithIndex:(NSInteger)index {
    if (!self.commonArray.count || index > self.commonArray.count) {
        return @"nothing matched....";
    }
    return [self.commonArray objectAtIndex:index];
}

- (NSInteger)commonCount {
    return self.commonArray.count;
}

- (NSInteger)dpsCount {
    return self.propertyDic.allValues.count;
}

- (NSString *)aliasName {
    return @"Test info, we don't offer the edit function.";
    return self.timer.aliasName;
}

- (BOOL)isAppPush {
    return self.timer.isAppPush;
}

- (void)setAliasName:(NSString *)aliasName {
    if (![aliasName isKindOfClass:NSString.class]) {
        return;
    }
    self.timer.aliasName = aliasName;
}

- (void)setIsAppPush:(BOOL)isAppPush {
    self.timer.isAppPush = isAppPush;
}

- (NSString *)timezoneId {
    return self.timer.timezoneId;
}

- (NSString *)time {
    return self.timer.time;
}

- (void)setTime:(NSString *)time {
    self.timer.time = time;
}

- (NSString *)loops {
    return self.timer.loops;
}

- (void)setLoops:(NSString *)loops {
    self.timer.loops = loops;
}

- (NSDictionary *)dps {
    return self.timer.dps;
}

- (void)setDps:(NSDictionary *)dps {
    self.timer.dps = dps;
}

- (TuyaSmartTimer *)timerService {
    if (!_timerService) {
        _timerService = [TuyaSmartTimer new];
    }
    return _timerService;
}

- (void)commitSaveSuccess:(TYSuccessHandler)success failure:(TYFailureError)failure {
    
    if (self.forUpdate) {
        [self.timerService updateTimerWithTask:self.category loops:_timer.loops devId:self.devId timerId:_timer.timerId time:_timer.time dps:_timer.dps timeZone:TY_TimeDifferenceWithGMT(_timer.timezoneId) isAppPush:self.isAppPush aliasName:self.aliasName success:^{
            if (success) {
                success();
            }
        } failure:^(NSError *error) {
            if (failure) {
                failure(error);
            }
        }];
    } else {
        [self.timerService addTimerWithTask:self.category loops:_timer.loops devId:self.devId time:_timer.time dps:_timer.dps timeZone:TY_TimeDifferenceWithGMT(_timer.timezoneId) isAppPush:self.isAppPush aliasName:self.aliasName success:^{
            if (success) {
                success();
            }
        } failure:^(NSError *error) {
            if (failure) {
                failure(error);
            }
        }];
    }    
}
@end
