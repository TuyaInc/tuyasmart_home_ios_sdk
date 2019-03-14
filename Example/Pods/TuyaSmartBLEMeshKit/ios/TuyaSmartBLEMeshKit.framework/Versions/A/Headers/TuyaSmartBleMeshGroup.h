//
//  TuyaSmartBleMeshGroup.h
//  TuyaSmartKit
//
//  Created by XuChengcheng on 2017/7/10.
//  Copyright © 2017年 Tuya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TuyaSmartDeviceKit/TuyaSmartDeviceKit.h>

@interface TuyaSmartBleMeshGroup : NSObject


@property (nonatomic, strong, readonly) TuyaSmartGroupModel *meshGroupModel;

/**
 获取mesh群组对象
 
 @param groupId 群组Id
 */
+ (instancetype)meshGroupWithGroupId:(NSInteger)groupId;

/**
 获取mesh群组对象
 
 @param groupId 群组Id
 */
- (instancetype)initWithGroupId:(NSInteger)groupId NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;


/**
 向云端分配群组 Id

 @param meshId mesh id
 @param success 成功回调 localid 10 进制
 @param failure 失败回调
 */
+ (void)getBleMeshGroupAddressFromCluondWithMeshId:(NSString *)meshId
                                           success:(TYSuccessInt)success
                                           failure:(TYFailureError)failure;

/**
 创建mesh群组
 
 @param groupName mesh群组名字
 @param meshId    meshId
 @param localId   群组的本地短地址
 @param pcc 群组设备大小类
 @param success 操作成功回调 GroupId
 @param failure 操作失败回调
 */
+ (void)createMeshGroupWithGroupName:(NSString *)groupName
                              meshId:(NSString *)meshId
                             localId:(NSString *)localId
                                 pcc:(NSString *)pcc
                             success:(TYSuccessInt)success
                             failure:(TYFailureError)failure;

+ (NSInteger)getBleMeshGroupAddress;
+ (NSInteger)getBleMeshGroupCount;
- (void)deleteBleMeshGroupAddress:(NSInteger)address;

/**
 修改mesh群组名字
 
 @param meshGroupName meshGroup名称
 @param success 操作成功回调
 @param failure 操作失败回调
 */
- (void)updateMeshGroupName:(NSString *)meshGroupName success:(TYSuccessHandler)success failure:(TYFailureError)failure;


/**
 删除mesh群组
 
 @param success 操作成功回调
 @param failure 操作失败回调
 */
- (void)removeMeshGroupWithSuccess:(TYSuccessHandler)success failure:(TYFailureError)failure;

/**
 添加设备
 
 @param success 操作成功回调
 @param failure 操作失败回调
 */
- (void)addDeviceWithDeviceId:(NSString *)deviceId success:(TYSuccessHandler)success failure:(TYFailureError)failure;

/**
 批量修改设备
 
 @param success 操作成功回调
 @param failure 操作失败回调
 */
- (void)editDeviceWithDeviceList:(NSArray *)deviceList success:(TYSuccessHandler)success failure:(TYFailureError)failure;

/**
 移除设备
 
 @param success 操作成功回调
 @param failure 操作失败回调
 */
- (void)removeDeviceWithDeviceId:(NSString *)deviceId success:(TYSuccessHandler)success failure:(TYFailureError)failure;

/**
 获取群组中设备list信息
 
 @param success 操作成功回调
 @param failure 操作失败回调
 */
- (void)getDeviveListInfoWithSuccess:(void (^)(NSArray <TuyaSmartDeviceModel *> *deviceList))success failure:(TYFailureError)failure;


@end
