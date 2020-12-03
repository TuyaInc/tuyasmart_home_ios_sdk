//
//  TuyaSmartTimer.h
//  TuyaSmartKit
//
//  Created by remy on 16/4/28.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#ifndef TuyaSmart_TuyaSmartTimer
#define TuyaSmart_TuyaSmartTimer

#import <TuyaSmartUtil/TuyaSmartUtil.h>

@interface TYTimerModel : NSObject

@property (nonatomic, strong) NSString *timerId;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, assign) BOOL     status;
@property (nonatomic, strong) NSString *loops;
@property (nonatomic, strong) NSDictionary *dps;
@property (nonatomic, strong) NSString *timezoneId;
@property (nonatomic, copy)   NSString *aliasName;
@property (nonatomic, assign) BOOL     isAppPush;

@end

@interface TYTimerTaskModel : NSObject

@property (nonatomic, strong) NSString  *taskName;
@property (nonatomic, assign) NSInteger status;

@end


/// 定时相关功能
@interface TuyaSmartTimer : NSObject

/**
 *  获取定时任务状态
 *
 *  @param devId        设备Id
 *  @param success     Success block
 *  @param failure     Failure block
 */
- (void)getTimerTaskStatusWithDeviceId:(NSString *)devId
                               success:(void(^)(NSArray<TYTimerTaskModel *> *list))success
                               failure:(TYFailureError)failure;

/**
 *  获取设备所有定时任务下所有定时钟
 *
 *  @param devId        设备Id
 *  @param success     Success block
 *  @param failure     Failure block
 */
- (void)getAllTimerWithDeviceId:(NSString *)devId
                        success:(TYSuccessDict)success
                        failure:(TYFailureError)failure;

/**
 *  修改设备的时区
 *
 *  @param devId        设备Id
 *  @param timezoneId   时区Id，例如Asia/Shanghai
 *  @param success     Success block
 *  @param failure     Failure block
 */
- (void)updateTimerWithDeviceId:(NSString *)devId
                     timezoneId:(NSString *)timezoneId
                        success:(TYSuccessHandler)success
                        failure:(TYFailureError)failure;

/// 取消未完成的操作
- (void)cancelRequest;


#pragma mark - Timer


/**
*  增加定时任务（新版）
*
*  @param task 定时任务名称
*  @param loops  循环次数
*  @param bizId 业务 id，如果是设备，这里是设备 Id；如果是群组，这里是群组 id
*  @param bizType 业务类型，0:设备;  1:设备群组
*  @param time 定时任务下的定时钟
*  @param dps 命令字典
*  @param status 是否开启定时
*  @param isAppPush 是否开启推送
*  @param aliasName 备注
*  @param success success block
*  @param failure failure block
 */
- (void)addTimerWithTask:(NSString *)task
                   loops:(NSString *)loops
                   bizId:(NSString *)bizId
                 bizType:(NSUInteger)bizType
                    time:(NSString *)time
                     dps:(NSDictionary *)dps
                  status:(BOOL)status
               isAppPush:(BOOL)isAppPush
               aliasName:(NSString *)aliasName
                 success:(TYSuccessHandler)success
                 failure:(TYFailureError)failure;


/**
*  拉取对应 task 下的定时任务列表（新版）
*
*  @param task 定时任务名称
*  @param bizId 业务 id，如果是设备，这里是设备 Id；如果是群组，这里是群组 id
*  @param bizType 业务类型，0:设备;  1:设备群组
*  @param success success block
*  @param failure failure block
 */
- (void)getTimerListWithTask:(NSString *)task
                       bizId:(NSString *)bizId
                     bizType:(NSUInteger)bizType
                     success:(void(^)(NSArray<TYTimerModel *> *list))success
                     failure:(TYFailureError)failure;

/**
*  更新定时任务信息（新版）
*
*  @param timerId 定时钟 Id
*  @param loops  循环次数
*  @param bizId 业务 id，如果是设备，这里是设备 Id；如果是群组，这里是群组 id
*  @param bizType 业务类型，0:设备;  1:设备群组
*  @param time 定时任务下的定时钟
*  @param dps 命令字典
*  @param status 是否开启定时
*  @param isAppPush 是否开启推送
*  @param aliasName 备注
*  @param success success block
*  @param failure failure block
 */
- (void)updateTimerWithTimerId:(NSString *)timerId
                         loops:(NSString *)loops
                         bizId:(NSString *)bizId
                       bizType:(NSUInteger)bizType
                          time:(NSString *)time
                           dps:(NSDictionary *)dps
                        status:(BOOL)status
                     isAppPush:(BOOL)isAppPush
                     aliasName:(NSString *)aliasName
                       success:(TYSuccessHandler)success
                       failure:(TYFailureError)failure;

/**
*  更新定时任务状态（新版）
*
*  @param timerId 定时钟 Id
*  @param bizId 业务 id，如果是设备，这里是设备 Id；如果是群组，这里是群组 id
*  @param bizType 业务类型，0:设备;  1:设备群组
*  @param status 是否开启定时
*  @param success success block
*  @param failure failure block
 */
- (void)updateTimerStatusWithTimerId:(NSString *)timerId
                               bizId:(NSString *)bizId
                             bizType:(NSUInteger)bizType
                              status:(BOOL)status
                             success:(TYSuccessHandler)success
                             failure:(TYFailureError)failure;

/**
*  更新特定任务下的所有定时钟状态（新版）
*
*  @param task 定时任务名称
*  @param bizId 业务 id，如果是设备，这里是设备 Id；如果是群组，这里是群组 id
*  @param bizType 业务类型，0:设备;  1:设备群组
*  @param status 是否开启定时
*  @param success success block
*  @param failure failure block
 */
- (void)updateTimerStatusWithTask:(NSString *)task
                            bizId:(NSString *)bizId
                          bizType:(NSUInteger)bizType
                           status:(BOOL)status
                          success:(TYSuccessHandler)success
                          failure:(TYFailureError)failure;

/**
*  删除单个定时钟（新版）
*
*  @param timerId      定时钟Id
*  @param bizId 业务 id，如果是设备，这里是设备 Id；如果是群组，这里是群组 id
*  @param bizType 业务类型，0:设备;  1:设备群组
*  @param success     Success block
*  @param failure     Failure block
*/
- (void)removeTimerWithTimerId:(NSString *)timerId
                         bizId:(NSString *)bizId
                       bizType:(NSUInteger)bizType
                       success:(TYSuccessHandler)success
                       failure:(TYFailureError)failure;


/**
*  删除特定任务下的所有定时钟（新版）
*
*  @param task  定时任务名称
*  @param bizId 业务 id，如果是设备，这里是设备 Id；如果是群组，这里是群组 id
*  @param bizType 业务类型，0:设备;  1:设备群组
*  @param success     Success block
*  @param failure     Failure block
*/
- (void)removeTimerWithTask:(NSString *)task
                      bizId:(NSString *)bizId
                    bizType:(NSUInteger)bizType
                    success:(TYSuccessHandler)success
                    failure:(TYFailureError)failure;


/// 批量修改普通定时状态或删除定时器
///
/// @param timerIds 批量修改的定时 ids
/// @param bizId 业务 id，如果是设备，这里是设备 Id；如果是群组，这里是群组 id
/// @param bizType 业务类型，0:设备;  1:设备群组
/// @param updateType 更新类型 0: 关闭定时器 1: 开启定时器 2:删除定时器
/// @param success Success block
/// @param failure Failure block
- (void)updateTimerStatusWithTimerIds:(NSArray<NSString *> *)timerIds
                                bizId:(NSString *)bizId
                              bizType:(NSUInteger)bizType
                           updateType:(int)updateType
                              success:(TYSuccessHandler)success
                              failure:(TYFailureError)failure;


/// 修改定时任务下所有定时状态或删除定时器
///
/// @param task 定时任务名称
/// @param bizId 业务 id，如果是设备，这里是设备 Id；如果是群组，这里是群组 id
/// @param bizType 业务类型，0:设备;  1:设备群组
/// @param updateType 更新类型 0: 关闭定时器 1: 开启定时器 2:删除定时器
/// @param success Success block
/// @param failure Failure block
- (void)updateTimerTaskStatusWithTask:(NSString *)task
                                bizId:(NSString *)bizId
                              bizType:(NSUInteger)bizType
                           updateType:(NSUInteger)updateType
                              success:(TYSuccessHandler)success
                              failure:(TYFailureError)failure;

@end

#endif
