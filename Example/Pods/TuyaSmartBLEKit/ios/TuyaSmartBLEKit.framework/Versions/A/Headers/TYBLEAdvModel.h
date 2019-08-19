//
//  TYBLEAdvModel.h
//  TuyaSmartPublic
//
//  Created by 冯晓 on 16/8/24.
//  Copyright © 2016年 Tuya. All rights reserved.
//

typedef enum : NSUInteger {
    TYSmartBLETypeUnknow = 1,
    TYSmartBLETypeBLE,//单点设备
    TYSmartBLETypeBLEWifi,//ble-wifi 设备
    TYSmartBLETypeBLESecurity,//安全协议的设备
} TYSmartBLEType;

@interface TYBLEAdvModel : NSObject

@property (nonatomic, strong) NSString           *uuid;
@property (nonatomic, strong) NSString           *productId;
@property (nonatomic, assign) BOOL               isActive;
@property (nonatomic, assign) TYSmartBLEType     bleType;
//用于安全协议的设备 表示协议版本
@property (nonatomic, assign) int                bleProtocolV;

@end
