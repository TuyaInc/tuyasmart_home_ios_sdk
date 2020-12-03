//
//  TuyaSmartDeviceCoreKit.h
//  TuyaSmartDeviceCoreKit
//
//  Created by 高森 on 2018/9/3.
//

#ifndef TuyaSmartDeviceCoreKit_h
#define TuyaSmartDeviceCoreKit_h

/**
 *  当前客户端支持的最高的外网通信协议
 */
#define TUYA_CURRENT_GW_PROTOCOL_VERSION 2.2

/**
 *  当前客户端支持的最高的局域网通信协议
 */
#define TUYA_CURRENT_LAN_PROTOCOL_VERSION 3.4

#import <TuyaSmartBaseKit/TuyaSmartBaseKit.h>

#if TARGET_OS_IOS
    #import <TuyaSmartMQTTChannelKit/TuyaSmartMQTTChannelKit.h>
    #import <TuyaSmartSocketChannelKit/TuyaSmartSocketChannelKit.h>
#elif TARGET_OS_WATCH
    #define TuyaSmartMQTTChannelDelegate NSObject
    #define TuyaSmartSocketChannelDelegate NSObject
#endif

#import "TuyaSmartDevice.h"
#import "TuyaSmartGroup.h"
#import "TuyaSmartBleMeshModel.h"
#import "TuyaSmartSingleTransfer.h"
#import "TYCoreCacheService.h"

#import "TuyaSmartDeviceCoreKitErrors.h"

#endif /* TuyaSmartDeviceCoreKit_h */
