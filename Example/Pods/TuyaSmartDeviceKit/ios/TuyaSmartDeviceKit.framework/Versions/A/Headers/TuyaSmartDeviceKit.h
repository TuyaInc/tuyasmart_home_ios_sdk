//
//  TuyaSmartDeviceKit.h
//  TuyaSmartDeviceKit
//
//  Created by 高森 on 2018/9/3.
//

#ifndef TuyaSmartDeviceKit_h
#define TuyaSmartDeviceKit_h

/**
 *  当前客户端支持的最高的外网通信协议
 */
#define TUYA_CURRENT_GW_PROTOCOL_VERSION 2.2

/**
 *  当前客户端支持的最高的局域网通信协议
 */
#define TUYA_CURRENT_LAN_PROTOCOL_VERSION 3.3

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
#import "TuyaSmartGroup+DpCode.h"
#import "TuyaSmartHome.h"
#import "TuyaSmartHomeManager.h"
#import "TuyaSmartHomeMember.h"
#import "TuyaSmartRoom.h"
#import "TuyaSmartHomeDeviceShare.h"

#import "TuyaSmartHomeMemberModel.h"
#import "TuyaSmartHomeMemberRequestModel.h"
#import "TuyaSmartBleMeshModel.h"
#import "TuyaSmartSingleTransfer.h"

#endif /* TuyaSmartDeviceKit_h */
