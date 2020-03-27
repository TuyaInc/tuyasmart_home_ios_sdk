//
//  TuyaSmartGroup+DpCode.h
//  BlocksKit
//
//  Created by XuChengcheng on 2019/10/2.
//

#import "TuyaSmartGroup.h"

NS_ASSUME_NONNULL_BEGIN

@interface TuyaSmartGroup (DpCode)

#pragma mark - wifi dpCode

/**
*  Creating Groups of Wifi Standard Code Devices
*  创建标准DPCode wifi 设备群组
*
*  @param name      Group name
*  @param homeId    Home ID
*  @param categoryCode category Code
*  @param devIdList DeviceId list
*  @param success   Success block
*  @param failure   Failure block
*/
+ (void)createDpCodeGroupWithName:(NSString *)name
                           homeId:(long long)homeId
                     categoryCode:(NSString *)categoryCode
                        devIdList:(NSArray<NSString *> *)devIdList
                          success:(nullable void (^)(TuyaSmartGroup *group))success
                          failure:(nullable TYFailureError)failure;


/**
*  Get list of WiFi devices that support standard code groups based on category code
*  根据 categoryCode 获取对应的支持标准DPCode群组的 wifi 设备列表
*
*  @param homeId    Home ID
*  @param categoryCode category Code
*  @param success   Success block
*  @param failure   Failure block
*/
+ (void)getDpCodeDevListWithHomeId:(long long)homeId
                      categoryCode:(NSString *)categoryCode
                           success:(nullable void(^)(NSArray <TuyaSmartGroupDevListModel *> *list))success
                           failure:(nullable TYFailureError)failure;


/**
*  Get the device list for the group based
*  获取群组下支持的设备列表
*
*  @param success   Success block
*  @param failure   Failure block
*/
- (void)getDpCodeDevListWithSuccess:(nullable void(^)(NSArray <TuyaSmartGroupDevListModel *> *list))success
                            failure:(nullable TYFailureError)failure;


/**
*  Modify the device list of the group
*  修改群组设备列表
*
*  @param devList Device list
*  @param success Success block
*  @param failure Failure block
*/
- (void)updateDpCodeGroupRelationsWithDevList:(NSArray <NSString *>*)devList
                                      success:(nullable TYSuccessHandler)success
                                      failure:(nullable TYFailureError)failure;


/**
*  Group control command issuance
*  群组dp Code命令下发
*
*  @param dpCodes dp Codes
*  @param success Success block
*  @param failure Failure block
*/
- (void)publishDpCodes:(NSDictionary *)dpCodes
               success:(nullable TYSuccessHandler)success
               failure:(nullable TYFailureError)failure;


@end

NS_ASSUME_NONNULL_END
