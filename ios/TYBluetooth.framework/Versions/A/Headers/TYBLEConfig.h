//
//  TYBLEConfig.h
//  TuyaSmartPublic
//
//  Created by 冯晓 on 16/8/2.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#ifndef TYBLEConfig_h
#define TYBLEConfig_h

//error domain
#define kCBErrorDomain @"CoreBLEErrorDomain"

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

#define kCBErrorPeripheralIsNil                         440
#define kCBErrorCenteralStateNotPoweredOn               450




//notify MTU
#define kCBNotifyMTU 20

//background identifier
#define kCentralRestoreIdentifier @"TYBLECentralRestoreIdentifier"


#endif /* TYBLEConfig_h */
