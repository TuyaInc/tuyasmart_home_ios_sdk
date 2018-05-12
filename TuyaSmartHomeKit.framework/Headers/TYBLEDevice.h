//
//  TYBLEDevice.h
//  Pods
//
//  Created by 黄凯 on 2018/4/14.
//

#import <Foundation/Foundation.h>
#import "TYHerald.h"
#import "TYResult.h"

#define kNotificationDevicedidFailToConnect @"kNotificationDevicedidFailToConnect"
#define kNotificationDeviceDidDisconnect @"kNotificationDeviceDidDisconnect"

typedef NS_ENUM(NSUInteger, TYBLEDeviceConnectState) {
    TYBLEDeviceConnectStateBluetoothNotPowerOn, // 蓝牙未打开
    TYBLEDeviceConnectStateConnecting,          // 连接中...
    TYBLEDeviceConnectStateDisConnecting,       // 断开连接中...
    TYBLEDeviceConnectStateConnected,           // 已连接
    TYBLEDeviceConnectStateDisConnected,        // 已断开连接
    TYBLEDeviceConnectStateFailToConnect,       // 连接失败
    TYBLEDeviceConnectStateConnectTimeout,      // 连接超时
};

@protocol TYBLEDeviceConnection <NSObject>

/**
 连接操作结果处理
 
 @param state 连接结果
 */
- (void)handleConnection:(TYBLEDeviceConnectState)state;

/**
 断开操作结果处理
 
 @param state 连接结果
 */
- (void)handleDisconnection:(TYBLEDeviceConnectState)state;

@end

@class TYBLEDevice;
@protocol TYBLEDeviceDelegate <NSObject>
    
- (void)didFailToConnectDevice:(TYBLEDevice *)device error:(NSError *)error;
- (void)didDisconnectDevice:(TYBLEDevice *)device error:(NSError *)error;
    
@end

@interface TYBLEDevice : NSObject <TYDisposable>

- (instancetype)init NS_UNAVAILABLE;

/// 处理中心
@property (nonatomic, weak, readonly) TYHerald *herald;

/// 设备
@property (nonatomic, strong, readonly) CBPeripheral *peripheral;

/// 设备信号
@property (nonatomic, strong) NSNumber *RSSI;

/// 设备广播
@property (nonatomic, strong) NSDictionary<NSString *,id> *advertisement;

/// 连接状态
@property (nonatomic, assign, readonly) BOOL isConnected;

@property (nonatomic, copy) TYBLECompletion writeCompletion;

@property (nonatomic, strong) TYEvent<CBCharacteristic *> *updateValueEvent;
@property (nonatomic, strong) TYEvent<CBCharacteristic *> *discoverCharacteristicEvent;
    
@property (nonatomic, assign) id<TYBLEDeviceDelegate> delegate;

///// services
//@property (nonatomic, strong, readonly) NSArray *services;
//
///// charcteristics
//@property (nonatomic, strong, readonly) NSArray *charcteristics;

- (instancetype)initWithPeripheral:(CBPeripheral *)peripheral
                            herald:(TYHerald *)herald;


- (void)connect;

/**
 连接设备

 @param timeout 超时时间
 @param autoRelink 是否自动重连
 @param complteion 连接回调
 */
- (void)connectWithTimeout:(NSTimeInterval)timeout
                autoRelink:(BOOL)autoRelink
                completion:(TYBLECompletion)complteion;


/**
 断开设备
 */
- (void)cancelConnect;

@end
