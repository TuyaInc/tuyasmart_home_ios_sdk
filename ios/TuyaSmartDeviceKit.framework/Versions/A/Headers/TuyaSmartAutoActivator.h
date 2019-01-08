//
//  TuyaSmartAutoActivator.h
//  TuyaSmartDeviceKit
//
//  Created by 盖剑秋 on 2018/11/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class TuyaSmartAutoActivator;

@protocol TuyaSmartAutoActivatorDelegate <NSObject>

- (void)autoActivator:(TuyaSmartAutoActivator *)activator didReceiveAutoConfigDevice:(TuyaSmartDeviceModel *)deviceModel error:(NSError *)error;

@end

@interface TuyaSmartAutoActivator : NSObject

@property (nonatomic, weak) id<TuyaSmartAutoActivatorDelegate> delegate;

/**
 *  单例
 */
+ (instancetype)sharedInstance;


/**
 * 获取当前家庭下所有支持免密配网的设备列表
 *
 * @param homeId 当前家庭的id
 * @return 当前家庭所有支持免密配网的设备列表
 */
- (NSArray <TuyaSmartDeviceModel *> *)autoActiveSupportedDeviceListWithHomeId:(long long)homeId;


/**
 * 开始发现设备
 *
 * @param devIds 设备id的列表
 * @param timeout 超时时间
 * @param success 成功回调
 * @param failure 失败回调
 */
- (void)startDiscoverWithDevIds:(NSArray<NSString *> *)devIds
                        timeout:(NSTimeInterval)timeout
                        success:(TYSuccessHandler)success
                        failure:(TYFailureError)failure;


/**
 * 停止发现设备
 */
- (void)stopDiscover;


/**
 * 将设备绑定家庭
 *
 * @param homeId 家庭的id
 * @param devIds 设备id的列表
 * @param success 成功回调
 * @param failure 失败回调
 */
- (void)bindDeviceWithHomeId:(long long)homeId devIds:(NSArray <NSString *>*)devIds success:(TYSuccessHandler)success failure:(TYFailureError)failure;

@end

NS_ASSUME_NONNULL_END
