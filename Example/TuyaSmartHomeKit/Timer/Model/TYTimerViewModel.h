//
//  TYTimerViewModel.h
//  TuyaSmartHomeKit_Example
//
//  Created by Sakata Gintoki on 2019/11/11.
//  Copyright © 2019 xuchengcheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TYDeviceProperty.h"

NS_ASSUME_NONNULL_BEGIN

typedef NSString * TY_Timer_Cell_Type_identifier;

extern TY_Timer_Cell_Type_identifier TimerTableCellTypePicker;
extern TY_Timer_Cell_Type_identifier TimerTableCellTypeRepeat;
extern TY_Timer_Cell_Type_identifier TimerTableCellTypeAlias;
extern TY_Timer_Cell_Type_identifier TimerTableCellTypeNotification;
extern TY_Timer_Cell_Type_identifier TimerTableCellTypeBlank;

@interface TYTimerViewModel : NSObject

@property (nonatomic, copy, readonly) NSString *aliasName;
@property (nonatomic, assign, readonly) BOOL isAppPush;

- (instancetype)initWithDevId:( NSString * _Nonnull)devId category:(NSString * _Nonnull)category propertyDic:(NSDictionary * _Nonnull)propertyDic timerModel:(nullable TYTimerModel *)timerModel;

//accessable data
- (TY_Timer_Cell_Type_identifier)identifierWithIndex:(NSInteger)index;
- (NSInteger)commonCount;
- (NSInteger)dpsCount;
- (TYDeviceProperty *)devicePropertyAtIndex:(NSInteger)index;
- (NSString *)dpValueAtIndex:(NSInteger)index;
- (NSString *)loopsString;
- (NSString *)timezoneId;
- (NSString *)time;
- (NSDictionary *)dps;
- (NSString *)loops;

//parameter constructor
- (void)setAliasName:(NSString * _Nonnull)aliasName;
- (void)setIsAppPush:(BOOL)isAppPush;
- (void)setTime:(NSString *)time;
- (void)setLoops:(NSString *)loops;
- (void)setDps:(NSDictionary *)dps;

- (void)commitSaveSuccess:(TYSuccessHandler)success failure:(TYFailureError)failure;
@end

NS_ASSUME_NONNULL_END
