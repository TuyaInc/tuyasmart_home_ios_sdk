//
//  TuyaSmartTimer+TYDeprecatedApi.h
//  TuyaSmartTimerKit
//
//  Created by huangkai on 2020/5/25.
//

#ifndef TuyaSmartTimer_TYDeprecatedApi_h
#define TuyaSmartTimer_TYDeprecatedApi_h

#import "TuyaSmartTimer.h"

@interface TuyaSmartTimer (TYDeprecatedApi)

/**
 *  增加定时任务
 *
 *  @param task         定时任务名称
 *  @param loops        循环次数
 *  @param devId        设备Id
 *  @param time         定时任务下的定时钟
 *  @param dps          命令字典
 *  @param timeZone     设备的时区 +08:00，如果没有取手机时区
 *  @param success     Success block
 *  @param failure     Failure block
 */
- (void)addTimerWithTask:(NSString *)task
                   loops:(NSString *)loops
                   devId:(NSString *)devId
                    time:(NSString *)time
                     dps:(NSDictionary *)dps
                timeZone:(NSString *)timeZone
                 success:(TYSuccessHandler)success
                 failure:(TYFailureError)failure __deprecated_msg("This method is deprecated, Use [TuyaSmartTimer addTimerWithTask:loops:bizId:bizType:time:dps:status:isAppPush:aliasName:success:failure:] instead");

/**
 *  增加定时任务
 *
 *  @param task         定时任务名称
 *  @param loops        循环次数
 *  @param devId        设备Id
 *  @param time         定时任务下的定时钟
 *  @param dps          命令字典
 *  @param timeZone     设备的时区 +08:00，如果没有取手机时区
 *  @param isAppPush    是否开启推送
 *  @param aliasName    备注
 *  @param success     Success block
 *  @param failure     Failure block
 */
- (void)addTimerWithTask:(NSString *)task
                   loops:(NSString *)loops
                   devId:(NSString *)devId
                    time:(NSString *)time
                     dps:(NSDictionary *)dps
                timeZone:(NSString *)timeZone
               isAppPush:(BOOL)isAppPush
               aliasName:(NSString *)aliasName
                 success:(TYSuccessHandler)success
                 failure:(TYFailureError)failure __deprecated_msg("This method is deprecated, Use [TuyaSmartTimer addTimerWithTask:loops:bizId:bizType:time:dps:status:isAppPush:aliasName:success:failure:] instead");


/**
 *  更新定时任务状态
 *
 *  @param task         定时任务名称
 *  @param devId        设备Id，只支持单个wifi设备
 *  @param status       定时组状态
 *  @param success     Success block
 *  @param failure     Failure block
 */
- (void)updateTimerTaskStatusWithTask:(NSString *)task
                                devId:(NSString *)devId
                               status:(NSInteger)status
                              success:(TYSuccessHandler)success
                              failure:(TYFailureError)failure __deprecated_msg("This method is deprecated, Use [TuyaSmartTimer updateTimerStatusWithTask:bizId:bizType:status:success:failure:] instead");


/**
 *  更新定时钟状态
 *
 *  @param task         定时任务名称
 *  @param devId        设备Id
 *  @param timerId      定时钟Id
 *  @param status       定时钟状态
 *  @param success     Success block
 *  @param failure     Failure block
 */
- (void)updateTimerStatusWithTask:(NSString *)task
                            devId:(NSString *)devId
                          timerId:(NSString *)timerId
                           status:(NSInteger)status
                          success:(TYSuccessHandler)success
                          failure:(TYFailureError)failure __deprecated_msg("This method is deprecated, Use [TuyaSmartTimer updateTimerStatusWithTimerId:bizId:bizType:status:success:failure:] instead");


/**
 *  删除定时钟
 *
 *  @param task         定时任务名称
 *  @param devId        设备Id
 *  @param timerId      定时钟Id
 *  @param success     Success block
 *  @param failure     Failure block
 */
- (void)removeTimerWithTask:(NSString *)task
                      devId:(NSString *)devId
                    timerId:(NSString *)timerId
                    success:(TYSuccessHandler)success
                    failure:(TYFailureError)failure __deprecated_msg("This method is deprecated, Use [TuyaSmartTimer removeTimerWithTimerId:bizId:bizType:success:failure:] instead");


/**
 *  更新定时钟
 *
 *  @param task         定时任务名称
 *  @param loops        循环次数
 *  @param devId   ·     设备Id
 *  @param timerId      定时钟Id
 *  @param time         定时任务下的定时钟
 *  @param dps          命令字典
 *  @param timeZone     时区 +08:00
 *  @param success     Success block
 *  @param failure     Failure block
 */
- (void)updateTimerWithTask:(NSString *)task
                      loops:(NSString *)loops
                      devId:(NSString *)devId
                    timerId:(NSString *)timerId
                       time:(NSString *)time
                        dps:(NSDictionary *)dps
                   timeZone:(NSString *)timeZone
                    success:(TYSuccessHandler)success
                    failure:(TYFailureError)failure __deprecated_msg("This method is deprecated, Use [TuyaSmartTimer updateTimerWithTimerId:loops:bizId:bizType:time:dps:isAppPush:aliasName:success:failure:] instead");

/**
 *  更新定时钟
 *
 *  @param task         定时任务名称
 *  @param loops        循环次数
 *  @param devId   ·     设备Id
 *  @param timerId      定时钟Id
 *  @param time         定时任务下的定时钟
 *  @param dps          命令字典
 *  @param timeZone     时区 +08:00
 *  @param isAppPush    是否开启推送
 *  @param aliasName    备注
 *  @param success     Success block
 *  @param failure     Failure block
 */
- (void)updateTimerWithTask:(NSString *)task
                      loops:(NSString *)loops
                      devId:(NSString *)devId
                    timerId:(NSString *)timerId
                       time:(NSString *)time
                        dps:(NSDictionary *)dps
                   timeZone:(NSString *)timeZone
                  isAppPush:(BOOL)isAppPush
                  aliasName:(NSString *)aliasName
                    success:(TYSuccessHandler)success
                    failure:(TYFailureError)failure __deprecated_msg("This method is deprecated, Use [TuyaSmartTimer updateTimerWithTimerId:loops:bizId:bizType:time:dps:isAppPush:aliasName:success:failure:] instead");


/**
 *  获取定时任务下所有定时钟
 *
 *  @param task         定时任务名称
 *  @param devId        设备Id
 *  @param success     Success block
 *  @param failure     Failure block
 */
- (void)getTimerWithTask:(NSString *)task
                   devId:(NSString *)devId
                 success:(void(^)(NSArray<TYTimerModel *> *list))success
                 failure:(TYFailureError)failure __deprecated_msg("This method is deprecated, Use [TuyaSmartTimer getTimerListWithTask:bizId:bizType:success:failure:] instead");


@end


#endif /* TuyaSmartTimer_TYDeprecatedApi_h */
