//
//  TuyaSmartBlueMesh.h
//  TuyaSmartKit
//
//  Created by XuChengcheng on 2017/6/7.
//  Copyright © 2017年 Tuya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TuyaSmartDeviceKit/TuyaSmartDeviceModel.h>
#import <TuyaSmartDeviceKit/TuyaSmartBleMeshModel.h>

@protocol TuyaSmartBleMeshDelegate<NSObject>

@optional

/// dp数据更新
- (void)subDeviceUpdateWithAddress:(NSString *)address dps:(NSDictionary *)dps;

/// 收到raw透传指令
- (void)bleMeshReceiveRawData:(NSString *)raw;

/// 收到数据批量上报
- (void)bleMeshReceiveBatchDeviceDpsInfo;



@end

@interface TuyaSmartBleMesh : NSObject

@property (nonatomic, strong, readonly) TuyaSmartBleMeshModel *bleMeshModel;

@property (nonatomic, weak) id<TuyaSmartBleMeshDelegate> delegate;

/**
 获取设备对象
 
 @param meshId meshId
 */
+ (instancetype)bleMeshWithMeshId:(NSString *)meshId homeId:(long long)homeId;

/**
 获取设备对象
 
 @param meshId meshId
 */
- (instancetype)initWithMeshId:(NSString *)meshId homeId:(long long)homeId NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;

/**
 创建mesh
 
 @param meshName mesh名字
 @param success 操作成功回调 meshId
 @param failure 操作失败回调
 */
+ (void)createBleMeshWithMeshName:(NSString *)meshName homeId:(long long)homeId success:(void(^)(TuyaSmartBleMeshModel *meshModel))success failure:(TYFailureError)failure;

/**
 获取mesh的子设备信息
 
 @param success 操作成功回调
 @param failure 操作失败回调
 */
- (void)getSubDeviceListFromCloudWithSuccess:(void (^)(NSArray <TuyaSmartDeviceModel *> *subDeviceList))success failure:(TYFailureError)failure;

/**
 获取单个子设备信息
 
 @param deviceId 子设备id
 
 @param success 操作成功回调
 @param failure 操作失败回调
 */
- (void)getSubDeviceFromCloudWithDeviceId:(NSString *)deviceId success:(void (^)(TuyaSmartDeviceModel *subDeviceModel))success failure:(TYFailureError)failure;

/**
 单个子设备dps命令下发
 
 @param nodeId 蓝牙子设备短地址标识
 @param pcc 大小类标示
 @param dps 命令字典
 @param success 操作成功回调
 @param failure 操作失败回调
 */
- (void)publishNodeId:(NSString *)nodeId
                  pcc:(NSString *)pcc
                  dps:(NSDictionary *)dps
              success:(TYSuccessHandler)success
              failure:(TYFailureError)failure;

/**
 群控设备
 
 @param localId    localId
 @param pcc      大小类标示
 @param dps      命令字典
 @param success 操作成功的回调
 @param failure 操作失败的回调
 */
- (void)multiPublishWithLocalId:(NSString *)localId
                            pcc:(NSString *)pcc
                            dps:(NSDictionary *)dps
                        success:(TYSuccessHandler)success
                        failure:(TYFailureError)failure;

/**
 广播dps命令下发
 
 @param dps 命令字典
 @param pcc 大小类标示
 @param success 操作成功回调
 @param failure 操作失败回调
 */
- (void)broadcastDps:(NSDictionary *)dps
                 pcc:(NSString *)pcc
             success:(TYSuccessHandler)success
             failure:(TYFailureError)failure;



/**
 获取子设备的最新dps信息
 
 @param nodeId 蓝牙子设备短地址标识
 @param dpIdList dps 中 key 的 list
 @param success 操作成功回调
 @param failure 操作失败回调
 */
- (void)getSubDeviceDpsWithNodeId:(NSString *)nodeId
                              pcc:(NSString *)pcc
                         dpIdList:(NSArray <NSNumber *> *)dpIdList
                          success:(TYSuccessHandler)success
                          failure:(TYFailureError)failure;


/**
 给设备发送透传指令
 
 @param raw 透传值
 @param success 操作成功的回调
 @param failure 操作失败的回调
 */
- (void)publishRawDataWithRaw:(NSString *)raw
                          pcc:(NSString *)pcc
                      success:(TYSuccessHandler)success
                      failure:(TYFailureError)failure;


/**
 修改mesh名称
 
 @param meshName mesh名称
 @param success 操作成功回调
 @param failure 操作失败回调
 */
- (void)updateMeshName:(NSString *)meshName success:(TYSuccessHandler)success failure:(TYFailureError)failure;

/**
 删除mesh，如果mesh组下有设备，子设备也移除掉。wifi连接器也一并移除掉。
 
 @param success 操作成功回调
 @param failure 操作失败回调
 */
- (void)removeMeshWithSuccess:(TYSuccessHandler)success failure:(TYFailureError)failure;

/**
 蓝牙设备入网 2.0
 
 @param uuid        蓝牙子设备短地址标识
 @param authKey     授权
 @param nodeId      mesh节点id（短地址）
 @param productKey  产品ID
 @param ver         版本号
 @param success     操作成功回调
 @param failure     操作失败回调
 */
- (void)addSubDeviceWithUuid:(NSString *)uuid
                      homeId:(long long)homeId
                     authKey:(NSString *)authKey
                      nodeId:(NSString *)nodeId
                  productKey:(NSString *)productKey
                         ver:(NSString *)ver
                     success:(void (^)(NSString *devId, NSString *name))success
                     failure:(TYFailureError)failure;

/**
 重命名mesh子设备
 
 @param deviceId    设备ID
 @param name        新的名字
 @param success     操作成功回调
 @param failure     操作失败回调
 */
- (void)renameMeshSubDeviceWithDeviceId:(NSString *)deviceId name:(NSString *)name success:(TYSuccessHandler)success failure:(TYFailureError)failure;

/**
 移除mesh子设备
 
 @param deviceId    设备ID
 @param success     操作成功回调
 @param failure     操作失败回调
 */
- (void)removeMeshSubDeviceWithDeviceId:(NSString *)deviceId success:(TYSuccessHandler)success failure:(TYFailureError)failure;




@end

