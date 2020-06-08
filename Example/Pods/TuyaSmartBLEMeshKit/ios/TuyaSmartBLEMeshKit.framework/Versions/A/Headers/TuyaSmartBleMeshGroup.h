//
//  TuyaSmartBleMeshGroup.h
//  TuyaSmartKit
//
//  Created by XuChengcheng on 2017/7/10.
//  Copyright © 2017年 Tuya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TuyaSmartDeviceKit/TuyaSmartDeviceKit.h>

NS_ASSUME_NONNULL_BEGIN

@class TuyaSmartBleMeshGroup;
@protocol TuyaSmartBleMeshGroupDelegate <NSObject>

/// sig mesh 设备加入到网关的群组响应
/// 1:超过场景数上限 2:子设备超时 3:设置值超出范围 4:写文件错误 5:其他错误
/// Group Response of Zigbee Devices Joining Gateway
/// 1: Over the Scenario Limit 2: Subdevice Timeout 3: Setting Value Out of Range 4: Write File Error 5: Other Errors
- (void)meshGroup:(TuyaSmartBleMeshGroup *)group addResponseCode:(NSArray <NSNumber *> *)responseCode;

/// sig mesh 设备从网关群组移除响应
/// 1:超过场景数上限 2:子设备超时 3:设置值超出范围 4:写文件错误 5:其他错误
/// Group Response of Zigbee Devices removing Gateway
/// 1: Over the Scenario Limit 2: Subdevice Timeout 3: Setting Value Out of Range 4: Write File Error 5: Other Errors
- (void)meshGroup:(TuyaSmartBleMeshGroup *)group removeResponseCode:(NSArray <NSNumber *> *)responseCode;
  
@end

@interface TuyaSmartBleMeshGroup : NSObject

@property (nonatomic, weak, nullable) id<TuyaSmartBleMeshGroupDelegate> delegate;

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

#pragma mark - SIG Mesh

@interface TuyaSmartBleMeshGroup (SIGMesh)

/**
 通过 sig mesh 网关添加 sig mesh 子设备群组
 需要保证子设备的关系归属在在 sig mesh 网关下

 @param subList 待操作的网关下子设备
 @param success 操作成功回调
 @param failure 操作失败回调
 */
- (void)addSubDeviceWithSubList:(NSArray<TuyaSmartDeviceModel *> * _Nonnull )subList success:(nullable TYSuccessHandler)success failure:(nullable TYFailureError)failure;

/**
 通过 sig mesh 网关删除 sig mesh 子设备群组
 需要保证子设备的关系归属在在 sig mesh 网关下

 @param subList 待操作的网关下子设备
 @param success 操作成功回调
 @param failure 操作失败回调
 */
- (void)removeSubDeviceWithSubList:(NSArray<TuyaSmartDeviceModel *> * _Nonnull )subList success:(nullable TYSuccessHandler)success failure:(nullable TYFailureError)failure;


- (void)publishDps:(NSDictionary *)dps success:(nullable TYSuccessHandler)success failure:(nullable TYFailureError)failure;

@end
NS_ASSUME_NONNULL_END

