//
//  TuyaSmartHome.h
//  TuyaSmartKit
//
//  Created by 冯晓 on 2017/12/18.
//  Copyright © 2017年 Tuya. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TuyaSmartHomeModel.h"
#import "TuyaSmartHomeMemberModel.h"
#import "TuyaSmartRoomModel.h"

@class TuyaSmartHome;
@class TuyaSmartDeviceModel;
@class TuyaSmartRoomModel;
@class TuyaSmartGroupModel;

@protocol TuyaSmartHomeDelegate <NSObject>

@optional

// 家庭的信息更新，例如name
- (void)homeDidUpdateInfo:(TuyaSmartHome *)home;

// 家庭和房间关系变化
- (void)homeDidUpdateRoomInfo:(TuyaSmartHome *)home;

// 我收到的共享设备列表变化
- (void)homeDidUpdateSharedInfo:(TuyaSmartHome *)home;

// 房间信息变更，例如name
- (void)home:(TuyaSmartHome *)home roomInfoUpdate:(TuyaSmartRoomModel *)room;

// 房间与设备，群组的关系变化
- (void)home:(TuyaSmartHome *)home roomRelationUpdate:(TuyaSmartRoomModel *)room;

// 添加设备
- (void)home:(TuyaSmartHome *)home didAddDeivice:(TuyaSmartDeviceModel *)device;

// 删除设备
- (void)home:(TuyaSmartHome *)home didRemoveDeivice:(NSString *)devId;

// 设备信息更新，例如name
- (void)home:(TuyaSmartHome *)home deviceInfoUpdate:(TuyaSmartDeviceModel *)device;

// 设备dp数据更新
- (void)home:(TuyaSmartHome *)home device:(TuyaSmartDeviceModel *)device dpsUpdate:(NSDictionary *)dps;

// 添加群组
- (void)home:(TuyaSmartHome *)home didAddGroup:(TuyaSmartGroupModel *)group;

// 删除群组
- (void)home:(TuyaSmartHome *)home didRemoveGroup:(NSString *)groupId;

// 群组信息更新，例如name
- (void)home:(TuyaSmartHome *)home groupInfoUpdate:(TuyaSmartGroupModel *)group;


@end

@interface TuyaSmartHome : NSObject

@property (nonatomic, weak) id <TuyaSmartHomeDelegate> delegate;

@property (nonatomic, strong, readonly) TuyaSmartHomeModel *homeModel;

@property (nonatomic, copy, readonly) NSArray <TuyaSmartRoomModel *> *roomList;

@property (nonatomic, copy, readonly) NSArray <TuyaSmartDeviceModel *> *deviceList;

@property (nonatomic, copy, readonly) NSArray <TuyaSmartGroupModel *> *groupList;

@property (nonatomic, copy, readonly) NSArray <TuyaSmartDeviceModel *> *sharedDeviceList;

@property (nonatomic, strong, readonly) TuyaSmartBleMeshModel *meshModel;


/**
 获取 home 对象
 
 @param roomId
 */
+ (instancetype)homeWithHomeId:(long long)homeId;

- (instancetype)init NS_UNAVAILABLE;

#pragma mark - Home

/**
 *  获取家庭的信息
 *
 *  @param success     操作成功回调
 *  @param failure     操作失败回调
 */
- (void)getHomeDetailWithSuccess:(void (^)(TuyaSmartHomeModel *homeModel))success
                         failure:(TYFailureError)failure;

/**
 *  修改家庭信息
 *
 *  @param homeName    家庭名字
 *  @param geoName     城市名字
 *  @param latitude    维度
 *  @param longitude   经度
 *  @param success     操作成功回调
 *  @param failure     操作失败回调
 */
- (void)updateHomeInfoWithName:(NSString *)homeName
                       geoName:(NSString *)geoName
                      latitude:(double)latitude
                     longitude:(double)longitude
                       success:(TYSuccessHandler)success
                       failure:(TYFailureError)failure;

/**
 *  解散家庭
 *
 *  @param success     操作成功回调
 *  @param failure     操作失败回调
 */
- (void)dismissHomeWithSuccess:(TYSuccessHandler)success
            failure:(TYFailureError)faiure;


#pragma mark - Room

/**
 *  新增房间
 *
 *  @param name        房间的名字
 *  @param success     操作成功回调
 *  @param failure     操作失败回调
 */
- (void)addHomeRoomWithName:(NSString *)name
                    success:(TYSuccessHandler)success
                    failure:(TYFailureError)failure;

/**
 *  解散房间
 *
 *  @param roomId      房间Id
 *  @param success     操作成功回调
 *  @param failure     操作失败回调
 */
- (void)removeHomeRoomWithRoomId:(long long)roomId
                         success:(TYSuccessHandler)success
                         failure:(TYFailureError)failure;

/**
 *  房间排序
 *
 *  @param roomList    房间list
 *  @param success     操作成功回调
 *  @param failure     操作失败回调
 */
- (void)sortRoomList:(NSArray <TuyaSmartRoomModel *> *)roomList
             success:(TYSuccessHandler)success
             failure:(TYFailureError)failure;

#pragma mark - mesh

/**
 *  获取家庭下的mesh列表
 *
 *  @param success     操作成功回调
 *  @param failure     操作失败回调
 */
- (void)getMeshListWithSuccess:(void(^)(NSArray <TuyaSmartBleMeshModel *> *list))success
                       failure:(TYFailureError)failure;

@end
