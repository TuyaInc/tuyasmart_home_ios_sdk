//
//  TuyaSmartGroup.h
//  TuyaSmartPublic
//
//  Created by 高森 on 16/4/21.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#ifndef TuyaSmart_TuyaSmartGroup
#define TuyaSmart_TuyaSmartGroup

#import <Foundation/Foundation.h>
#import "TuyaSmartGroupModel.h"
#import "TuyaSmartGroupDevListModel.h"

@class TuyaSmartGroup;

@protocol TuyaSmartGroupDelegate<NSObject>

@optional

/// 群组dp数据更新
- (void)group:(TuyaSmartGroup *)group dpsUpdate:(NSDictionary *)dps;

/// 群组信息更新
- (void)groupInfoUpdate:(TuyaSmartGroup *)group;

/// 群组移除
- (void)groupRemove:(NSString *)groupId;

/// zigbee 设备加入到网关群组响应
/// 1:超过场景数上限 2:子设备超时 3:设置值超出范围 4:写文件错误 5:其他错误
- (void)group:(TuyaSmartGroup *)group addResponseCode:(NSArray <NSNumber *>*)responseCode;

/// zigbee 设备从网关群组移除响应
/// 1:超过场景数上限 2:子设备超时 3:设置值超出范围 4:写文件错误 5:其他错误
- (void)group:(TuyaSmartGroup *)group removeResponseCode:(NSArray <NSNumber *>*)responseCode;

@end

@interface TuyaSmartGroup : NSObject

@property (nonatomic, strong, readonly) TuyaSmartGroupModel *groupModel;

@property (nonatomic, weak) id<TuyaSmartGroupDelegate> delegate;


/**
 *  获取群组对象
 *
 *  @param groupId 群组Id
 */
+ (instancetype)groupWithGroupId:(NSString *)groupId;

/**
 *  获取群组对象
 *
 *  @param groupId 群组Id
 */
- (instancetype)initWithGroupId:(NSString *)groupId NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;

/**
 *  创建 wifi 设备群组
 *
 *  @param name      群组名称
 *  @param productId 产品Id
 *  @param homeId    家庭Id
 *  @param devIdList 设备Id列表
 *  @param success   操作成功回调
 *  @param failure   操作失败回调
 */
+ (void)createGroupWithName:(NSString *)name
                  productId:(NSString *)productId
                     homeId:(long long)homeId
                  devIdList:(NSArray<NSString *> *)devIdList
                    success:(void (^)(TuyaSmartGroup *group))success
                    failure:(TYFailureError)failure;


/**
 *  根据 productId 获取对应的支持群组的 wifi 设备列表
 *
 *  @param productId 产品Id
 *  @param homeId    家庭Id
 *  @param success   操作成功回调
 *  @param failure   操作失败回调
 */
+ (void)getDevList:(NSString *)productId
            homeId:(long long)homeId
           success:(void(^)(NSArray <TuyaSmartGroupDevListModel *> *list))success
           failure:(TYFailureError)failure;

/**
 *  根据 productId 获取对应群组下的设备列表
 *
 *  @param productId 产品Id
 *  @param success   操作成功回调
 *  @param failure   操作失败回调
 */
- (void)getDevList:(NSString *)productId
           success:(void(^)(NSArray <TuyaSmartGroupDevListModel *> *list))success
           failure:(TYFailureError)failure;

/** 
 *  群组dp命令下发
 *
 *  @param dps 命令字典
 *  @param success 操作成功回调
 *  @param failure 操作失败回调
 */
- (void)publishDps:(NSDictionary *)dps success:(TYSuccessHandler)success failure:(TYFailureError)failure;

/**
 *  修改群组名称
 *
 *  @param name 群组名称
 *  @param success 操作成功回调
 *  @param failure 操作失败回调
 */
- (void)updateGroupName:(NSString *)name success:(TYSuccessHandler)success failure:(TYFailureError)failure;


/**
 *  修改群组设备列表
 *
 *  @param devList 设备Id列表
 *  @param success 操作成功回调
 *  @param failure 操作失败回调
 */
- (void)updateGroupRelations:(NSArray <NSString *>*)devList
                     success:(TYSuccessHandler)success
                     failure:(TYFailureError)failure;

/**
 *  解散群组
 *
 *  @param success 操作成功回调
 *  @param failure 操作失败回调
 */
- (void)dismissGroup:(TYSuccessHandler)success failure:(TYFailureError)failure;


#pragma mark - zigbee

/**
 *  创建 zigbee 设备群组
 *
 *  @param name      群组名称
 *  @param homeId    家庭Id
 *  @param gwId      网关Id
 *  @param productId 产品Id
 *  @param success   操作成功回调
 *  @param failure   操作失败回调
 */
+ (void)createGroupWithName:(NSString *)name
                     homeId:(long long)homeId
                       gwId:(NSString *)gwId
                  productId:(NSString *)productId
                    success:(void (^)(TuyaSmartGroup *))success
                    failure:(TYFailureError)failure;

/**
 *  根据 productId 和 gwId 获取对应的支持群组的 zigbee 子设备列表
 *
 *  @param productId 产品Id
 *  @param gwId      网关Id
 *  @param homeId    家庭Id
 *  @param success   操作成功回调
 *  @param failure   操作失败回调
 */
+ (void)getDevListWithProductId:(NSString *)productId
                           gwId:(NSString *)gwId
                         homeId:(long long)homeId
                        success:(void (^)(NSArray<TuyaSmartGroupDevListModel *> *))success
                        failure:(TYFailureError)failure;

/**
 *  添加zigbee设备到群组(和网关本地交互)
 *
 *  @param nodeList zigbee子设备的短地址
 *  @param success 操作成功回调
 *  @param failure 操作失败回调
 */
- (void)addZigbeeDeviceWithNodeList:(NSArray <NSString *>*)nodeList
                            success:(TYSuccessHandler)success
                            failure:(TYFailureError)failure;

/**
 *  把zigbee设备从群组移除(和网关本地交互)
 *
 *  @param nodeList zigbee子设备的短地址
 *  @param success 操作成功回调
 *  @param failure 操作失败回调
 */
- (void)removeZigbeeDeviceWithNodeList:(NSArray <NSString *>*)nodeList
                               success:(TYSuccessHandler)success
                               failure:(TYFailureError)failure;

/// 取消未完成的操作
- (void)cancelRequest;


@end

#endif
