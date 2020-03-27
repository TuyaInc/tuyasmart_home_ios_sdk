//
//  TuyaSmartSceneManager.h
//  TuyaSmartSceneKit
//
//  Created by TuyaInc on 2017/9/5.
//  Copyright © 2017年 Tuya. All rights reserved.
//

#import <TuyaSmartDeviceKit/TuyaSmartDeviceKit.h>
#import "TuyaSmartCityModel.h"
#import "TuyaSmartSceneDPModel.h"
#import "TuyaSmartSceneModel.h"

@class TuyaSmartSceneManager;

@protocol TuyaSmartSceneManagerDelegate<NSObject>

@optional

/**
 * 自动化开启状态发生变化的回调。
 * Call back of automation's enable state changed.
 *
 * @param manager     TuyaSmartSceneManager instance.
 * @param state  自动化开启状态，@"enable" 或 @"disable"  enable state, @"enable" or @"disable".
 * @param sceneId     sceneId of the changed automation.
 */
- (void)sceneManager:(TuyaSmartSceneManager *)manager state:(NSString *)state sceneId:(NSString *)sceneId;

@end


@interface TuyaSmartSceneManager : NSObject

/**
 * 单例
 * Singleton
 *
 * @return TuyaSmartSceneManager singleton instance.
 */
+ (instancetype)sharedInstance;

@property (nonatomic, weak) id<TuyaSmartSceneManagerDelegate> delegate;


/**
 * 获取家庭的场景列表,场景和自动化可以通过conditons数组是否为空来区分，conditions大于0说明是一个自动化，否则是普通场景。
 * Get scene and auto list, scene and automation can be differentiated with property conditons.count, conditons over 0 will be automation.
 *
 * @param homeId      homeId
 * @param success  操作成功回调, 返回场景列表  success callback
 * @param failure     failure callback
 */
- (void)getSceneListWithHomeId:(long long)homeId
                       success:(void(^)(NSArray<TuyaSmartSceneModel *> *list))success
                       failure:(TYFailureError)failure;

/**
 * 获取家庭的推荐场景列表
 * Get recommended scene list.
 *
 * @param homeId      homeId
 * @param success  操作成功回调, 返回场景列表  success callback
 * @param failure     failure callback
 */
- (void)getRecommendedSceneListWithHomeId:(long long)homeId
                       success:(void(^)(NSArray<TuyaSmartSceneModel *> *list))success
                       failure:(TYFailureError)failure;

/**
 * 获取自动化支持的气象条件列表
 * Get weather conditon list which automation support.
 *
 * @param fahrenheit      Unit of temperature，if use fahrenheit, set fahrenheit param to YES.
 * @param success         success callback.
 * @param failure          failure callback
 */
- (void)getConditionListWithFahrenheit:(BOOL)fahrenheit
                               success:(void(^)(NSArray<TuyaSmartSceneDPModel *> *list))success
                               failure:(TYFailureError)failure __deprecated_msg("use -getAllConditionListWithFahrenheit:windSpeedUnit:homeId:success:failure instead");


/**
 * 获取自动化支持的所有条件列表，包括气象条件和可能的其他条件
 * Get weather conditon list and other condition list which automation support.
 *
 * @param fahrenheit      Unit of temperature，if use fahrenheit, set fahrenheit param to YES.
 * @param success         success callback. key @"envConditions" is whether conditions,  @"devConditions" is other condtions.
 * @param homeId            homeId
 * @param failure          failure callback
 */
- (void)getAllConditionListWithFahrenheit:(BOOL)fahrenheit
                                   homeId:(long long)homeId
                                  success:(void(^)(NSDictionary *dict))success
                                  failure:(TYFailureError)failure __deprecated_msg("use -getAllConditionListWithFahrenheit:windSpeedUnit:homeId:success:failure instead");

/**
 * 获取自动化支持的所有条件列表，包括气象条件和可能的其他条件
 * Get weather conditon list and other condition list which automation support.
 *
 * @param fahrenheit      Unit of temperature，if use fahrenheit, set fahrenheit param to YES.
 * @param speedUnit      Unit of wind speed,@"mph"、@"m/s"、@"kph"、@"km/h".
 * @param homeId            homeId
 * @param success         success callback. key @"envConditions" is whether conditions,  @"devConditions" is other condtions.
 * @param failure          failure callback
 */
- (void)getAllConditionListWithFahrenheit:(BOOL)fahrenheit
                            windSpeedUnit:(NSString *)speedUnit
                                   homeId:(long long)homeId
                                  success:(void(^)(NSDictionary *dict))success
                                  failure:(TYFailureError)failure;

/**
 * 获取场景中支持的任务设备列表
 * Get devices supported to add to scene's action in home.
 *
 * @param homeId      homeId
 * @param success     success callback
 * @param failure     failure callback
 */
- (void)getActionDeviceListWithHomeId:(long long)homeId
                              success:(void(^)(NSArray<TuyaSmartDeviceModel *> *list))success
                              failure:(TYFailureError)failure;


/**
 * 获取单个房间里面支持作为动作的设备列表
 * Get devices supported to add to scene's action in given room.
 *
 * @param roomId      roomId
 */
- (NSArray<TuyaSmartDeviceModel *> *)getActionDeviceListWithRoomId:(long long)roomId;


/**
 * 获取场景中支持作为条件的设备列表
 * Get devices support to add to scene's conditon in given home.
 *
 * @param homeId      homeId
 * @param success     success callback
 * @param failure     failure callback
 */
- (void)getConditionDeviceListWithHomeId:(long long)homeId
                                 success:(void(^)(NSArray<TuyaSmartDeviceModel *> *list))success
                                 failure:(TYFailureError)failure;


/**
 * 获取房间里面支持作为条件的设备列表
 * Get devices supported to add to scene's condtion in given room.
 *
 * @param roomId      roomId
 */
- (NSArray<TuyaSmartDeviceModel *> *)getConditionDeviceListWithRoomId:(long long)roomId;

/**
 * 获取家庭中支持人脸的条件设备列表.
 * Get devices supported to recognize face, which can be set as automation's conditon.
 *
 * @param homeId      homeId
 * @param success     success callback
 * @param failure     failure callback
 */
- (void)getFaceDeviceListWithHomeId:(long long)homeId success:(void(^)(NSArray<TuyaSmartDeviceModel *> *list))success failure:(TYFailureError)failure;

/**
 * 获取家庭中支持家人回家联动的门锁设备设备列表.
 * Get lock devices supported to be a smart's condition.
 *
 * @param homeId      homeId
 * @param success     success callback
 * @param failure     failure callback
 */
- (void)getLockDeviceListWithHomeId:(long long)homeId success:(void(^)(NSArray<TuyaSmartDeviceModel *> *list))success failure:(TYFailureError)failure;

/**
 * 获取单个房间里面可以作为动作的群组列表。
 * Get groups in specified room which can be used as scene's action.
 *
 * @param roomId      homeId
 */
- (NSArray<TuyaSmartGroupModel *> *)getActionGroupListWithRoomId:(long long)roomId;

/**
 * 获取家庭下可作为场景动作的设备群组列表和设备列表
 * Get groups and devices which can be used as scene's action in specified hoom.
 *
 * @param homeId      homeId
 * @param success     success callback，dict's keys are "groupList" and "deviceList" and @"extendsDictionary", extendsDictionary contains some extra infomation for each device.
 * @param failure     failure
 */
- (void)getActionGroupListAndDeviceListWithHomeId:(long long)homeId success:(void(^)(NSDictionary *dict))success failure:(TYFailureError)failure;

/**
 * 获取作为动作的设备的DP（数据点）列表。
 * Get data point list of specified device which can be used as scene's action.
 *
 * @param devId       device's id
 * @param success     success callback, return the data point list of given device.
 * @param failure     failure callback
 */
- (void)getActionDeviceDPListWithDevId:(NSString *)devId
                               success:(void(^)(NSArray<TuyaSmartSceneDPModel *> *list))success
                               failure:(TYFailureError)failure;


/**
 * 获取作为条件的设备的DP（数据点）列表。
 * Get data point list of specified device which can be used as automation's condition.
 *
 * @param devId       device's id
 * @param success     success callback, return the data point list of given device.
 * @param failure     failure callback
 */
- (void)getCondicationDeviceDPListWithDevId:(NSString *)devId
                                    success:(void(^)(NSArray<TuyaSmartSceneDPModel *> *list))success
                                    failure:(TYFailureError)failure;


/**
 * 获取作为动作的群组的DP（数据点）列表
 * Get data point list of specified group which can be used as scene's action.
 *
 * @param groupId     groupId
 * @param success     success callback, return the data point list of given group.
 * @param failure     failure callback
 */
- (void)getActionGroupDPListWithGroupId:(NSString *)groupId
                                success:(void(^)(NSArray<TuyaSmartSceneDPModel *> *list))success
                                failure:(TYFailureError)failure;

/**
 * 获取城市信息列表（国外少部分国家的城市列表不完整，国外用户建议根据经纬度获取城市信息）
 * Get city list. In addition, city list in area out of china may be not completed, so if users are out of china, we suggest you use lantitude and longitude to get the city infomation.
 *
 * @param countryCode     country code
 * @param success         success callback, return city list.
 * @param failure         failure callback
 */
- (void)getCityListWithCountryCode:(NSString *)countryCode
                           success:(void(^)(NSArray<TuyaSmartCityModel *> *list))success
                           failure:(TYFailureError)failure;


/**
 * 根据经纬度获取城市信息。
 * Get city detail infomation by latitude and longitude.
 *
 * @param latitude        latitude
 * @param longitude       longitude
 * @param success           success callback, return city infomation.
 * @param failure         failure callback
 */
- (void)getCityInfoWithLatitude:(NSString *)latitude
                      longitude:(NSString *)longitude
                        success:(void(^)(TuyaSmartCityModel *model))success
                        failure:(TYFailureError)failure;


/**
 * 根据城市id获取城市详情
 * Get city detail infomation with cityId.
 *
 * @param cityId      cityId
 * @param success     success callback, return city ditail infomation.
 * @param failure     failure callback
 */
- (void)getCityInfoWithCityId:(NSString *)cityId
                      success:(void(^)(TuyaSmartCityModel *model))success
                      failure:(TYFailureError)failure;


/**
 * 场景排序
 * Reorder the scene list.
 *
 * @param homeId              homeId
 * @param sceneIdList         Ordered sceneId list
 * @param success             success callback
 * @param failure             failure callback
 */
- (void)sortSceneWithHomeId:(long long)homeId
                sceneIdList:(NSArray<NSString *> *)sceneIdList
                    success:(TYSuccessHandler)success
                    failure:(TYFailureError)failure;

/**
 * 获取场景背景图标url列表
 * Get scene cover url list.
 *
 * @param success     success callback
 * @param failure     failure callback
 */
- (void)getSmartSceneBackgroundCoverWithsuccess:(TYSuccessList)success failure:(TYFailureError)failure;

/**
* 获取自定义样式数据列表，包括颜色，图标，背景图，key分别对应coverColors，coverIconList，coverPics。
* Get scene custom style resource list. <color,icon,background>, key is <coverColors，coverIconList，coverPics>
*
* @param success     success callback
* @param failure     failure callback
*/
- (void)getSmartSceneCustomStyleListWithSuccess:(TYSuccessDict)success failure:(TYFailureError)failure;

/**
 * 取消正在进行的操作。
 * Cancel the request being executed.
 */
- (void)cancelRequest;

@end
