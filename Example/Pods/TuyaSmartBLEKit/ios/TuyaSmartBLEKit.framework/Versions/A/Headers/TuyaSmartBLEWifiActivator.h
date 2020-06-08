//
//  TuyaSmartBleWifiActivator.h
//  TuyaSmartBLEKit
//
//  Created by 吴戈 on 2019/2/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class TuyaSmartBLEWifiActivator;

@protocol TuyaSmartBLEWifiActivatorDelegate <NSObject>

- (void)bleWifiActivator:(TuyaSmartBLEWifiActivator *)activator didReceiveBLEWifiConfigDevice:(TuyaSmartDeviceModel *)deviceModel error:(NSError *)error;

@end

@interface TuyaSmartBLEWifiActivator : NSObject

@property (nonatomic, weak) id<TuyaSmartBLEWifiActivatorDelegate> bleWifiDelegate;

@property (nonatomic, strong) NSString *deviceUUID;

/**
 *  单例
 */
+ (instancetype)sharedInstance;

/**
 *  connect ble wifi device
 *  连接蓝牙 Wifi 设备
 *
 *  @param UUID        蓝牙设备唯一标识
 *  @param homeId      当前家庭Id
 *  @param productId   产品Id
 *  @param ssid        路由器热点名称
 *  @param password    路由器热点密码
 *  @param timeout     轮询时间
 *  @param success     操作成功回调
 *  @param failure     操作失败回调
 */
- (void)startConfigBLEWifiDeviceWithUUID:(NSString *)UUID
                                  homeId:(long long)homeId
                               productId:(NSString *)productId
                                    ssid:(NSString *)ssid
                                password:(NSString *)password
                                timeout:(NSTimeInterval)timeout
                                 success:(TYSuccessHandler)success
                                 failure:(TYFailureHandler)failure;

/**
 * stop discover device
 * 停止发现设备
 */
- (void)stopDiscover;

@end

NS_ASSUME_NONNULL_END
