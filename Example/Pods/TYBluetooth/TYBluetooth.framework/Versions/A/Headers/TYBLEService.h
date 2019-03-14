//
//  TYBLEService.h
//  TuyaSmartPublic
//
//  Created by 冯晓 on 16/8/2.
//  Copyright © 2016年 Tuya. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@class TYBLECharacteristic;

typedef void(^TYBLECentralServiceDiscoverCharacteristcsCallback)(NSArray *characteristics, NSError *error);

@interface TYBLEService : NSObject

/**
 *  CBService对象
 */
@property (strong, nonatomic, readonly) CBService *cbService;

/**
 * 所在的CBPeripheral对象
 */
@property (assign, nonatomic, readonly) CBPeripheral *cbPeripheral;

/**
 * 自己的UUID
 */
@property (strong, nonatomic, readonly) NSString *UUIDString;

/**
 *  包含的characteristic列表
 */
@property (strong, nonatomic) NSArray *characteristics;

/**
 *  是否是device信息
 */
@property (assign, nonatomic) BOOL isDeviceInfo;


/**
 *  是否是timer信息
 */
@property (nonatomic, assign) BOOL isTimerInfo;



/**
 *  是否是battery信息
 */
@property (assign, nonatomic) BOOL isBatteryInfo;
    
    
/**
 *  构造TYBLESerice对象
 *
 *  @param aService CBservice对象
 *
 *  @return TYBLESerice对象
 */
- (instancetype)initWithService:(CBService *)aService;

/**
 *  查找所包含的characteristic列表
 *
 *  @param aCallback 完成的回调
 */
- (void)discoverCharacteristicsWithCompletion:(TYBLECentralServiceDiscoverCharacteristcsCallback)aCallback;



/**
 *  查找所包含的characteristic列表
 *
 *  同步方法
 *
 *  @return TYBLECharacteristic list
 */
- (NSArray <TYBLECharacteristic *> *)discoverCharacteristics;
    
/**
 *  根据UUID查找所包含的characteristic
 *
 *  @param aCallback 完成的回调
 */
- (void)discoverCharacteristicsWithUUIDs:(NSArray *)uuids
                              completion:(TYBLECentralServiceDiscoverCharacteristcsCallback)aCallback;

/**
 *  取消characteristic的operaion
 */
- (void)cancelCharacteristicOperations;
/**
 *  存储发现的characteristic
 *
 *  @param aCharacteristics list of CBCharacteristics
 *  @param aError           error
 */
- (void)handleDiscoveredCharacteristics:(NSArray *)aCharacteristics error:(NSError *)aError;
/**
 *  根据UUID查找characteristic
 *
 *  @param uuid 待查找的UUID
 *
 *  @return TYBLECharacteristic对象
 */
- (TYBLECharacteristic*)retrieveCharacteristicByUUID:(NSString *)uuid;

@end
