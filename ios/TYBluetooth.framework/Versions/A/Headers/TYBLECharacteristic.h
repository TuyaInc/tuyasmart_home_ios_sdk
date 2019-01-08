//
//  TYBLECharacteristic.h
//  TuyaSmartPublic
//
//  Created by 冯晓 on 16/8/2.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>



typedef void (^TYBLECentralCharacteristicReadCallback)  (NSData*data, NSError *error);
typedef void (^TYBLECentralCharacteristicNotifyCallback)(NSData* data, NSError *error);
typedef void (^TYBLECentralCharacteristicWriteCallback) (NSError *error);




@interface TYBLECharacteristic : NSObject

/**
 * 内部CBCharacteristic对象
 */
@property (strong, nonatomic, readonly) CBCharacteristic *cbCharacteristic;

/**
 * UUID字符串
 */
@property (weak, nonatomic, readonly) NSString *UUIDString;

/**
 *  Characteristic的特征值
 */
@property (nonatomic, assign) CBCharacteristicProperties properties;

@property (nonatomic, copy  ) TYBLECentralCharacteristicNotifyCallback notifyCallback;
@property (nonatomic, copy  ) TYBLECentralCharacteristicReadCallback readCallback;
@property (nonatomic, copy  ) TYBLECentralCharacteristicWriteCallback writeCallback;

/**
 *  创建TYBLECharacteristic对象
 *
 *  @param aCharacteristic CBCharacteristic对象
 *
 *  @return TYBLECharacteristic
 */
- (instancetype)initWithCharacteristic:(CBCharacteristic *)aCharacteristic;


/**
 *  通知Peripheral向Central push数据
 *
 *  @param notifyValue 开关标志位
 *  @param aCallback   完成的回调
 */
- (void)notifyValue:(BOOL)notifyValue
     Withcompletion:(TYBLECentralCharacteristicNotifyCallback)aCallback;

/**
 *  向Peripheral写数据
 *
 *  @param data      待写的二进制流
 *  @param aCallback 完成的回调
 */
- (void)writeData:(NSData *)data
   Withcompletion:(TYBLECentralCharacteristicWriteCallback)aCallback;

/**
 *  向Peripheral写字节
 *
 *  @param aByte     待写入的字节
 *  @param aCallback 完成的回调
 */
- (void)writeByte:(int8_t)aByte
   Withcompletion:(TYBLECentralCharacteristicWriteCallback)aCallback;

/**
 *  向Peripheral读数据
 *
 *  @param aCallback 完成的回调
 */
- (void)readValueWithBlock:(TYBLECentralCharacteristicReadCallback)aCallback;


@end

@interface TYBLECharacteristic(ToolMethods)

// ----- Used for input events -----/

- (void)handleSetNotified:(NSData*)data WithError:(NSError *)anError;

- (void)handleReadValue:(NSData *)aValue error:(NSError *)anError;

- (void)handleWrittenValueWithError:(NSError *)anError;


@end



