//
//  TYBLECentralManager+Discovery.h
//  Pods-TYBluetooth_Example
//
//  Created by 黄凯 on 2019/4/19.
//

#import "TYBLECentralManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface TYBLECentralManager (Discovery)

/**
 扫描到的设备
 */
@property (nonatomic, strong, readonly) NSArray<TYBLEPeripheral *> *discoveredDevices;

@property (nonatomic, assign) BOOL shouldAutoDiscoveryWhenCenteralPoweredOn;

/**
 添加发现代理

 @param delegate 发现代理
 */
- (void)addDiscoveryDelegate:(id<TYBLECentralManagerDiscoveryDelegate>)delegate;

/**
 移除发现代理

 @param delegate 发现代理
 */
- (void)removeDiscoveryDelegate:(id<TYBLECentralManagerDiscoveryDelegate>)delegate;

/**
 *  扫描周围所有BLE设备
 *
 *  @param timeout 超时时间
 */
- (void)scanForPeripheralsWithServices:(nullable NSArray<CBUUID *> *)serviceUUIDs options:(nullable NSDictionary<NSString *, id> *)options timeout:(NSTimeInterval)timeout;

/**
 *  扫描周围所有BLE设备
 *
 *  @param timeout 超时时间
 */
- (void)scanForPeripherals:(NSTimeInterval)timeout;

- (NSArray<CBPeripheral *> *)retrievePeripheralsWithIdentifiers:(NSArray<NSUUID *> *)identifiers;
- (NSArray<CBPeripheral *> *)retrieveConnectedPeripheralsWithServices:(NSArray<CBUUID *> *)serviceUUIDs;

/**
 *  停止扫描
 */
- (void)stopScan;

/**
 清理扫描的缓存
 */
- (void)cleanScanedCache;

@end

NS_ASSUME_NONNULL_END
