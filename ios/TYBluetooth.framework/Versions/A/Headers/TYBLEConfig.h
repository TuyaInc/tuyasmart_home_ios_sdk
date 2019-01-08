//
//  TYBLEConfig.h
//  TuyaSmartPublic
//
//  Created by 冯晓 on 16/8/2.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#ifndef TYBLEConfig_h
#define TYBLEConfig_h

#import <CoreBluetooth/CoreBluetooth.h>
#if __has_include(<TYBluetooth/TYBLEConfig.h>)

#import <TYBluetooth/TYBLECentralManager.h>
#import <TYBluetooth/TYBLEPeripheral.h>
#import <TYBluetooth/TYBLECentral.h>
#import <TYBluetooth/TYBLEPeripheralManager.h>
#import <TYBluetooth/TYBLEService.h>
#import <TYBluetooth/TYBLECharacteristic.h>
#import <TYBluetooth/TYBLECharacteristicFactory.h>
#import <TYBluetooth/TYBLEServiceFactory.h>
#import <TYBluetooth/CBUUID+TYCategory.h>
#import <TYBluetooth/TYBLEAgent.h>
#import <TYBluetooth/NSNumber+Characteristic.h>

#else

#import "TYBLECentralManager.h"
#import "TYBLEPeripheral.h"
#import "TYBLECentral.h"
#import "TYBLEPeripheralManager.h"
#import "TYBLEService.h"
#import "TYBLECharacteristic.h"
#import "TYBLECharacteristicFactory.h"
#import "TYBLEServiceFactory.h"
#import "CBUUID+TYCategory.h"
#import "TYBLEAgent.h"
#import "NSNumber+Characteristic.h"

#endif

//error domain
#define kCBErrorDomain @"CoreBLEErrorDomain"

#define kCBErrorCentralBLEStateError                    396
#define kCBErrorCentralDidNotFindService                397
#define kCBErrorCentralDidNotFindCharacteristic         398
#define kCBErrorCentralDidNotFindPeripheral             399
#define kCBErrorCentralConnectionTimeoutCode            400
#define kCBErrorCentralLostConnection                   401
#define kCBErrorCentralDiscoverFailed                   402
#define kCBErrorCentralWriteFailed                      403
#define kCBErrorCentralReadFailed                       404
#define kCBErrorCentralRecvNotifyDataFailed             405
#define kCBErrorPeripheralSendingDataFailed             406
#define kCBErrorPeripheralReadFailed                    407
#define kCBErrorPeripheralWriteFailed                   408
#define kCBErrorPeripheralReadingDataOutofBounds        409
#define kCBErrorCentralDisConnectionTimeoutCode         410

#define kCBErrorCentralStatePoweredOff                  440
#define kCBErrorCentralStateUnknown                     441
#define kCBErrorCentralStateUnauthorized                442
#define kCBErrorCentralStateUnsupported                 443



//notify MTU
#define kCBNotifyMTU 20

//background identifier
#define kCentralRestoreIdentifier @"TYBLECentralRestoreIdentifier"


#endif /* TYBLEConfig_h */
