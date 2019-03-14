//
//  TYBLECharacteristicFactory.h
//  TuyaSmartPublic
//
//  Created by 冯晓 on 16/8/2.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

#import "TYBLECharacteristic.h"

@interface TYBLECharacteristicFactory : NSObject

+ (TYBLECharacteristic*)CharacteristicWithUUID:(NSString *)aUUID Property:(CBCharacteristicProperties)aProperty Data:(NSData *)aData;
+ (TYBLECharacteristic*)CharacteristicWithUUID:(NSString *)aUUID Property:(CBCharacteristicProperties)aProperty Data:(NSData *)aData Permission:(CBAttributePermissions) aPermission;

@end