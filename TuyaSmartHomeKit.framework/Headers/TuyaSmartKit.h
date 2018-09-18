//
//  TuyaSmartKit.h
//  TuyaSmartKit
//
//  Created by fengyu on 15/9/11.
//  Copyright (c) 2015年 Tuya. All rights reserved.
//




/**
 *  当前SDK为全屋智能SDK
 */
#define TUYA_HOMEKIT_SDK

/**
 *  当前SDK的版本号
 */
#define TUYA_SDK_VERSION @"0.0.17"

/**
 *  当前客户端支持的最高的外网通信协议
 */
#define TUYA_CURRENT_GW_PROTOCOL_VERSION 2.2

/**
 *  当前客户端支持的最高的局域网通信协议
 */
#define TUYA_CURRENT_LAN_PROTOCOL_VERSION 3.2


#import <Foundation/Foundation.h>

#import "TuyaSmartKitConstants.h"
#import "TuyaSmartSDK.h"
#import "TuyaSmartUser.h"
#import "TuyaSmartActivator.h"
#import "TuyaSmartDevice.h"
#import "TuyaSmartGroup.h"
#import "TuyaSmartTimer.h"
#import "TuyaSmartRequest.h"
#import "TuyaSmartGroupDevListModel.h"
#import "TuyaSmartScene.h"
#import "TuyaSmartSceneManager.h"
#import "TuyaSmartFeedback.h"
#import "TuyaSmartMessage.h"
#import "TuyaSmartHome.h"
#import "TuyaSmartHomeManager.h"
#import "TuyaSmartHomeMember.h"
#import "TuyaSmartHomeMemberModel.h"
#import "TuyaSmartHomeModel.h"
#import "TuyaSmartRoom.h"
#import "TuyaSmartRoomModel.h"
#import "TuyaSmartBleMeshModel.h"
#import "TuyaSmartBleMesh.h"
#import "TuyaSmartBleMeshGroup.h"
#import "TYBleMeshDeviceModel.h"
#import "TYBLEMeshManager.h"
#import "TuyaSmartHomeDeviceShare.h"
#import "NSError+TYDomain.h"


