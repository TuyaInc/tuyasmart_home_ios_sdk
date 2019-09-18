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

// room model
@property (nonatomic, strong, readonly) TuyaSmartRoomModel *roomModel;

// device list
@property (nonatomic, strong, readonly) NSArray <TuyaSmartDeviceModel *> *deviceList;

// group list
@property (nonatomic, strong, readonly) NSArray <TuyaSmartGroupModel *> *groupList;


/**
 *  Get room instance
 *  获取 room 对象
 *
 *  @param roomId Room ID
 *  @param homeId Home ID
 *  @return instance
 */
+ (instancetype)roomWithRoomId:(long long)roomId homeId:(long long)homeId;

/**
 *  Get room instance
 *  获取 room 对象
 *
 *  @param roomId Room ID
 *  @param homeId Home ID
 *  @return instance
 */
- (instancetype)initWithRoomId:(long long)roomId homeId:(long long)homeId NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;

/**
 *  Rename the room
 *  更新房间名字
 *
 *  @param roomName    Room name
 *  @param success     Success block
 *  @param failure     Failure block
 */
- (void)updateRoomName:(NSString *)roomName success:(TYSuccessHandler)success failure:(TYFailureError)failure;

/**
 *  Add device to the room
 *  添加设备到房间
 *
 *  @param deviceId    Device ID
 *  @param success     Success block
 *  @param failure     Failure block
 */
- (void)addDeviceWithDeviceId:(NSString *)deviceId success:(TYSuccessHandler)success failure:(TYFailureError)failure;

/**
 *  Remove device from the room
 *  从房间中移除设备
 *
 *  @param deviceId    Device ID
 *  @param success     Success block
 *  @param failure     Failure block
 */
- (void)removeDeviceWithDeviceId:(NSString *)deviceId success:(TYSuccessHandler)success failure:(TYFailureError)failure;


/**
 *  Add group to the room
 *  添加群组到房间
 *
 *  @param groupId     Group ID
 *  @param success     Success block
 *  @param failure     Failure block
 */
- (void)addGroupWithGroupId:(NSString *)groupId success:(TYSuccessHandler)success failure:(TYFailureError)failure;

/**
 *  Remove group from the room
 *  从房间中移除群组
 *
 *  @param groupId     Group ID
 *  @param success     Success block
 *  @param failure     Failure block
 */
- (void)removeGroupWithGroupId:(NSString *)groupId success:(TYSuccessHandler)success failure:(TYFailureError)failure;

/**
 *  Batch modification of the relationship between rooms, groups and devices
 *  批量修改房间与群组、设备的关系
 *
 *  @param deviceGroupList  List of devices or groups
 *  @param success          Success block
 *  @param failure          Failure block
 */
- (void)saveBatchRoomRelationWithDeviceGroupList:(NSArray <NSString *> *)deviceGroupList
                                         success:(TYSuccessHandler)success
                                         failure:(TYFailureError)failure;


@end
