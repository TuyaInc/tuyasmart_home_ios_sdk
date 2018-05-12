//
//  TYBLEMeshCommand.h
//  TuyaSmartKit
//
//  Created by 黄凯 on 2018/1/2.
//  Copyright © 2018年 Tuya. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, TYBLEMeshCommandType) {
    
    // 修改设备地址
    TYBLEMeshSetDeviceAddressCommand = 0xAA,
    
    // 群组操作，如新增、删除、设备加入群组
    TYBLEMeshGroupHandlingCommand,
    
    // 获取设备所在组的地址
    TYBLEMeshFetchGroupAddressCommand,
    
    // 将设备踢出网络
    TYBLEMeshKickedOutCommand,
    
    // 获取群组内所有设备的 ID
    TYBLEMeshFetchAllDeviceIdFromGroupCommand,
    
    // 请求 Auth Key
    TYBLEMeshRequestAuthKeyCommand,
    
    // 开关命令
    TYBLEMeshTurnOnAndOffCommand,
    
    // 获取 mesh 中所有设备状态
    TYBLEMeshFetchAllStateCommand,
    
    // 设置亮度值
    TYBLEMeshSetBrightnessValueCommand,
    
    // 设置 RGBWCL 值
    TYBLEMeshSetRGBWCLCommand,
    
    // 设置灯亮模式，彩光 / 白光
    TYBLEMeshSetLightModelCommand,
    
    // 控制子排插
    TYBLEMeshControlSubSwitchCommand,
    
    // 设置倒计时
    TYBLEMeshSetCountDownCommand,
    
    // 读取倒计时
    TYBLEMeshFetchCountDownCommand,
    
    // 读取传感器值
    TYBLEMeshFetchSensorValueCommand,
    
    // 发送 dp 点
    TYBLEMeshSendDPSCommand,
    
    // 获取一个或两个状态
    TYBLEMeshFetchStateCommand,
    
    // 修改当前 mesh 灯场景模式数据
    TYBLEMeshSetLightSceneModelCommand,
    
    // 获取当前 mesh 灯场景模式数据
    TYBLEMeshGetLightSceneModelCommand,

};

typedef enum : uint32_t {
    
    TYBLEMeshLight = 0x01, // 灯
    
    TYBLEMeshElectrician = 0x02, // 电工类
    
    TYBLEMeshSensor = 0x04, // 传感器类
    
    TYBLEMeshAdapter = 0x08, // 适配器类
    
    TYBLEMeshActuator = 0x10, //执行器类
    
    TYBLEMeshAll = 0xFF, // 全部大类
    
} TYBLEMeshProduct;

@protocol TYBLEMeshCommandProtocol <NSObject>

- (NSData *)command;

- (NSString *)raw;

@end

@interface TYBLEMeshCommand : NSObject <TYBLEMeshCommandProtocol>

@property (nonatomic, assign) TYBLEMeshCommandType commandType;

// 暂时废弃
@property (nonatomic, assign) TYBLEMeshProduct product;

@property (nonatomic, strong) NSString *pcc;

@property (nonatomic, assign) uint32_t address;

@property (nonatomic, assign) BOOL isGroup;

@property (nonatomic, strong) NSArray<NSString *> *dataParams;

@property (nonatomic, strong) NSString *logDescription;

@end
