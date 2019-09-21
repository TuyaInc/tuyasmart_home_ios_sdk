//
//  TuysSmartDeviceModel.h
//  TuyaSmartKit
//
//  Created by fengyu on 15/9/12.
//  Copyright (c) 2015年 Tuya. All rights reserved.
//

#ifndef TuyaSmart_TuyaSmartDeviceModel
#define TuyaSmart_TuyaSmartDeviceModel

#import "TuyaSmartSchemaModel.h"
#import "TuyaSmartDeviceModuleModel.h"
#import "TuyaSmartStandSchemaModel.h"

typedef enum : NSUInteger {
    
    TuyaSmartDeviceModelTypeWifiDev,         /// Wi-Fi
    
    TuyaSmartDeviceModelTypeBle,             /// Single Point Bluetooth Device
    
    TuyaSmartDeviceModelTypeGprs,            /// Gprs
    
    TuyaSmartDeviceModelTypeNBIoT,           /// NB-IoT
    
    TuyaSmartDeviceModelTypeZigbeeGateway,   /// Zigbee Gateway
    
    TuyaSmartDeviceModelTypeZigbeeSubDev,    /// Zigbee subDevice
    
    TuyaSmartDeviceModelTypeMeshBleSubDev,   /// Mesh
    
    TuyaSmartDeviceModelTypeInfraredGateway, /// Infrared gateway
    
    TuyaSmartDeviceModelTypeInfraredSubDev,  /// Infrared subDevice
    
    TuyaSmartDeviceModelTypeWifiGateway,     /// Wi-Fi Gateway
    
    TuyaSmartDeviceModelTypeWifiSubDev,      /// Wi-Fi subDevice
    
    TuyaSmartDeviceModelTypeSIGMeshGateway,  /// SIG Mesh Gateway
    
    TuyaSmartDeviceModelTypeSIGMeshSubDev,   /// SIG Mesh subDevice
    
} TuyaSmartDeviceModelType;

@interface TuyaSmartDeviceModel : NSObject

// device Id
@property (nonatomic, strong) NSString     *devId;

// name of device
@property (nonatomic, strong) NSString     *name;

// link of device icon
@property (nonatomic, strong) NSString     *iconUrl;

// ability of device
@property (nonatomic, assign) NSInteger    ability;

// online of device
@property (nonatomic, assign) BOOL         isOnline;

// whether the device is shared
@property (nonatomic, assign) BOOL         isShare;

//
@property (nonatomic, strong) NSString     *verSw;

// data point of device
@property (nonatomic, strong) NSDictionary *dps;

// product Id
@property (nonatomic, strong) NSString     *productId;

// whether to support group
@property (nonatomic, assign) BOOL         supportGroup;

// type of gateway
@property (nonatomic, strong) NSString     *gwType;

// protocol version of gateway
@property (nonatomic, assign) double       pv;

#if TARGET_OS_IOS

// online status of LAN
@property (nonatomic, assign) BOOL         isLocalOnline;

// gateway protocol version of LAN
@property (nonatomic, assign) double       lpv;

#endif

// hardware baseline version
@property (nonatomic, assign) double       bv;

// lat, lon
@property (nonatomic, strong) NSString     *latitude;
@property (nonatomic, strong) NSString     *longitude;

// dp name
@property (nonatomic, strong) NSDictionary *dpName;

// schema of device
@property (nonatomic, strong) NSString     *schema;
@property (nonatomic, strong) NSString     *schemaExt;
@property (nonatomic, strong) NSArray<TuyaSmartSchemaModel *> *schemaArray;

@property (nonatomic, strong) NSString     *runtimeEnv;

// attribute
@property (nonatomic, assign) NSUInteger    attribute;

@property (nonatomic, strong) NSString     *localKey;

@property (nonatomic, strong) NSString     *uuid;
// The network communication ability:0.wifi;1.cable;2.gprs;3.nb-iot; 10:bluetooth;11.blemesh;12.zigbee
@property (nonatomic, assign) NSUInteger   capability;

@property (nonatomic, strong) NSString     *timezoneId;

@property (nonatomic, assign) long long    homeId;
@property (nonatomic, assign) long long    roomId;

// order
@property (nonatomic, assign) NSInteger    displayOrder;
@property (nonatomic, assign) NSInteger    homeDisplayOrder;

@property (nonatomic, strong) NSString     *ip;

// skills
@property (nonatomic, strong) NSDictionary *skills;

@property (nonatomic, strong) NSString     *cloudId;

#pragma mark - panel

@property (nonatomic, assign) BOOL         rnFind;
@property (nonatomic, assign) long long    i18nTime;
@property (nonatomic, strong) NSString     *ui;
@property (nonatomic, strong) NSString     *uiId;
@property (nonatomic, strong) NSString     *uiVersion;
@property (nonatomic, strong) NSString     *uiPhase;
@property (nonatomic, strong) NSString     *uiType;
@property (nonatomic, strong) NSString     *uiName;
@property (nonatomic, strong) NSDictionary *uiConfig;
@property (nonatomic, strong) NSDictionary *panelConfig;
@property (nonatomic, strong) NSString     *category;
@property (nonatomic, strong) NSArray      *quickOpDps;
@property (nonatomic, strong) NSArray      *displayDps;
@property (nonatomic, strong) NSArray      *faultDps;
@property (nonatomic, strong) NSDictionary *displayMsgs;
@property (nonatomic, strong) NSString     *switchDp;

@property (nonatomic, assign) BOOL         isNewFirmware;
@property (nonatomic, assign) NSTimeInterval activeTime;
@property (nonatomic, assign) long         errorCode;

@property (nonatomic, assign) TuyaSmartDeviceModelType deviceType;
@property (nonatomic, assign) BOOL         upgrading;

@property (nonatomic, strong) NSDictionary *originJson;

@property (nonatomic, strong) TuyaSmartDeviceModuleModel *moduleMap;

- (BOOL)attributeIsSupport:(NSUInteger)i;
- (BOOL)capabilityIsSupport:(NSUInteger)i;
- (BOOL)devAttributeIsSupport:(NSUInteger)i;

#pragma mark - subdevice
// node Id
@property (nonatomic, strong) NSString     *nodeId;
@property (nonatomic, strong) NSString     *parentId;

// mesh
@property (nonatomic, strong) NSString     *vendorInfo;
@property (nonatomic, assign) BOOL         isMeshBleOnline;
@property (nonatomic, strong) NSString     *pcc;

#pragma mark - discovery device
// mark:  0: 1<<0 auto  3：1<<3 route
@property (nonatomic, assign) NSUInteger devAttribute;

// sig mesh dev key
@property (nonatomic, strong) NSString     *devKey;

/// 是否标准化
@property (nonatomic, assign) BOOL standard;
@property (nonatomic, strong) TuyaSmartStandSchemaModel *standSchemaModel;
@end

#endif
