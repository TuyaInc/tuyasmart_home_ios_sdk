//
//  TYBleMeshDeviceModel.h
//  TuyaSmartKit
//
//  Created by XuChengcheng on 2017/8/1.
//  Copyright © 2017年 Tuya. All rights reserved.
//

#ifndef TuyaSmart_TYBleMeshDeviceModel
#define TuyaSmart_TYBleMeshDeviceModel

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "TYBLEDevice.h"

@interface TYBleMeshDeviceModel : NSObject

// 设备名称
@property (nonatomic, strong) NSString *name;

// 目标从设备
@property (nonatomic, strong) CBPeripheral *peripheral;

// 设备本身
@property (nonatomic, strong) TYBLEDevice *device;

// 地址
@property (nonatomic, assign) uint32_t address;

// 产品 id
@property (nonatomic, strong) NSString *productId;

// 设备版本号
@property (nonatomic, strong) NSString *version;

// mac 地址
@property (nonatomic, assign) uint32_t mac;

// 设备 uuid
@property (nonatomic, assign) NSString *uuid;

// 设备大小类
@property (nonatomic, assign) uint32_t type;

// 融合类拓展信息
@property (nonatomic, strong) NSString *vendorInfo;

+ (TYBleMeshDeviceModel *)bleMeshDeviceModel:(TYBLEDevice *)device;

@end

#endif
