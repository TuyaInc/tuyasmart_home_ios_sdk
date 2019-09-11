//
//  TuyaSmartBleMesh+SIGMesh.h
//  TuyaSmartBLEMeshKit
//
//  Created by 黄凯 on 2019/3/8.
//

#import "TuyaSmartBleMesh.h"

NS_ASSUME_NONNULL_BEGIN

@interface TuyaSmartBleMesh (SIGMesh)

+ (void)createSIGMeshWithHomeId:(long long)homeId
                        success:(void(^)(TuyaSmartBleMeshModel *meshModel))success
                        failure:(TYFailureError)failure;

/**
 蓝牙设备入网 后绑定 productKey + mac = pid
 
 @param uuid        蓝牙子设备短地址标识
 @param devKey      设备 key
 @param nodeId      mesh节点id（短地址）
 @param productKey  产品 Key
 @param ver         版本号
 @param mac         设备 mac
 @param success     操作成功回调
 @param failure     操作失败回调
 */
- (void)addSIGMeshSubDeviceWithUuid:(NSString *)uuid
                             devKey:(NSString *)devKey
                             nodeId:(NSString *)nodeId
                         productKey:(NSString *)productKey
                                ver:(NSString *)ver
                                mac:(NSString *)mac
                            success:(void (^)(NSString *devId, NSString *name))success
                            failure:(TYFailureError)failure;


/**
 蓝牙设备入网 前绑定 pid
 
 @param uuid        蓝牙子设备短地址标识
 @param devKey      设备 key
 @param nodeId      mesh节点id（短地址）
 @param productId   产品 ID
 @param ver         版本号
 @param mac         设备 mac
 @param success     操作成功回调
 @param failure     操作失败回调
 */
- (void)addSIGMeshSubDeviceWithUuid:(NSString *)uuid
                             devKey:(NSString *)devKey
                             nodeId:(NSString *)nodeId
                          productId:(NSString *)productId
                                ver:(NSString *)ver
                                mac:(NSString *)mac
                            success:(void (^)(NSString *devId, NSString *name))success
                            failure:(TYFailureError)failure;


/**
 向云端分配 sig mesh 的 node id, 每次分配 + 0000 0111 = 8
 
 @param success 操作成功回调
 @param failure 操作失败回调
 */
- (void)getSIGMeshNodeAddressFromServerWithSuccess:(TYSuccessInt)success failure:(TYFailureError)failure;


/**
 在网关连接下通过网关移除 sig mesh 子设备

 @param gatewayId 网关 id
 @param subDeviceId 子设备 id
 @param success 操作成功回调
 @param failure 操作失败回调
 */
- (void)removeMeshSubDeviceWithGatewayId:(NSString *)gatewayId
                             subDeviceId:(NSString *)subDeviceId
                                 success:(TYSuccessHandler)success
                                 failure:(TYFailureError)failure;


/**
 向云端分配 sig mesh 的终端 source id
 
 @param success 操作成功回调
 @param failure 操作失败回调
 */
- (void)getSIGMeshSourceAddressFromServerWithSuccess:(TYSuccessInt)success
                                             failure:(TYFailureError)failure;

@end

NS_ASSUME_NONNULL_END
