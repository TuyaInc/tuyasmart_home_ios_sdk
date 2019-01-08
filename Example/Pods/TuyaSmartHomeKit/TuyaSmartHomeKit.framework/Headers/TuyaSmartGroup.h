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

- (void)groupRemove:(TuyaSmartGroup *)group;

@end

@interface TuyaSmartGroup : NSObject

@property (nonatomic, strong, readonly) TuyaSmartGroupModel *groupModel;

@property (nonatomic, weak) id<TuyaSmartGroupDelegate> delegate;


/** 获取群组对象
 @param groupId 群组Id
 */
+ (instancetype)groupWithGroupId:(NSString *)groupId;

/** 获取群组对象
 @param groupId 群组Id
 */
- (instancetype)initWithGroupId:(NSString *)groupId NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;

/**
 *  创建群组
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
 *  根据产品ID获取对应的支持群组的设备列表
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
 *  根据产品ID和群组ID获取对应群组下的设备列表
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
 *  @param dps 命令字典
 *  @param success 操作成功回调
 *  @param failure 操作失败回调
 */
- (void)publishDps:(NSDictionary *)dps success:(TYSuccessHandler)success failure:(TYFailureError)failure;

/** 修改群组名称
 @param name 群组名称
 @param success 操作成功回调
 @param failure 操作失败回调
 */
- (void)updateGroupName:(NSString *)name success:(TYSuccessHandler)success failure:(TYFailureError)failure;


/** 修改群组设备列表
 *  @param devList 设备Id列表
 *  @param success 操作成功回调
 *  @param failure 操作失败回调
 */
- (void)updateGroupRelations:(NSArray <NSString *>*)devList success:(TYSuccessHandler)success failure:(TYFailureError)failure;

/**
 *  解散群组
 *
 *  @param success 操作成功回调
 *  @param failure 操作失败回调
 */
- (void)dismissGroup:(TYSuccessHandler)success failure:(TYFailureError)failure;


/// 取消未完成的操作
- (void)cancelRequest;

@end

#endif
