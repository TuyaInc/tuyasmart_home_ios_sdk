//
//  TYBLEDevice+Characteristic.h
//  Pods
//
//  Created by 黄凯 on 2018/4/16.
//

#import "TYBLEDevice.h"

@interface TYBLEDevice (Characteristic) <CBPeripheralDelegate>



/**
 发现服务和特征值，返回的特征值通过 `discoveredCharacteristicEvent` 进行传递
 */
- (void)discoveryServicesAndCharatceristics;

/**
 订阅特征值变化数据
 
 @param characteristic 特征值
 */
- (void)subscriptionCharacteristic:(nonnull CBCharacteristic *)characteristic;

/**
 取消订阅特征值变化数据
 
 @param characteristic 特征值
 */
- (void)unSubscriptionCharacteristic:(nonnull CBCharacteristic *)characteristic;

/**
 读取特征值数据
 
 @param characteristic 特征值
 */
- (void)readValueForCharacteristic:(nonnull CBCharacteristic *)characteristic;

/**
 向目标特征值写入数据

 @param data 要写入数据
 @param characteristic 目标特征值
 @param completion 写入结果
 */
- (void)writeData:(NSData *)data
forCharacteristic:(CBCharacteristic *)characteristic
       completion:(TYBLECompletion)completion;

@end
