//
//  TYBLEAdvModel.h
//  TuyaSmartPublic
//
//  Created by 冯晓 on 16/8/24.
//  Copyright © 2016年 Tuya. All rights reserved.
//  单点蓝牙广播包model

typedef enum : NSUInteger {
    TYSmartBLETypeUnknow = 1,
    TYSmartBLETypeBLE,//单点设备
    TYSmartBLETypeBLEPlus,//单点设备
    TYSmartBLETypeBLEWifi,//ble-wifi 设备
    TYSmartBLETypeBLESecurity,//安全协议的设备
    TYSmartBLETypeBLEWifiSecurity,//安全协议的双模多协议配网 BLE WI-FI 设备
} TYSmartBLEType;

@interface TYBLEAdvModel : NSObject

@property (nonatomic, strong) NSString           *uuid;
@property (nonatomic, strong) NSString           *productId;
@property (nonatomic, strong) NSString           *mac;
@property (nonatomic, assign) BOOL               isActive;
@property (nonatomic, assign) TYSmartBLEType     bleType;
@property (nonatomic, assign) BOOL               isSupport5G;
@property (nonatomic, assign) BOOL               isProuductKey; // NO 前绑定设备 YES 后绑定设备
//用于安全协议的设备 表示协议版本
@property (nonatomic, assign) int                bleProtocolV;

@end
