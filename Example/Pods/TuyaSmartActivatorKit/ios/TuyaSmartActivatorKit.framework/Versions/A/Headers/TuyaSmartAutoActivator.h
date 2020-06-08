//
//  TuyaSmartAutoActivator.h
//  TuyaSmartDeviceKit
//
//  Created by 盖剑秋 on 2018/11/16.
//

#import <TuyaSmartDeviceKit/TuyaSmartDeviceKit.h>

NS_ASSUME_NONNULL_BEGIN

@class TuyaSmartAutoActivator;

@protocol TuyaSmartAutoActivatorDelegate <NSObject>


/**
 Callback of Config Network Status Update
 配网状态更新的回调

 @param activator   instance
 @param deviceModel devicemodel
 @param error       error
 */
- (void)autoActivator:(TuyaSmartAutoActivator *)activator didReceiveAutoConfigDevice:(TuyaSmartDeviceModel *)deviceModel error:(NSError *)error;

@end

@interface TuyaSmartAutoActivator : NSObject


/**
 delegate
 */
@property (nonatomic, weak) id<TuyaSmartAutoActivatorDelegate> delegate;

/**
 Single
 单例
 
 @return instance
 */
+ (instancetype)sharedInstance;


/**
 * Get a list of all devices that support auto atvice in the current home
 * 获取当前家庭下所有支持免密配网的设备列表
 *
 * @param homeId HomeId
 * @return 当前家庭所有支持免密配网的设备列表
 */
- (NSArray <TuyaSmartDeviceModel *> *)autoActiveSupportedDeviceListWithHomeId:(long long)homeId;

/**
 * Get a list of all devices that support route atvice in the current home
 * 获取当前家庭下所有网关路由器设备列表
 *
 * @param homeId 当前家庭的id
 * @return 当前家庭所有网关路由器设备列表
 */
- (NSArray <TuyaSmartDeviceModel *> *)autoActiveRouterDeviceListWithHomeId:(long long)homeId __deprecated_msg("Use -[TuyaSmartRouterActivator autoActiveRouterDeviceListWithHomeId:] instead.");

/**
 * start discover device
 * 开始发现设备
 *
 * @param devIds  Device Id list
 * @param timeout Timeout, default 100 seconds
 * @param success Success block
 * @param failure Failure block
 */
- (void)startDiscoverWithDevIds:(NSArray<NSString *> *)devIds
                        timeout:(NSTimeInterval)timeout
                        success:(TYSuccessHandler)success
                        failure:(TYFailureError)failure;

/**
 *  To obtain token (valid for 10 minutes)
 *  获取配网Token（有效期10分钟）
 *
 *  @param success Success block
 *  @param failure Failure block
 */
- (void)getTokenSuccess:(TYSuccessString)success
                failure:(TYFailureError)failure;

/**
 * start discover device
 * 开始发现设备
 *
 * @param devIds  Device Id list
 * @param token   Config Token
 * @param timeout Timeout, default 100 seconds
 * @param success Success block
 * @param failure Failure block
 */
- (void)startDiscoverWithDevIds:(NSArray<NSString *> *)devIds
                          token:(NSString *)token
                        timeout:(NSTimeInterval)timeout
                        success:(TYSuccessHandler)success
                        failure:(TYFailureError)failure;

/**
 * start discover gateway route
 * 开始发现网关路由器
 *
 * @param devIds    Device Id list
 * @param type      Type,  0 to start discover device
 * @param timeout   Timeout, default 100 seconds
 * @param success   Success block
 * @param failure   Failure block
 */
- (void)startDiscoverRouterWithDevIds:(NSArray<NSString *> *)devIds
                                 type:(NSInteger)type
                              timeout:(NSTimeInterval)timeout
                              success:(TYSuccessHandler)success
                              failure:(TYFailureError)failure __deprecated_msg("Use -[TuyaSmartRouterActivator startDiscoverRouterWithDevIds:type:timeout:success:failure:] instead.");

/**
 * stop discover
 * 停止发现设备
 */
- (void)stopDiscover;


/**
 * Binding device to the home
 * 将设备绑定家庭
 *
 * @param homeId  HomeId
 * @param devIds  Deivce Id list
 * @param success Success block
 * @param failure Failure block
 */
- (void)bindDeviceWithHomeId:(long long)homeId devIds:(NSArray <NSString *>*)devIds success:(TYSuccessHandler)success failure:(TYFailureError)failure;


@end

NS_ASSUME_NONNULL_END
