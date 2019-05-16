//
//  TYBLECentralManager.h
//  TuyaSmartPublic
//
//  Created by 冯晓 on 16/8/2.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "TYEvent.h"

@class TYBLEPeripheral;

typedef void (^TYBLECentralDiscoverCallback)(NSArray *peripherals,NSError *error);
typedef void (^TYBLECentralConnection)(TYBLEPeripheral *peripheral,NSError *error);
typedef void (^TYBLECentralDisconnection)(TYBLEPeripheral *peripheral,NSError *error);

typedef BOOL (^TYBLECentralDiscoverFilter)(NSDictionary *advertisementData, NSNumber *rssi);

@interface TYBLECentralManager : NSObject<CBCentralManagerDelegate>

+ (instancetype)manager;

/**
 *  CBCentralManager对象
 */
@property (nonatomic, strong, readonly) CBCentralManager *cbManager;

/**
 *  被连接的peripheral列表
 */
@property (nonatomic, strong, readonly) NSArray *connectedPeripherals;

/**
 *  发现的TYBLEPeripheral
 */
@property (nonatomic, strong, readonly) NSArray *discoveredPeripherals;

/**
 *  扫描的过滤条件
 */
@property (nonatomic, strong) NSMutableDictionary<NSString *, TYBLECentralDiscoverFilter> *discoverFilters;

/**
 *  蓝牙是否打开
 */
@property (nonatomic, assign, readonly) BOOL isPoweredOn;

/**
 扫描事件
 */
@property (nonatomic, strong, readonly) TYEvent<TYBLEPeripheral *> *scanEvent;

/**
 蓝牙状态变化事件
 */
@property (nonatomic, strong, readonly) TYEvent<NSNumber *> *bluetoothStateEvent;

/**
 * callbacks
 */
@property (nonatomic, strong) NSMutableDictionary<NSString *, TYBLECentralConnection> *connectionCallbacks;
@property (nonatomic, strong) NSMutableDictionary<NSString *, TYBLECentralDisconnection> *disconnectionCallbacks;

/**
 全局断开事件，注册后一旦有设备断开，都会收到此回调
 */
@property (nonatomic, copy) TYBLECentralDisconnection disconnectionCallback;

/**
 *  扫描周围所有BLE设备
 *
 *  @param block 完成的回调
 *  @param timeout 超时时间
 */
- (void)scanForPeripheralsWithCompletionBlock:(TYBLECentralDiscoverCallback)block
                                      timeout:(NSTimeInterval)timeout;

/**
 *  扫描特定UUID设备
 *
 *  @param UUID 带扫描的UUID
 *  @param timeout 超时时间
 */
- (void)scanForPeripheral:(NSArray *)UUID
                  timeout:(NSTimeInterval)timeout;

/**
 *  停止扫描
 */
- (void)stopScan;

/**
 *  连接peripheral
 *
 *  @param peripheral 待连接的peripheral对象
 *  @param block 完成的回调
 *  @param timeout 超时时间
 */
- (void)connectPeripheral:(TYBLEPeripheral *)peripheral
      withCompletionBlock:(TYBLECentralConnection)block
                  timeout:(NSTimeInterval)timeout;

/**
 断开对peripheral的连接

 @param peripheral 连接的peripheral
 @param block 完成的回调
 @param timeout 超时时间
 */
- (void)disconnectPeripheral:(TYBLEPeripheral *)peripheral
         withCompletionBlock:(TYBLECentralDisconnection)block
                     timeout:(NSTimeInterval)timeout;

/**
 *  断开所有peripheral的链接
 */
- (void)disconnectAllPeripherals;

@end
