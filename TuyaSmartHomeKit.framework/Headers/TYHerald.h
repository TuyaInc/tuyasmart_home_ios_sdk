//
//  TYHerald.h
//  Pods
//
//  Created by 黄凯 on 2018/4/14.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "TYEvent.h"
#import "TYResult.h"

typedef BOOL(^ScanFilter)(CBPeripheral *peripheral, NSDictionary<NSString *,id> *advertisementData, NSNumber *RSSI);

/**
 
 此类为蓝牙中心类
 
 功能：
 - 基础扫描
 - 设备连接
 - 设备断开
 
 */
@class TYBLEDevice;
@interface TYHerald : NSObject <TYDisposable>

+ (TYHerald *)sharedInstance;

/**
 系统蓝牙状态
 */
@property (nonatomic, assign) BOOL isPoweredOn;

/**
 蓝牙状态变化事件
 */
@property (nonatomic, strong, readonly) TYEvent<NSNumber *> *bluetoothStateEvent;

/**
 扫描结果事件
 */
@property (nonatomic, strong, readonly) TYEvent<TYBLEDevice *> *scanEvent;

/**
 扫描设备，设备的结果会通过 `scanEvent` 发送出来，需要事先对 event 进行监听
 
 @param serviceUUIDs 目标服务 ID
 @param scanFilter 过滤条件
 @param timeout 超时
 @param option 其他选项
 */
- (void)scanDeviceWithUUIDS:(NSArray<CBUUID *> *)serviceUUIDs
                     filter:(ScanFilter)scanFilter
                     timeout:(NSTimeInterval)timeout
                      option:(NSDictionary<NSString *, id> *)option;

/**
 停止扫描
 */
- (void)stopScan;

- (void)connect:(TYBLEDevice *)device
        timeout:(NSTimeInterval)timeout
     completion:(TYBLECompletion)completion
        options:(NSDictionary<NSString *, id> *)options;


- (void)connectPeripheral:(CBPeripheral *)peripheral
        timeout:(NSTimeInterval)timeout
     completion:(TYBLECompletion)completion
        options:(NSDictionary<NSString *, id> *)options;

- (void)cancelConnect:(TYBLEDevice *)device;
- (void)cancelConnectByPeripheral:(CBPeripheral *)peripheral;
- (NSArray<CBPeripheral *> *)retrieveConnectedPeripheralsWithServices:(NSArray<CBUUID *> *)uuids;

@end
