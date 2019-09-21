//
//  TYBLECentralManager+Connection.h
//  Pods-TYBluetooth_Example
//
//  Created by 黄凯 on 2019/4/19.
//

#import <Foundation/Foundation.h>
#import "TYBLECentralManager.h"
#import "TYBLECentralManagerProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@class TYBLEPeripheral;
@interface TYBLECentralManager (Connection)

/**
 添加连接代理

 @param delegate 代理
 */
- (void)addConnectionDelegate:(id<TYBLECentralManagerSessionDelegate>)delegate;

/**
 移除连接代理

 @param delegate 代理
 */
- (void)removeConnectionDelegate:(id<TYBLECentralManagerSessionDelegate>)delegate;

/**
 *  连接peripheral
 *
 *  @param peripheral 待连接的peripheral对象
 *  @param timeout 超时时间
 */
- (void)connectPeripheral:(TYBLEPeripheral *)peripheral timeout:(NSTimeInterval)timeout;

/**
 连接peripheral

 @param peripheral 待连接的peripheral对象
 @param options 连接选项
 @param timeout 超时时间
 */
- (void)connectPeripheral:(TYBLEPeripheral *)peripheral options:(nullable NSDictionary<NSString *, id> *)options timeout:(NSTimeInterval)timeout;

/**
 断开对peripheral的连接
 
 @param peripheral 连接的peripheral
 @param timeout 超时时间
 */
- (void)disconnectPeripheral:(TYBLEPeripheral *)peripheral timeout:(NSTimeInterval)timeout;

/**
 *  断开所有peripheral的链接
 */
- (void)disconnectAllPeripherals;

@end

NS_ASSUME_NONNULL_END
