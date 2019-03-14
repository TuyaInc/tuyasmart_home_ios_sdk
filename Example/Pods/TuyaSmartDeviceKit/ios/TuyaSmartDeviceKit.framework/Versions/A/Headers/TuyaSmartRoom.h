//
//  TuyaSmartRoom.h
//  TuyaSmartKit
//
//  Created by 冯晓 on 2017/12/18.
//  Copyright © 2017年 Tuya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TuyaSmartRoomModel.h"
#import "TuyaSmartDeviceModel.h"
#import "TuyaSmartGroupModel.h"

@interface TuyaSmartRoom : NSObject

// 房间Model
@property (nonatomic, strong, readonly) TuyaSmartRoomModel *roomModel;

// 房间下的设备列表
@property (nonatomic, strong, readonly) NSArray <TuyaSmartDeviceModel *> *deviceList;

// 房间下的群组列表
@property (nonatomic, strong, readonly) NSArray <TuyaSmartGroupModel *> *groupList;


/**
 获取 room 对象
 
 @param roomId 房间Id
 @param homeId 家庭Id
 */
+ (instancetype)roomWithRoomId:(long long)roomId homeId:(long long)homeId;

/**
 获取 room 对象
 
 @param roomId 房间Id
 @param homeId 家庭Id
 */
- (instancetype)initWithRoomId:(long long)roomId homeId:(long long)homeId NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;

/**
 更新房间名字
 
 @param roomName    房间名字
 @param success     操作成功回调
 @param failure     操作失败回调
 */
- (void)updateRoomName:(NSString *)roomName success:(TYSuccessHandler)success failure:(TYFailureError)failure;

/**
 添加设备到房间
 
 @param deviceId    设备Id
 @param success     操作成功回调
 @param failure     操作失败回调
 */
- (void)addDeviceWithDeviceId:(NSString *)deviceId success:(TYSuccessHandler)success failure:(TYFailureError)failure;

/**
 从设备中移除设备
 
 @param deviceId    设备Id
 @param success     操作成功回调
 @param failure     操作失败回调
 */
- (void)removeDeviceWithDeviceId:(NSString *)deviceId success:(TYSuccessHandler)success failure:(TYFailureError)failure;


/**
 添加群组到房间
 
 @param groupId     群组Id
 @param success     操作成功回调
 @param failure     操作失败回调
 */
- (void)addGroupWithGroupId:(NSString *)groupId success:(TYSuccessHandler)success failure:(TYFailureError)failure;

/**
 从设备中移除群组
 
 @param groupId     群组Id
 @param success     操作成功回调
 @param failure     操作失败回调
 */
- (void)removeGroupWithGroupId:(NSString *)groupId success:(TYSuccessHandler)success failure:(TYFailureError)failure;

/**
 批量修改房间与群组、设备的关系
 
 @param deviceGroupList  设备或者群组list
 @param success     操作成功回调
 @param failure     操作失败回调
 */
- (void)saveBatchRoomRelationWithDeviceGroupList:(NSArray <NSString *> *)deviceGroupList
                                         success:(TYSuccessHandler)success
                                         failure:(TYFailureError)failure;


@end
