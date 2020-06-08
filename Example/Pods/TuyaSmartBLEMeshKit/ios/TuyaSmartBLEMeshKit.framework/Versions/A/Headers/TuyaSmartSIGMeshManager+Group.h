//
//  TuyaSmartSIGMeshManager+Group.h
//  BlocksKit
//
//  Created by 温明妍 on 2019/12/17.
//

#import <TuyaSmartBLEMeshKit/TuyaSmartBLEMeshKit.h>

@interface TuyaSmartSIGMeshManager (Group)

/**
 把设备加入到群组
 
 @param devId 设备 id
 @param groupAddress 群组地址
 */
- (void)addDeviceToGroupWithDevId:(NSString *)devId
                     groupAddress:(uint32_t)groupAddress;



/**
 把设备从群组内移除
 
 @param devId 设备 id
 @param groupAddress 群组地址
 */
- (void)deleteDeviceToGroupWithDevId:(NSString *)devId
                        groupAddress:(uint32_t)groupAddress;


/**
 通过群组地址查询群组中的设备

 @param groupAddress 群组地址
 */
- (void)queryGroupMemberWithGroupAddress:(uint32_t)groupAddress;


@end
