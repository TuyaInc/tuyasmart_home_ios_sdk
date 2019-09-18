//
//  TYBLEMeshCommandType.h
//  TYBLEMeshKit
//
//  Created by 黄凯 on 2018/5/28.
//

#ifndef TYBLEMeshCommandType_h
#define TYBLEMeshCommandType_h

//
//#define TY_DEF(X) \
//X(TYBLEMeshSetDeviceAddressCommand, = 0XAA) \
//X(TYBLEMeshGroupHandlingCommand, ) \
//X(TYBLEMeshFetchGroupAddressCommand, ) \
//X(TYBLEMeshKickedOutCommand, ) \
//X(TYBLEMeshFetchAllDeviceIdFromGroupCommand, ) \
//X(TYBLEMeshRequestAuthKeyCommand, ) \
//X(TYBLEMeshTurnOnAndOffCommand, ) \
//X(TYBLEMeshFetchAllStateCommand, ) \
//X(TYBLEMeshSetBrightnessValueCommand, ) \
//X(TYBLEMeshSetRGBWCLCommand, ) \
//X(TYBLEMeshSetLightModelCommand, ) \
//X(TYBLEMeshControlSubSwitchCommand, ) \
//X(TYBLEMeshSetCountDownCommand, ) \
//X(TYBLEMeshFetchCountDownCommand, ) \
//X(TYBLEMeshFetchSensorValueCommand, ) \
//X(TYBLEMeshSendDPSCommand, ) \
//X(TYBLEMeshFetchStateCommand, ) \
//X(TYBLEMeshSetLightSceneModelCommand, ) \
//X(TYBLEMeshGetLightSceneModelCommand, ) \
//
//DECLARE_ENUM(TYBLEMeshCommandType, TY_DEF)


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
    
    // 时间同步
    TYBLEMeshTimeSynchronizationCommand,
    
    // 设置定时
    TYBLEMeshSetTimerCommand,
    
    // 读取定时
    TYBLEMeshGetTimerCommand,
    
};

#endif /* TYBLEMeshCommandType_h */
