//
//  TYBLEPeripheral.h
//  TuyaSmartPublic
//
//  Created by 冯晓 on 16/8/2.
//  Copyright © 2016年 Tuya. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@class TYBLEService;

typedef void(^TYBLECentralPeripheralDiscoverServicesCallback)(NSArray *services, NSError *error);
typedef void(^TYBLECentralPeripheralRSSIValueCallback)(NSNumber *RSSI, NSError *error);


@interface TYBLEPeripheral : NSObject <CBPeripheralDelegate>

/**
 *  内部的cbPeripheral对象
 */
@property (strong, nonatomic, readonly) CBPeripheral *cbPeripheral;
/**
 *  service的UUID列表
 */
@property (strong, nonatomic, readonly) NSArray *services;
/**
 *  peripheral的UUID string
 */
@property (weak, nonatomic, readonly) NSString *UUIDString;

/**
 * Signal strength of peripheral
 */
@property (assign, nonatomic) NSInteger RSSI;

/**
 * The advertisement data that was tracked from peripheral
 */
@property (strong, nonatomic) NSDictionary *advertisingData;

/**
 *  flag of connection
 */
@property (nonatomic, assign) BOOL isConnected;
/**
 *  创建TYBLEPeripheral对象
 *
 *  @param p CBPeripheral对象
 *
 *  @return TYBLEPeripheral对象
 */
- (instancetype)initWithCBPeripheral:(CBPeripheral *)p;

/**
 *  扫描支持的所有service
 *
 *  @param block 回调
 */
- (void)discoverServicesWithCompletion:(TYBLECentralPeripheralDiscoverServicesCallback)block;

/**
 *  扫描特定UUID的service
 *
 *  @param serviceUUIDs service uuid
 *  @param block        回调
 */
- (void)discoverServices:(NSArray *)serviceUUIDs
              completion:(TYBLECentralPeripheralDiscoverServicesCallback)block;

/**
 *  读取RSSI值
 *
 *  @param aCallback 回调
 */
- (void)readRSSIValueCompletion:(TYBLECentralPeripheralRSSIValueCallback)aCallback;
/**
 *  根据UUID查找service
 *
 *  @param uuid 待查找的UUID
 *
 *  @return TYBLEService对象
 */
- (TYBLEService *)retrieveServiceByUUID:(NSString *)uuid;

@property (nonatomic, copy) void(^readyToSendWriteWithoutResponseBlock)(CBPeripheral *p);

@end


