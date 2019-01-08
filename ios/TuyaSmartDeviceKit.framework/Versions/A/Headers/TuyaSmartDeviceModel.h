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

typedef enum : NSUInteger {
    
    TuyaSmartDeviceModelTypeWifiDev,         /// 普通 Wi-Fi 设备
    
    TuyaSmartDeviceModelTypeBle,             /// 单点蓝牙设备
    
    TuyaSmartDeviceModelTypeGprs,            /// Gprs 设备
    
    TuyaSmartDeviceModelTypeZigbeeGateway,   /// Zigbee 网关
    
    TuyaSmartDeviceModelTypeZigbeeSubDev,    /// Zigbee 子设备
    
    TuyaSmartDeviceModelTypeMeshBleSubDev,   /// Mesh 设备
    
    TuyaSmartDeviceModelTypeInfraredGateway, /// 红外网关
    
    TuyaSmartDeviceModelTypeInfraredSubDev,  /// 红外子设备
    
    TuyaSmartDeviceModelTypeWifiGateway,     /// Wi-Fi 网关
    
    TuyaSmartDeviceModelTypeWifiSubDev,      /// Wi-Fi 子设备
    
} TuyaSmartDeviceModelType;

@interface TuyaSmartDeviceModel : NSObject

//设备唯一标识符
@property (nonatomic, strong) NSString     *devId;

//设备名称
@property (nonatomic, strong) NSString     *name;

//设备icon的地址
@property (nonatomic, strong) NSString     *iconUrl;

//设备的能力值
@property (nonatomic, assign) NSInteger    ability;

//设备在线状态
@property (nonatomic, assign) BOOL         isOnline;

//局域网在线状态
@property (nonatomic, assign) BOOL         isLocalOnline;

//设备是否是分享的
@property (nonatomic, assign) BOOL         isShare;

//设备
@property (nonatomic, strong) NSString     *verSw;

//设备的当前dp点
@property (nonatomic, strong) NSDictionary *dps;

//产品唯一标识符
@property (nonatomic, strong) NSString     *productId;

//是否支持群组
@property (nonatomic, assign) BOOL         supportGroup;

//标记所属群组Id，手动设置之后才有值
@property (nonatomic, copy) NSString *markedGroupId;

//网关类型
@property (nonatomic, strong) NSString     *gwType;

//网关协议版本
@property (nonatomic, assign) double       pv;

//局域网协议版本号，只有在局域网连着的情况下，才能取到值
@property (nonatomic, assign) double       lpv;

//硬件基线版本
@property (nonatomic, assign) double       bv;

//设备经纬度
@property (nonatomic, strong) NSString     *latitude;
@property (nonatomic, strong) NSString     *longitude;

// dp名字
@property (nonatomic, strong) NSDictionary *dpName;

//设备的schema定义
@property (nonatomic, strong) NSString     *schema;
@property (nonatomic, strong) NSString     *schemaExt;
@property (nonatomic, strong) NSArray<TuyaSmartSchemaModel *> *schemaArray;

@property (nonatomic, strong) NSString     *runtimeEnv;

//标位
@property (nonatomic, assign) NSUInteger    attribute;

@property (nonatomic, strong) NSString     *localKey;

@property (nonatomic, strong) NSString     *uuid;
// 联网通信能力标位:0.wifi;1.cable;2.gprs;3.nb-iot; 10:bluetooth;11.blemesh;12.zigbee
@property (nonatomic, assign) NSUInteger   capability;

@property (nonatomic, strong) NSString     *timezoneId;

@property (nonatomic, assign) long long    homeId;
@property (nonatomic, assign) long long    roomId;

// 排序
@property (nonatomic, assign) NSInteger    displayOrder;
// 扩展
@property (nonatomic, strong) NSDictionary *skills;

#pragma mark - 涂鸦智能 控制面板相关

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

@property (nonatomic, strong) NSDictionary *originJson;

@property (nonatomic, strong) TuyaSmartDeviceModuleModel *moduleMap;

- (BOOL)attributeIsSupport:(NSUInteger)i;
- (BOOL)capabilityIsSupport:(NSUInteger)i;
- (BOOL)devAttributeIsSupport:(NSUInteger)i;

#pragma mark - 子设备相关
// 子设备信息
@property (nonatomic, strong) NSString     *nodeId;
@property (nonatomic, strong) NSString     *parentId;

// mesh 融合类 pcc 拓展类型
@property (nonatomic, strong) NSString     *vendorInfo;
@property (nonatomic, assign) BOOL         isMeshBleOnline;
@property (nonatomic, strong) NSString     *pcc;

#pragma mark - 免赔网相关
// 标位: 1.具有免赔网能力
@property (nonatomic, assign) NSUInteger devAttribute;

@end

#endif
