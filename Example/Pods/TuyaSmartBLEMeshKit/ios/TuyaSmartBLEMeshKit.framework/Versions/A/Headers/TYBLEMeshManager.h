//
//  TYBLEMeshManager.h
//  TuyaSmartKit
//
//  Created by XuChengcheng on 2017/7/26.
//  Copyright © 2017年 Tuya. All rights reserved.
//

#ifndef TuyaSmart_TYBLEMeshManager
#define TuyaSmart_TYBLEMeshManager

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "TYBleMeshDeviceModel.h"
#import "TYBLEMeshCommand.h"

#define kInitMeshName @"out_of_mesh"

@class TYBLEMeshManager;
@protocol TYBLEMeshManagerDelegate <NSObject>

@optional

/**
 蓝牙状态回调

 @param status z蓝牙状态
 */
- (void)centralManagerStatusChange:(CBManagerState)status;

/**
 激活子设备回调
 
 @param name 设备名称
 @param deviceId dev Id
 @param error 激活中的错误，若发生错误，`name` 以及 `deviceId` 为空
 */
- (void)activeDeviceSuccessWithName:(NSString *)name deviceId:(NSString *)deviceId error:(NSError *)error;

/**
 激活子设备成功回调
 
 @param manager mesh manager
 @param device 设备
 @param devId 设备 Id
 @param error 激活中的错误，若发生错误，`name` 以及 `deviceId` 为空
 */
- (void)bleMeshManager:(TYBLEMeshManager *)manager didActiveSubDevice:(TYBleMeshDeviceModel *)device devId:(NSString *)devId error:(NSError *)error;

/**
 激活网关设备回调
 
 @param name 设备名称
 @param address 设备地址
 @param mac 网关 mac
 @param error 激活中的错误
 */
- (void)activeWifiDeviceWithName:(NSString *)name address:(NSInteger)address mac:(NSInteger)mac error:(NSError *)error;

/**
 激活设备失败回调
 
 @param manager mesh manager
 @param device 设备
 @param error 激活中的错误
 */
- (void)bleMeshManager:(TYBLEMeshManager *)manager didFailToActiveDevice:(TYBleMeshDeviceModel *)device error:(NSError *)error;

/**
 激活完成回调
 */
- (void)didFinishToActiveDevList;

/**
 断开设备回调
 */
- (void)notifyCentralManagerDidDisconnectPeripheral;

/**
 版本号回调

 @param version 版本号
 */
- (void)notifyFirmwareWithVersion:(NSString *)version;

/**
 登录成功通知，升级所需

 @param address 当前连入入网设备地址
 */
- (void)notifyLoginSuccessWithAddress:(uint32_t)address;

/**
 群组操作回调，例如群组删除设备、新增设备，都会通过此回调告知为哪个设备

 @param address 设备地址
 @param error 操作过程中的错误
 */
- (void)deviceAddGroupAddress:(uint32_t)address error:(NSError *)error;

/**
 扫描到待配网的设备
 
 @param manager mesh manager
 @param device 待配网设备信息
 */
- (void)bleMeshManager:(TYBLEMeshManager *)manager didScanedDevice:(TYBleMeshDeviceModel *)device;

- (void)notifyQueryGroupAddress:(uint32_t)localId nodeId:(uint32_t)nodeId;

@end

@interface TYBLEMeshManager : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic, assign) BOOL isPoweredOn;
@property (nonatomic, assign) BOOL isLogin;
@property (nonatomic, assign) BOOL isWifiDevice;
@property (nonatomic, assign) uint32_t wifiAddress;
@property (nonatomic, assign) uint32_t otaAddress;
@property (nonatomic, strong) NSString *ssid;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *authKey;
@property (nonatomic, strong) NSString *uuid;
@property (nonatomic, strong) NSString *productId;
@property (nonatomic, strong) NSString *version;

// 新版 Wi-Fi address
@property (nonatomic, assign) uint32_t wifiMac;

@property (nonatomic, weak) id<TYBLEMeshManagerDelegate> delegate;

/**
 mesh 入口
 
 若操作为配网，填入默认 mesh name 和 password，此时只会通过 `TYBLEMeshManagerDelegate` 中的
 `- (void)bleMeshManager:(TYBLEMeshManager *)manager didScanedDevice:(TYBleMeshDeviceModel *)device;` 返回扫描结果
 
 若操作为入网，填入已创建的 mesh name 和 password，此信息来自云端接口返回，可以自动进行连接、入网，并自动获取一次 mesh 网中的各个设备在线情况
 
 @param name mesh 名称
 @param pwd mesh 密码
 @param active 是否为配网激活
 @param wifiAddress Wi-Fi 地址，网关配网需要，其余情况传 0
 @param otaAddress ota 设备地址，ota 升级时需要，其余情况传 0
 */
- (void)startScanWithName:(NSString *)name
                      pwd:(NSString *)pwd
                   active:(BOOL)active
              wifiAddress:(uint32_t)wifiAddress
               otaAddress:(uint32_t)otaAddress;

/**
 激活设备
 
 @param includeGateway 是否激活网关，若为 `yes`, 则会激活已记录扫描到设备中的网关设备，其余子设备不激活
 反之激活所有的已扫描的普通的 mesh 子设备，不激活网关
 */
- (void)activeMeshDeviceIncludeGateway:(BOOL)includeGateway;

/**
 激活特定的设备
 
 @param deviceModel 设备 model
 */
- (void)activeMeshDevice:(TYBleMeshDeviceModel *)deviceModel;

/**
 停止激活设备
 */
- (void)stopActiveDevice;

- (void)getLightAllStatus;
- (BOOL)isConnected;
- (void)stopScan;
- (void)clearScanData;

/**
 发送命令
 
 @param command command
 */
- (void)sendCommand:(TYBLEMeshCommand *)command;

/**
 *
 *  向网关写入 Wi-Fi 信息，使用 sdk 激活后，此方法会自动调用
 *
 *  @param ssid     路由器热点名称
 *  @param pwd      路由器热点密码
 *  @param token    配网Token
 */
- (void)startConfigWiFiWithSsid:(NSString *)ssid
                            pwd:(NSString *)pwd
                          token:(NSString *)token;


/**
 读取固件版本号
 */
- (void)readFirmwareFeature;

/**
 发送升级包
 
 @param address 设备地址
 @param version 版本号
 @param otaData 升级数据
 @param success 成功回调
 @param failure 失败回调
 */
- (void)sendOTAPackWithAddress:(NSInteger)address
                       version:(NSString *)version
                       otaData:(NSData *)otaData
                       success:(TYSuccessHandler)success
                       failure:(TYFailureHandler)failure;


/**
 获取 mesh 产品名称，需要事先将产品与 app 关联，否则返回为空

 @param productId 产品 id
 @param completion 完成回调
 */
- (void)getProductNameByProductId:(NSString *)productId
                       completion:(void(^)(NSString *))completion;

@end

@interface TYBLEMeshManager (Command)

/**
 设置灯的模式（照明类专属）
 模式数据在 param 中，具体参考协议
 
 @param address 地址
 @param type 设备大小类
 @param isGroup 是否为群组
 @param param 参数
 */
- (void)setLightModelWithAddress:(uint32_t)address
                            type:(NSString *)type
                         isGroup:(BOOL)isGroup
                           param:(NSArray<NSString *> *)param;



/**
 读取灯的场景模式（照明类专属）
 
 @param address 设备地址
 @param type 设备大小类
 */
- (void)getLightSceneModelWithAddress:(uint32_t)address
                                 type:(NSString *)type;

/**
 获取低功耗（门磁）状态
 
 @param deviceAddress 设备地址
 @param dps 数据 dp
 @param type 大小类
 */
- (void)getSensorStateWithAddress:(uint32_t)deviceAddress
                              dps:(NSArray *)dps
                             type:(NSString *)type;



/**
 把设备加入到群组
 
 @param deviceAddress 设备地址
 @param type 设备大小类
 @param groupAddress 群组地址
 */
- (void)addDeviceAddress:(uint32_t)deviceAddress
                    type:(NSString *)type
            groupAddress:(uint32_t)groupAddress;



/**
 把设备从群组内移除
 
 @param deviceAddress 设备地址
 @param type 设备大小类
 @param groupAddress 群组地址
 */
- (void)deleteDeviceAddress:(uint32_t)deviceAddress
                       type:(NSString *)type
               groupAddress:(uint32_t)groupAddress;




/**
 从 mesh 中删除某个群组
 
 @param groupAddress 群组地址
 @param type 群组大小类
 */
- (void)deleteGroupAddress:(uint32_t)groupAddress
                      type:(NSString *)type;



/**
 获取设备对应的群组地址
 
 @param deviceAddress 设备地址
 @param type 设备大小类
 */
- (void)getGroupAddressWithDeviceAddress:(uint32_t)deviceAddress
                                    type:(NSString *)type;

/**
 获取群组下的所有设备
 
 @param groupAddress 群组地址
 @param type 群组大小类
 */
- (void)getDevicesAddressWithGroupAddress:(uint32_t)groupAddress
                                     type:(NSString *)type;



/**
 将某个设备从 mesh 网中剔除
 
 @param address 设备地址
 @param type 设备大小类
 */
- (void)kickoutLightWithAddress:(uint32_t)address
                           type:(NSString *)type;


/**
 获取某个设备状态，例如灯的 rgb 等。。。
 
 @param address 设备地址
 @param type 设备大小类
 */
- (void)getDeviceStatusAllWithAddress:(uint32_t)address
                                 type:(NSString *)type;



/**
 获取设备倒计时数据（电工类专属）
 
 @param address 设备地址
 @param type 设备大小类
 */
- (void)getDeviceCountdownWithAddress:(uint32_t)address
                                 type:(NSString *)type;



@end

@interface TYBLEMeshManager (Raw)

/** 这里的命令都是在网关连接下进行下发控制使用的 */

/**
 从 mesh 中删除某个群组
 
 @param groupAddress 群组地址
 @param type 群组大小类
 @return raw 数据
 */
- (NSString *)rawDataDeleteGroupAddress:(uint32_t)groupAddress
                                   type:(NSString *)type;



/**
 从群组内删除某个设备
 
 @param deviceAddress 设备地址
 @param groupAddress 群组地址
 @param type 设备大小类
 @return raw 数据
 */
- (NSString *)rawDataDeleteDeviceAddress:(uint32_t)deviceAddress
                            groupAddress:(uint32_t)groupAddress
                                    type:(NSString *)type;



/**
 添加某个设备到群组
 
 @param deviceAddress 设备地址
 @param groupAddress 群组地址
 @param type 群组大小类
 @return raw 数据
 */
- (NSString *)rawDataAddDeviceAddress:(uint32_t)deviceAddress
                         groupAddress:(uint32_t)groupAddress
                                 type:(NSString *)type;



/**
 获取指定群组下的所有设备
 
 @param groupAddress 群组地址
 @param type 群组大小类
 @return raw 数据
 */
- (NSString *)rawDataGetDevicesAddressWithGroupAddress:(uint32_t)groupAddress
                                                  type:(NSString *)type;


/**
 从 mesh 中踢掉某个设备
 
 @param address 设备地址
 @param type 设备大小类
 @return raw 数据
 */
- (NSString *)rawDataKickoutLightWithAddress:(uint32_t)address
                                        type:(NSString *)type;



/**
 获取对应设备状态
 
 @param address 设备地址
 @param type 设备大小类
 @return raw 数据
 */
- (NSString *)rawDataGetStatusAllWithAddress:(uint32_t)address
                                        type:(NSString *)type;




/**
 获取设备倒计时（电工类专属）
 
 @param address 设备地址
 @param type 设备大小类
 @return raw 数据
 */
- (NSString *)rawDataCountDownWithAddress:(uint32_t)address
                                     type:(NSString *)type;



@end

#endif
