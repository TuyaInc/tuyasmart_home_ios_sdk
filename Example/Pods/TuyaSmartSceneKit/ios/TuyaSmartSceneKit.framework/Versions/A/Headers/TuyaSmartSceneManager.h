//
//  TuyaSmartSceneManager.h
//  TuyaSmartKit
//
//  Created by xuyongbo on 2017/9/5.
//  Copyright © 2017年 Tuya. All rights reserved.
//

#import <TuyaSmartDeviceKit/TuyaSmartDeviceKit.h>
#import "TuyaSmartCityModel.h"
#import "TuyaSmartSceneDPModel.h"
#import "TuyaSmartSceneModel.h"

@interface TuyaSmartSceneManager : NSObject

/**
 *  单例
 */
+ (instancetype)sharedInstance;


/**
 获取家庭的场景列表
 
 @param homeId  家庭Id
 @param success 操作成功回调, 返回场景列表
 @param failure 操作失败回调
 */
- (void)getSceneListWithHomeId:(long long)homeId
                       success:(void(^)(NSArray<TuyaSmartSceneModel *> *list))success
                       failure:(TYFailureError)failure;


/**
 获取场景支持的条件列表
 
 @param fahrenheit  条件中温度是否是华摄氏度
 @param success     操作成功回调，返回场景条件列表
 @param failure     操作失败回调
 */
- (void)getConditionListWithFahrenheit:(BOOL)fahrenheit
                               success:(void(^)(NSArray<TuyaSmartSceneDPModel *> *list))success
                               failure:(TYFailureError)failure;


/**
 获取场景中支持的任务设备列表
 
 @param homeId  家庭Id
 @param success 操作成功回调，返回任务设备列表
 @param failure 操作失败回调
 */
- (void)getActionDeviceListWithHomeId:(long long)homeId
                              success:(void(^)(NSArray<TuyaSmartDeviceModel *> *list))success
                              failure:(TYFailureError)failure;


/**
 获取单个房间里面支持任务的设备列表
 
 @param roomId  房间Id
 
 */
- (NSArray<TuyaSmartDeviceModel *> *)getActionDeviceListWithRoomId:(long long)roomId;


/**
 获取场景中支持的条件设备列表
 
 @param homeId  家庭Id
 @param success 操作成功回调，返回条件设备列表
 @param failure 操作失败回调
 */
- (void)getConditionDeviceListWithHomeId:(long long)homeId
                                 success:(void(^)(NSArray<TuyaSmartDeviceModel *> *list))success
                                 failure:(TYFailureError)failure;


/**
 获取房间里面支持的条件的设备列表
 
 @param roomId  房间Id
 
 */
- (NSArray<TuyaSmartDeviceModel *> *)getConditionDeviceListWithRoomId:(long long)roomId;


/**
 获取家庭中支持人脸的条件设备列表
 
 @param homeId 家庭Id
 @param success 操作成功回调，返回条件设备列表
 @param failure 操作失败回调
 */
- (void)getFaceDeviceListWithHomeId:(long long)homeId success:(void(^)(NSArray<TuyaSmartDeviceModel *> *list))success failure:(TYFailureError)failure;

/**
 获取单个房间里面支持任务的群组列表
 
 @param roomId  房间Id
 
 */
- (NSArray<TuyaSmartGroupModel *> *)getActionGroupListWithRoomId:(long long)roomId;

/**
 获取家庭支持的动作设备群组列表和设备列表
 
 @param homeId 家庭Id
 @param success 字典dict的key分别为groupList和deviceList
 @param failure failure
 */
- (void)getActionGroupListAndDeviceListWithHomeId:(long long)homeId success:(void(^)(NSDictionary *dict))success failure:(TYFailureError)failure;

/**
 获取任务中的设备的DP列表
 
 @param devId   设备id
 @param success 操作成功回调，返回任务设备DP列表
 @param failure 操作失败回调
 */
- (void)getActionDeviceDPListWithDevId:(NSString *)devId
                               success:(void(^)(NSArray<TuyaSmartSceneDPModel *> *list))success
                               failure:(TYFailureError)failure;


/**
 获取条件中的设备的DP列表
 
 @param devId   设备id
 @param success 操作成功回调，返回条件设备DP列表
 @param failure 操作失败回调
 */
- (void)getCondicationDeviceDPListWithDevId:(NSString *)devId
                                    success:(void(^)(NSArray<TuyaSmartSceneDPModel *> *list))success
                                    failure:(TYFailureError)failure;


/**
 获取任务中的群组的DP列表
 
 @param groupId   群组id
 @param success 操作成功回调，返回任务设备DP列表
 @param failure 操作失败回调
 */
- (void)getActionGroupDPListWithGroupId:(NSString *)groupId
                                success:(void(^)(NSArray<TuyaSmartSceneDPModel *> *list))success
                                failure:(TYFailureError)failure;

/**
 获取城市列表（国外少部分国家的城市列表可能暂时不全，国外用户建议根据经纬度获取城市信息）
 
 @param countryCode 国家码
 @param success     操作成功回调，返回城市列表
 @param failure     操作失败回调
 */
- (void)getCityListWithCountryCode:(NSString *)countryCode
                           success:(void(^)(NSArray<TuyaSmartCityModel *> *list))success
                           failure:(TYFailureError)failure;


/**
 根据经纬度获取城市信息
 
 @param latitude    经度
 @param longitude   纬度
 @param success     操作成功回调，返回城市信息
 @param failure     操作失败回调
 */
- (void)getCityInfoWithLatitude:(NSString *)latitude
                      longitude:(NSString *)longitude
                        success:(void(^)(TuyaSmartCityModel *model))success
                        failure:(TYFailureError)failure;


/**
 根据城市id获取城市信息
 
 @param cityId  城市id
 @param success 操作成功回调，返回城市信息
 @param failure 操作失败回调
 */
- (void)getCityInfoWithCityId:(NSString *)cityId
                      success:(void(^)(TuyaSmartCityModel *model))success
                      failure:(TYFailureError)failure;


/**
 场景排序
 
 @param homeId          家庭id
 @param sceneIdList     场景Id list
 @param success         操作成功回调，返回城市信息
 @param failure         操作失败回调
 */
- (void)sortSceneWithHomeId:(long long)homeId
                sceneIdList:(NSArray<NSString *> *)sceneIdList
                    success:(TYSuccessHandler)success
                    failure:(TYFailureError)failure;


/**
 取消操作
 */
- (void)cancelRequest;

@end
