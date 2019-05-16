//
//  TuyaSmartHomeKitActivator.h
//  TuyaSmartDeviceKit
//
//  Created by Rui on 2019/1/28.
//

#import <TuyaSmartDeviceKit/TuyaSmartDeviceKit.h>

NS_ASSUME_NONNULL_BEGIN

@class TuyaSmartHomeKitActivator;

@protocol TuyaSmartHomeKitActivatorDelegate <NSObject>

- (void)homeKitActivator:(TuyaSmartHomeKitActivator *)activator didReceiveHomeKitDevice:(TuyaSmartDeviceModel *)deviceModel error:(NSError *)error;

@end

@interface TuyaSmartHomeKitActivator : NSObject

@property (nonatomic, weak) id<TuyaSmartHomeKitActivatorDelegate> delegate;
/**
 *  Single
 *  单例
 */
+ (instancetype)sharedInstance;


/**
 * start discvoer
 * HomeKit 配网
 *
 * @param timeout timeout
 * @param success Success block
 * @param failure Failure block
 */
- (void)startDiscoverHomeKitDeviceWithTimeout:(NSTimeInterval)timeout success:(TYSuccessString)success failure:(TYFailureError)failure;

/**
 * Binding device to the home
 * 将HomeKit 设备绑定家庭
 *
 * @param homeId  Home Id
 * @param devIds  Device Id list
 * @param success Success block
 * @param failure Failure block
 */
- (void)bindHomeKitDeviceWithHomeId:(long long)homeId devIds:(NSArray <NSString *>*)devIds success:(TYSuccessHandler)success failure:(TYFailureError)failure;

/**
 * stop discover
 * 停止发现设备
 */
- (void)stopDiscover;

@end

NS_ASSUME_NONNULL_END
