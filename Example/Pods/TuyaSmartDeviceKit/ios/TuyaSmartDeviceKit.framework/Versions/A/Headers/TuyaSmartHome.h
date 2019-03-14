//
//  TuyaSmartHome.h
//  TuyaSmartKit
//
//  Created by 冯晓 on 2017/12/18.
//  Copyright © 2017年 Tuya. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TuyaSmartHome;
@class TuyaSmartHomeModel;
@class TuyaSmartDeviceModel;
@class TuyaSmartRoomModel;
@class TuyaSmartGroupModel;
@class TuyaSmartHomeMemberModel;

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

// 群组dp数据更新
- (void)home:(TuyaSmartHome *)home group:(TuyaSmartGroupModel *)group dpsUpdate:(NSDictionary *)dps;

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

@property (nonatomic, copy, readonly) NSArray <TuyaSmartGroupModel *>  *sharedGroupList;

/**
 *  获取 home 对象
 *
 *  @param homeId 家庭Id
 */
+ (instancetype)homeWithHomeId:(long long)homeId;

- (instancetype)init NS_UNAVAILABLE;

#pragma mark - Home

/**
 *  初始化 home 对象之后需要获取家庭的详情，homeModel,roomList,deviceList,groupList 才有数据
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
                       failure:(TYFailureError)failure;


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


#pragma mark - home member

/**
 *  获取家庭成员列表
 *
 *  @param success     操作成功回调
 *  @param failure     操作失败回调
 */
- (void)getHomeMemberListWithSuccess:(void(^)(NSArray <TuyaSmartHomeMemberModel *> *memberList))success
                             failure:(TYFailureError)failure;

/**
 *  添加家庭成员
 *
 *  @param name         家庭成员名字
 *  @param headPic      家庭成员头像
 *  @param countryCode  国家码
 *  @param account      用户账号
 *  @param isAdmin      是否是管理员
 *  @param success      操作成功回调
 *  @param failure      操作失败回调
 */
- (void)addHomeMemberWithName:(NSString *)name
                      headPic:(UIImage *)headPic
                  countryCode:(NSString *)countryCode
                  userAccount:(NSString *)account
                      isAdmin:(BOOL)isAdmin
                      success:(TYSuccessDict)success
                      failure:(TYFailureError)failure;

@end
