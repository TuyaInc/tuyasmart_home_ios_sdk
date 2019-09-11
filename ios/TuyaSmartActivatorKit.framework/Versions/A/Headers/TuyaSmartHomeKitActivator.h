//
//  TuyaSmartHomeKitActivator.h
//  TuyaSmartDeviceKit
//
//  Created by Rui on 2019/1/28.
//

#import <Foundation/Foundation.h>
#import <TuyaSmartUtil/TuyaSmartUtil.h>
#import <TuyaSmartDeviceKit/TuyaSmartDeviceKit.h>
NS_ASSUME_NONNULL_BEGIN


@class TuyaSmartHomeKitActivator;
@protocol TuyaSmartHomeKitActivatorDelegate <NSObject>
/**
 Callback of Config Network Status Update
 配网状态更新的回调
 
 @param activator   instance
 @param deviceModel devicemodel
 @param error       error
 */
- (void)homeKitActivator:(TuyaSmartHomeKitActivator *)activator didReceiveHomeKitDevice:(TuyaSmartDeviceModel *)deviceModel error:(NSError *)error;
@end

@interface TuyaSmartHomeKitActivator : NSObject
/**
 *  单例
 */
+ (instancetype)sharedInstance;

@property (nonatomic, weak) id<TuyaSmartHomeKitActivatorDelegate> delegate;

/**
 * 获取HomeKit设备配网Token
 *
 * @param success 成功回调,返回token
 * @param failure 失败回调
 */

- (void)getTokenSuccess:(TYSuccessString)success failure:(TYFailureError)failure;

/**
 * 搜索HomeKit设备
 *
 * @param timeout 超时时间
 * @param token 配网token
 * @param success 成功回调
 * @param failure 失败回调
 */
- (void)startDiscoverHomeKitDeviceWithTimeout:(NSTimeInterval)timeout token:(NSString *)token success:(void (^)(TuyaSmartDeviceModel *))success failure:(TYFailureError)failure;



/**
 * 搜索HomeKit设备
 * HomeKit 配网
 *
 * @param timeout timeout
 * @param success Success block
 * @param failure Failure block
 */
- (void)startDiscoverHomeKitDeviceWithTimeout:(NSTimeInterval)timeout success:(TYSuccessString)success failure:(TYFailureError)failure;

/**
 * 将HomeKit设备绑定家庭
 *
 * @param homeId 家庭的id
 * @param devIds 设备id的列表
 * @param success 成功回调
 * @param failure 失败回调
 */
- (void)bindHomeKitDeviceWithHomeId:(long long)homeId devIds:(NSArray <NSString *>*)devIds success:(TYSuccessHandler)success failure:(TYFailureError)failure;

/**
 * 根据pid获取设备信息
 *
 * @param productId pid
 * @param success 成功回调
 * @param failure 失败回调
 */
- (void)getHomekitDeviceInfoWithProductId:(NSString *)productId success:(TYSuccessDict)success failure:(TYFailureError)failure;

/**
 *  停止发现设备
 */
- (void)stopDiscover;



@end

NS_ASSUME_NONNULL_END
