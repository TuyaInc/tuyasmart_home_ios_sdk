//
//  TYBleMeshDeviceModel.h
//  TYBLEMeshKit
//
//  Created by 黄凯 on 2018/11/13.
//

#import <Foundation/Foundation.h>
#import <TYBluetooth/TYBLEPeripheral.h>

@interface TYBleMeshDeviceModel : NSObject

/**
 设备名称
 */
@property (nonatomic, strong) NSString *name;

/**
 设备本身
 */
@property (nonatomic, strong) TYBLEPeripheral *device;

/**
 地址
 */
@property (nonatomic, assign) uint32_t address;

/**
 产品 id
 */
@property (nonatomic, strong) NSString *productId;

/**
 设备版本号
 */
@property (nonatomic, strong) NSString *version;

/**
 mac 地址
 */
@property (nonatomic, assign) uint32_t mac;

/**
 设备 uuid
 */
@property (nonatomic, assign) NSString *uuid;

/**
 设备大小类
 */
@property (nonatomic, assign) uint32_t type;

/**
 融合类拓展信息
 */
@property (nonatomic, strong) NSString *vendorInfo;

+ (TYBleMeshDeviceModel *)modelWithBLEPeripheral:(TYBLEPeripheral *)peripheral;

@end

