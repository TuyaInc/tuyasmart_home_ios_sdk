//
//  TuyaSmartSingleTransfer.h
//  TuyaSmartPublic
//
//  Created by 黄凯 on 2018/10/24.
//  Copyright © 2018 Tuya. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, TuyaSmartTransferState) {
    TuyaSmartTransferConnected = 1, // Connected
    TuyaSmartTransferDisconnected, // Disconnected
};

@class TuyaSmartSingleTransfer;
@protocol TuyaSmartTransferDelegate<NSObject>

/**
 When the connection state changes, the delegate will execute.
 数据通道连接情况变化
 当通道连接、断开连接等都会通过此方法回调，
 
 @param transfer transfer
 @param state TuyaSmartTransferState
 */
- (void)transfer:(TuyaSmartSingleTransfer *)transfer didUpdateConnectState:(TuyaSmartTransferState)state;


/**
 When received device data, the delegate will execute.
 数据通道收到新数据
 
 @param transfer transfer
 @param devId Device Id
 @param data Received Data
 */
- (void)transfer:(TuyaSmartSingleTransfer *)transfer didReciveDataWithDevId:(NSString *)devId data:(NSData *)data;

@end

__deprecated_msg("The channel already merged. We will provide new way to support it.") @interface TuyaSmartSingleTransfer : NSObject

@property (nonatomic, weak) id<TuyaSmartTransferDelegate> delegate;

#if TARGET_OS_IOS

/**
 Start Connect
 开始连接通道
 */
- (void)startConnect;

/**
 The connection state
 通道连接状态
 
 @return Connection Result
 */
- (BOOL)isConnected;

/**
 Close
 关闭通道
 ！！！（通道合并的缘故，将不会进行关闭，因为此操作会影响正常的设备订阅流程）
 */
- (void)close __deprecated_msg("will remove it");;

/**
 Subscribe device
 订阅设备
 
 @param devId Device Id
 */
- (void)subscribeDeviceWithDevId:(NSString *)devId;

/**
 Unsubscribe device
 取消订阅设备
 
 @param devId Device Id
 */
- (void)unsubscribeDeviceWithDevId:(NSString *)devId;

#endif

@end

