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

- (void)autoActivator:(TuyaSmartAutoActivator *)activator didReceiveAutoConfigDevice:(TuyaSmartDeviceModel *)deviceModel error:(NSError *)error;

@end

@interface TuyaSmartAutoActivator : NSObject

@property (nonatomic, weak) id<TuyaSmartAutoActivatorDelegate> delegate;

/**
 *  Single
 *  单例
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
- (NSArray <TuyaSmartDeviceModel *> *)autoActiveRouterDeviceListWithHomeId:(long long)homeId;

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
 * start discover gateway route
 * 开始发现网关路由器
 *
 * @param devIds    Device Id list
 * @param type      Type
 * @param timeout   Timeout, default 100 seconds
 * @param success   Success block
 * @param failure   Failure block
 */
- (void)startDiscoverRouterWithDevIds:(NSArray<NSString *> *)devIds
                                 type:(NSInteger)type
                              timeout:(NSTimeInterval)timeout
                              success:(TYSuccessHandler)success
                              failure:(TYFailureError)failure;

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
