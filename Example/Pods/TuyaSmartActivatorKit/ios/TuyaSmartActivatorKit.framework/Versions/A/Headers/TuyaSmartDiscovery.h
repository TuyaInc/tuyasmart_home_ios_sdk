//
//  TuyaSmartDiscovery.h
//  TuyaSmartActivatorKit
//
//  Created by huangjj on 2019/7/1.
//

#import <TuyaSmartDeviceKit/TuyaSmartDeviceKit.h>

NS_ASSUME_NONNULL_BEGIN

@class TuyaSmartDiscovery;

@protocol TuyaSmartDiscoveryDelegate<NSObject>

@required

/**
 Callback of Device Discovery
 设备搜索回调
 
 @param discovery   instance
 @param deviceModel deviceModel
 @param error       error
 */
- (void)discovery:(TuyaSmartDiscovery *)discovery didDiscoveryDevice:(TuyaSmartDeviceModel *)deviceModel error:(NSError *)error;

@end

@interface TuyaSmartDiscovery : NSObject

@property (nonatomic, weak) id<TuyaSmartDiscoveryDelegate> delegate;

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
 * @param ssid      Name of route 路由器热点名称
 * @param password  Password of route 路由器热点密码
 * @param timeout   Timeout, default 100 seconds
 * @param success   Success block
 * @param failure   Failure block
 */
- (void)startDiscoveryWithSsid:(NSString *)ssid
                     password:(NSString *)password
                      timeout:(NSTimeInterval)timeout
                      success:(TYSuccessHandler)success
                      failure:(TYFailureError)failure;


/**
 * start discover device with token
 * 开始发现设备
 *
 * @param ssid      Name of route 路由器热点名称
 * @param password  Password of route 路由器热点密码
 * @param token     Config token 配网 token
 * @param timeout   Timeout, default 100 seconds
 * @param success   Success block
 * @param failure   Failure block
 */
- (void)startDiscoveryWithSsid:(NSString *)ssid
                     password:(NSString *)password
                         token:(NSString *)token
                      timeout:(NSTimeInterval)timeout
                      success:(TYSuccessHandler)success
                      failure:(TYFailureError)failure;




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


/**
 *  stop Discovery
 *  停止发现
 */
- (void)stopDiscovery;

@end

NS_ASSUME_NONNULL_END
