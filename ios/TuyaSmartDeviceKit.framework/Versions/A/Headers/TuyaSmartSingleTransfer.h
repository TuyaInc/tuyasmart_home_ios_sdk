//
//  TuyaSmartSingleTransfer.h
//  TuyaSmartPublic
//
//  Created by 黄凯 on 2018/10/24.
//  Copyright © 2018 Tuya. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, TuyaSmartTransferState) {
    TuyaSmartTransferConnected = 1, // 已连接
    TuyaSmartTransferDisconnected, // 已断开连接
};

@class TuyaSmartSingleTransfer;
@protocol TuyaSmartTransferDelegate<NSObject>

/**
 数据通道连接情况变化
 
 当通道连接、断开连接等都会通过此方法回调，
 
 @param transfer transfer
 @param state 状态变化，`TuyaSmartTransferState`
 */
- (void)transfer:(TuyaSmartSingleTransfer *)transfer didUpdateConnectState:(TuyaSmartTransferState)state;


/**
 数据通道收到新数据
 
 @param transfer transfer
 @param devId 对应数据所属设备 Id
 @param data 收到的数据
 */
- (void)transfer:(TuyaSmartSingleTransfer *)transfer didReciveDataWithDevId:(NSString *)devId data:(NSData *)data;

@end

@interface TuyaSmartSingleTransfer : NSObject

@property (nonatomic, weak) id<TuyaSmartTransferDelegate> delegate;

/**
 开始连接通道
 */
- (void)startConnect;

/**
 通道连接状态
 
 @return 连接结果
 */
- (BOOL)isConnected;

/**
 关闭通道
 */
- (void)close;

/**
 订阅设备
 
 @param devId 设备 Id
 */
- (void)subscribeDeviceWithDevId:(NSString *)devId;

/**
 取消订阅设备
 
 @param devId 设备 Id
 */
- (void)unsubscribeDeviceWithDevId:(NSString *)devId;

@end

