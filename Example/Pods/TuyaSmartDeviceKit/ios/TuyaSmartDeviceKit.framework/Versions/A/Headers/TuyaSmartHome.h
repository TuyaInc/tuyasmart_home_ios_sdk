//
//  TuyaSmartHome.h
//  TuyaSmartKit
//
//  Created by 冯晓 on 2017/12/18.
//  Copyright © 2017年 Tuya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TuyaSmartHomeModel.h"
#import "TuyaSmartDeviceModel.h"
#import "TuyaSmartRoomModel.h"
#import "TuyaSmartGroupModel.h"
#import "TuyaSmartHomeMemberModel.h"

@class TuyaSmartHome;

@protocol TuyaSmartHomeDelegate <NSObject>

@optional

/**
 *  the delegate of home update information, such as the name, online
 *  家庭信息变化代理回调
 *
 *  @param home instance
 */
- (void)homeDidUpdateInfo:(TuyaSmartHome *)home;

/**
 *  the delegate of shared device list update.
 *  设备共享信息变化代理回调
 *
 *  @param home instance
 */
- (void)homeDidUpdateSharedInfo:(TuyaSmartHome *)home;

/**
 *  the delegate of relation update of home and room.(deprecated)
 *  家庭下房间信息信息变化代理回调（已废弃）
 *
 *  @param home instance
 */
- (void)homeDidUpdateRoomInfo:(TuyaSmartHome *)home __deprecated_msg("Use -[TuyaSmartHomeDelegate home:didAddRoom:] or [TuyaSmartHomeDelegate home:didRemoveRoom:] instead.");

/**
 *  the delegate when a new room is added.
 *  家庭下新增房间代理回调
 *
 *  @param home instance
 *  @param room roomModel
 */
- (void)home:(TuyaSmartHome *)home didAddRoom:(TuyaSmartRoomModel *)room;

/**
 *  the delegate when an existing room is removed.
 *  家庭下删除房间代理回调
 *
 *  @param home     instance
 *  @param roomId   roomId
 */
- (void)home:(TuyaSmartHome *)home didRemoveRoom:(long long)roomId;

/**
 *  the delegate of room update information, such as the name.
 *  家庭下房间信息变化代理回调
 *
 *  @param home     instance
 *  @param room     roomModel
 */
- (void)home:(TuyaSmartHome *)home roomInfoUpdate:(TuyaSmartRoomModel *)room;

/**
 *  the delegate of relation update of room, group and device.
 *  房间和设备，群组关系变化代理回调
 *
 *  @param home instance
 *  @param room roomModel
 */
- (void)home:(TuyaSmartHome *)home roomRelationUpdate:(TuyaSmartRoomModel *)room;

/**
 *  the delegate when a new device is added.
 *  家庭下新增设备代理回调
 *
 *  @param home     instance
 *  @param device   deviceModel
 */
- (void)home:(TuyaSmartHome *)home didAddDeivice:(TuyaSmartDeviceModel *)device;

/**
 *  the delegate when an existing device is removed.
 *  家庭下删除设备代理回调
 *
 *  @param home     instance
 *  @param devId    devId
 */
- (void)home:(TuyaSmartHome *)home didRemoveDeivice:(NSString *)devId;

/**
 *  the delegate of device update information, such as the name.
 *  家庭下设备的信息变化代理回调
 *
 *  @param home     instance
 *  @param device   deviceModel
 */
- (void)home:(TuyaSmartHome *)home deviceInfoUpdate:(TuyaSmartDeviceModel *)device;

/**
 *  the delegate of device dps update.
 *  家庭下设备的 dps 变化代理回调
 *
 *  @param home     instance
 *  @param device   deviceModel
 *  @param dps      dps
 */
- (void)home:(TuyaSmartHome *)home device:(TuyaSmartDeviceModel *)device dpsUpdate:(NSDictionary *)dps;

/**
 *  the delegate of warning information update
 *  家庭下设备的告警信息变化的代理回调
 *
 *  @param home         instance
 *  @param device       deviceModel
 *  @param warningInfo  warning Info
 */
- (void)home:(TuyaSmartHome *)home device:(TuyaSmartDeviceModel *)device warningInfoUpdate:(NSDictionary *)warningInfo;

/**
 *  the delegate of device firmware upgrade status update
 *  家庭下设备升级状态的回调
 *
 *  @param home           instance
 *  @param device         deviceModel
 *  @param upgradeStatus  upgrade status
 */
- (void)home:(TuyaSmartHome *)home device:(TuyaSmartDeviceModel *)device upgradeStatus:(TuyaSmartDeviceUpgradeStatus)upgradeStatus;

/**
 *  the delegate when a new group is added.
 *  家庭下新增群组代理回调
 *
 *  @param home     instance
 *  @param group    groupModel
 */
- (void)home:(TuyaSmartHome *)home didAddGroup:(TuyaSmartGroupModel *)group;

/**
 *  the delegate of group dps update.
 *  家庭下群组 dps 变化代理回调
 *
 *  @param home     instance
 *  @param group    groupModel
 *  @param dps      dps
 */
- (void)home:(TuyaSmartHome *)home group:(TuyaSmartGroupModel *)group dpsUpdate:(NSDictionary *)dps;

/**
 *  the delegate when an existing group is removed.
 *  家庭下删除群组代理回调
 *
 *  @param home     instance
 *  @param groupId  groupId
 */
- (void)home:(TuyaSmartHome *)home didRemoveGroup:(NSString *)groupId;

/**
 *  the delegate of group update information, such as the name.
 *  家庭下群组基本信息变化（例如群组名字等）代理回调
 *
 *  @param home     instance
 *  @param group    groupModel
 */
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
 *  Init home
 *
 *  @param homeId Home Id
 *  @return instance
 */
+ (instancetype)homeWithHomeId:(long long)homeId;

- (instancetype)init NS_UNAVAILABLE;

#pragma mark - Home

/**
 *  After init home, need to get home details
 *  初始化 home 对象之后需要获取家庭的详情，homeModel,roomList,deviceList,groupList 才有数据
 *
 *  @param success     Success block
 *  @param failure     Failure block
 */
- (void)getHomeDetailWithSuccess:(void (^)(TuyaSmartHomeModel *homeModel))success
                         failure:(TYFailureError)failure;

/**
 *  Update home info,API version 3.0
 *  修改家庭信息 API version 2.0
 *
 *  @param homeName    Home name
 *  @param geoName     City name
 *  @param latitude    Lat
 *  @param longitude   Lon
 *  @param success     Success block
 *  @param failure     Failure block
 */
- (void)updateHomeInfoWithName:(NSString *)homeName
                       geoName:(NSString *)geoName
                      latitude:(double)latitude
                     longitude:(double)longitude
                       success:(TYSuccessHandler)success
                       failure:(TYFailureError)failure;


/**
 *  Update home info,API version 3.0
 *  修改家庭信息 API version 3.0
 *
 *  @param homeName    Home name
 *  @param geoName     City name
 *  @param latitude    Lat
 *  @param longitude   Lon
 *  @param rooms       Room name array
 *  @param overWriteRoom     NSDictionary now only support "overWriteRoom":boolean
 *  @param success     Success block
 *  @param failure     Failure block
 */
- (void)updateHomeInfoWithName:(NSString *)homeName
                       geoName:(NSString *)geoName
                      latitude:(double)latitude
                     longitude:(double)longitude
                         rooms:(NSArray *)rooms
                 overWriteRoom:(BOOL)overWriteRoom
                       success:(TYSuccessHandler)success
                       failure:(TYFailureError)failure;

/**
 *  Remove a home
 *  解散家庭
 *
 *  @param success     Success block
 *  @param failure     Failure block
 */
- (void)dismissHomeWithSuccess:(TYSuccessHandler)success
                       failure:(TYFailureError)failure;

/**
 *  order all device or group
 *  对整个家庭下设备和群组进行排序
 *
 *  @param orderList order list [@"devId", @"groupId"]
 *  @param success Success block
 *  @param failure Failure block
 */
- (void)sortDeviceOrGroupWithOrderList:(NSArray<NSDictionary *> *)orderList
                               success:(TYSuccessHandler)success
                               failure:(TYFailureError)failure;


#pragma mark - Room

/**
 *  Add a new room
 *  新增房间
 *
 *  @param name        Room name
 *  @param success     Success block
 *  @param failure     Failure block
 */
- (void)addHomeRoomWithName:(NSString *)name
                    success:(TYSuccessHandler)success
                    failure:(TYFailureError)failure;

/**
 *  Remove a room
 *  解散房间
 *
 *  @param roomId      Home Id
 *  @param success     Success block
 *  @param failure     Failure block
 */
- (void)removeHomeRoomWithRoomId:(long long)roomId
                         success:(TYSuccessHandler)success
                         failure:(TYFailureError)failure;

/**
 *  Homes sort
 *  房间排序
 *
 *  @param roomList    Homes list
 *  @param success     Success block
 *  @param failure     Failure block
 */
- (void)sortRoomList:(NSArray <TuyaSmartRoomModel *> *)roomList
             success:(TYSuccessHandler)success
             failure:(TYFailureError)failure;


#pragma mark - home member

/**
 *  Get home member list
 *  获取家庭成员列表
 *
 *  @param success     Success block
 *  @param failure     Failure block
 */
- (void)getHomeMemberListWithSuccess:(void(^)(NSArray <TuyaSmartHomeMemberModel *> *memberList))success
                             failure:(TYFailureError)failure;

/**
 *  Add a home member
 *  添加家庭成员
 *
 *  @param name         Member name
 *  @param headPic      Member portrait
 *  @param countryCode  Country code
 *  @param account      User account
 *  @param isAdmin      Whether the administrator
 *  @param success      Success block
 *  @param failure      Failure block
 */
- (void)addHomeMemberWithName:(NSString *)name
                      headPic:(UIImage *)headPic
                  countryCode:(NSString *)countryCode
                  userAccount:(NSString *)account
                      isAdmin:(BOOL)isAdmin
                      success:(TYSuccessDict)success
                      failure:(TYFailureError)failure;

/**
 *  Accept or reject to shared home
 *  接受或拒绝加⼊分享过来的家庭
 *
 *  @param accept       Whether to accept the invitation
 *  @param success      Success block
 *  @param failure      Failure block
 */
- (void)joinFamilyWithAccept:(BOOL)accept
                     success:(TYSuccessBOOL)success
                     failure:(TYFailureError)failure;


@end
