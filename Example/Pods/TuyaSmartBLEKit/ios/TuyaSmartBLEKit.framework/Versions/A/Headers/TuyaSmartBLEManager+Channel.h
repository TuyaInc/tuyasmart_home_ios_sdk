//
//  TuyaSmartBLEManager+Channel.h
//  TuyaSmartBLEKit
//
//  Created by 黄凯 on 2019/2/22.
//

#import <Foundation/Foundation.h>
#import "TuyaSmartBLEManager.h"

NS_ASSUME_NONNULL_BEGIN

/**
 ble 大数据通道，针对手环等需要短时间传输大量数据时使用
 */
typedef void (^TPBleResultBlock)(NSString *result);
@interface TuyaSmartBLEManager (Channel)

/**
 判断设备是否已连接
 check the device is connected.

 @param uuid 设备id
 @return connected
 */
- (BOOL)isBLEChannelDeviceConnect:(NSString *)uuid;


/**
 判断设备是否已连接
 check the device is connected.
 
 @param block 回调
 @param uuid 设备id
 */
- (void)setCompletionBlock:(TPBleResultBlock)block uuid:(NSString *)uuid;

/**
 APP 申请启动大数据通道
 
 @param uuid 设备id
 */
- (void)appApplyLaunch:(NSString *)uuid;

/**
 APP 强制传输终止
 
 @param uuid 设备id
 */
- (BOOL)appMandatoryTrans:(NSString *)uuid;

@end

NS_ASSUME_NONNULL_END
