//
//  TuyaSmartPegasusActivator.h
//  TuyaSmartActivatorKit
//
//  Created by Hemin Won on 2020/7/24.
//
//  闪电配网⚡️

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class TuyaSmartPegasusActivator;
@protocol TuyaSmartPegasusActivatorDelegate <NSObject>

/// 闪电配网发现的设备 pegasus activator found device
/// @param activator 配网实例 activator instance
/// @param serverDeviceModel 发现设备 此时设备还无设备ID found device, not deviceID
/// @param deviceModel 发现设备 此时设备还无设备ID found device, not deviceID
/// @param error 错误信息 error
- (void)pegasusActivator:(TuyaSmartPegasusActivator *)activator serverDevice:(TuyaSmartDeviceModel *)serverDeviceModel didFoundDevice:(TuyaSmartDeviceModel *)deviceModel error:(NSError * __nullable)error;

/// 闪电配网已配网的设备
/// @param activator 配网实例 activator instance
/// @param deviceModel 已经配网的设备 receive device
/// @param error 错误信息 error
- (void)pegasusActivator:(TuyaSmartPegasusActivator *)activator didReceiveDevice:(TuyaSmartDeviceModel *)deviceModel error:(NSError * __nullable)error;

@end

@interface TuyaSmartPegasusActivator : NSObject

@property (nonatomic, weak) id<TuyaSmartPegasusActivatorDelegate> delegate;

/// 支持闪电配网的设备
/// @param homeID 家庭ID homeID
+ (NSArray <TuyaSmartDeviceModel *> *)pegasusDeviceListWithHomeID:(long long)homeID;

/// 闪电配网,发现待配网设备 Start Pegasus Activator discover pending device
/// @param devIDs  支持闪电配网的设备 Device ID list
/// @param serverTimeout 已配网设备 搜索待配网设备超时时间 timeout
/// @param clientTimeout 待配网设备 待配网设备被搜索到后未被添加到家庭的超时时间 timeout
/// @param success 成功回到 success
/// @param failure 失败回调 failure
- (void)startDiscoverWithDevIDs:(NSArray<NSString *> *)devIDs
                  serverTimeout:(NSTimeInterval)serverTimeout
                  clientTimeout:(NSTimeInterval)clientTimeout
                        success:(TYSuccessHandler)success
                        failure:(TYFailureError)failure;


/// 闪电配网, 已配网设备停止继续发现待配网设备 Start Pegasus Activator discover
/// @param devIDs 支持闪电配网的设备 Device ID list
/// @param success 成功回到 success
/// @param failure 失败回调 failure
- (void)stopDiscoverWithDevIDs:(NSArray<NSString *> *)devIDs
                        success:(TYSuccessHandler)success
                        failure:(TYFailureError)failure;

/// 闪电配网，对寻找到的待配网设备进行配网 add pending device
/// @param devIDs 支持闪电配网的设备 Device ID list
/// @param UUIDs 待配网设备的UUID列表
/// @param token 口令 token
/// @param timeout 超时时间 默认100s timeout default 100s
/// @param success 成功回到 success
/// @param failure 失败回调 failure
- (void)startActivatorWithDevIDs:(NSArray<NSString *> *)devIDs
                           UUIDs:(NSArray<NSString *> *)UUIDs
                           token:(NSString *)token
                         timeout:(NSTimeInterval)timeout
                         success:(TYSuccessHandler)success
                         failure:(TYFailureError)failure;

/// 闪电配网 取消寻找到的待配网设备的闪电配网 cancel pending device
/// @param devIDs 支持闪电配网的设备 Device ID list
/// @param UUIDs 待配网设备的UUID列表
/// @param success 成功回到 success
/// @param failure 失败回调 failure
- (void)cancelActivatorWithDevIDs:(NSArray<NSString *> *)devIDs
                            UUIDs:(NSArray<NSString *> *)UUIDs
                          success:(TYSuccessHandler)success
                          failure:(TYFailureError)failure;
@end

NS_ASSUME_NONNULL_END
