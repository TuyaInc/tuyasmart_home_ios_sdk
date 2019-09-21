//
//  TYBLEAgent.h
//  TuyaSmartPublic
//
//  Created by 冯晓 on 16/8/2.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@class TYBLECentralManager;
@class TYBLEPeripheral;

typedef void(^TYBLEAgentCentralNotifyCallback)(NSData *data, NSError *error);
typedef void(^TYBLEAgentCentralReadCallback)(NSData *data, NSError *error);
typedef void(^TYBLEAgentCentralWriteCallback)(NSError *error);
typedef void(^TYBLEAgentCentralDiscoverCallback)(TYBLEPeripheral *peripheral, NSError *error);
typedef void(^TYBLEAgentCentralConnectionCallback)(TYBLEPeripheral *peripheral, NSError *error) ;

typedef NS_ENUM(int, TYBLEAgentRole)
{
    kTYBLEAgentDiscovery    = 0x01, // 扫描
    kTYBLEAgentSession      = 0x10, // 通信
    kTYBLEAgentBoth         = 0x11, // 扫描 + 通信
};


@protocol TYBLEAgent <NSObject>

@optional

- (void)onCentralDidDisconnecteFromPeripheral:(TYBLEPeripheral *)peripheral;
- (void)onCentralDidUpdateState:(BOOL)isPoweredOn;
- (void)onBLECentralDidUpdateState:(TYBLECentralManagerState)state;

@end


@interface TYBLEAgent : NSObject

@property (nonatomic, assign, readonly) TYBLEAgentRole role;

@property (nonatomic, copy, readonly) BOOL(^scanFilter)(NSDictionary *advertisementData, NSNumber *rssi);

/**
 *  蓝牙是否打开
 */
@property (nonatomic, assign, readonly) BOOL isPoweredOn;

/**
 添加代理
 
 @param delegate 代理
 */
- (void)addDelegate:(id<TYBLEAgent>)delegate;

/**
 移除代理
 
 @param delegate 代理
 */
- (void)removeDelegate:(id<TYBLEAgent>)delegate;


//- (instancetype)initWithType:(TYBLEAgentRole)role;

////////////////////////////////////////////////////////////////////////////////////
#pragma mark - central  methods

/**
 发现周围的BLE设备

 @param services 服务UUIDs
 @param options 扫描参数
 @param scanFilter 扫描过滤条件
 @param aCallback 扫描符合条件的设备回调
 */
- (void)discoverServiceUUID:(NSArray<NSString *> *)services
                    options:(NSDictionary<NSString *,id> *)options
                 scanFilter:(BOOL(^)(NSDictionary *advertisementData, NSNumber *rssi))scanFilter
                 completion:(TYBLEAgentCentralDiscoverCallback)aCallback;


/**
 发现周围的BLE设备

 @param scanFilter 扫描过滤条件
 @param aCallback 扫描符合条件的设备回调
 */
- (void)discoverWithScanFilter:(BOOL(^)(NSDictionary *advertisementData, NSNumber *rssi))scanFilter
                    completion:(TYBLEAgentCentralDiscoverCallback)aCallback;


/**
 *  停止扫描
 */
- (void)stopDiscovering;

/**
 *  链接发现的BLE设备
 *
 *  @param peripheral      待链接的BLE设备
 *  @param aCharacteristic 特征UUID
 *  @param aService        服务UUID
 *  @param aCallback       回调
 */
- (void)connectPeripheral:(TYBLEPeripheral *)peripheral
              CharactUUID:(NSString *)aCharacteristic
              serviceUUID:(NSString *)aService
               completion:(TYBLEAgentCentralConnectionCallback)aCallback;

/**
 *  链接发现的BLE设备
 *
 *  @param peripheral      待链接的BLE设备
 *  @param aCharacteristic 特征UUID
 *  @param aService        服务UUID
 *  @param timeout         超时
 *  @param aCallback       回调
 */
- (void)connectPeripheral:(TYBLEPeripheral *)peripheral
              CharactUUID:(NSString *)aCharacteristic
              serviceUUID:(NSString *)aService
                  timeout:(NSTimeInterval)timeout
               completion:(TYBLEAgentCentralConnectionCallback)aCallback;

/**
 *  断开连接的BLE设备
 *
 *  @param peripheral 连接的BLE设备
 */
- (void)disconnectPeripheral:(TYBLEPeripheral *)peripheral;

/**
 断开连接的BLE设备

 @param peripheral 连接的BLE设备
 @param timeout 断开超时
 */
- (void)disconnectPeripheral:(TYBLEPeripheral *)peripheral timeout:(NSTimeInterval)timeout;

/**
 断开链连接的BLE设备

 @param peripheral 链接的BLE设备
 @param aCallback 回调
 */
- (void)disconnectPeripheral:(TYBLEPeripheral *)peripheral
                  completion:(TYBLEAgentCentralConnectionCallback)aCallback
                     timeout:(NSTimeInterval)timeout;

/**
 *  向BLE设备写数据
 *
 *  @param aData           待写入的二进制数据
 *  @param aPeripheral     目标BLE设备
 *  @param aCharacteristic 设备特征UUID
 *  @param aService        服务UUID
 *  @param aCallback       回调
 */
- (void)writeData:(NSData *)aData
     toPeripheral:(TYBLEPeripheral *)aPeripheral
      charactUUID:(NSString *)aCharacteristic
      serviceUUID:(NSString *)aService
       completion:(TYBLEAgentCentralWriteCallback)aCallback;

/**
 *  从BLE设备读数据
 *
 *  @param aPeripheral     待读入的BLE设备
 *  @param aCharacteristic 目标设备特征UUID
 *  @param aService        服务UUID
 *  @param aCallback       回调
 */
- (void)readDataFromPeriphreral:(TYBLEPeripheral *)aPeripheral
                    CharactUUID:(NSString *)aCharacteristic
                    serviceUUID:(NSString *)aService
                     completion:(TYBLEAgentCentralReadCallback)aCallback;

/**
 *  接受BLE设备Push来的数据
 *
 *  @param b               传输数据的开关
 *  @param aPeripheral     链接的BLE设备
 *  @param aCharacteristic 目标设备特征UUID
 *  @param aService        服务UUID
 *  @param aCallback       回调
 */
- (void)notifyData:(BOOL)b
     FromPeriphral:(TYBLEPeripheral *)aPeripheral
       CharactUUID:(NSString *)aCharacteristic
       serviceUUID:(NSString *)aService
        completion:(TYBLEAgentCentralNotifyCallback)aCallback;


@end
