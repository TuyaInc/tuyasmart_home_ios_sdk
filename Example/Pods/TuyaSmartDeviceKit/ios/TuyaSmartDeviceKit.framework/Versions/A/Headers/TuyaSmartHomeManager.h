//
//  TuyaSmartHomeManager.h
//  TuyaSmartKit
//
//  Created by 冯晓 on 2017/12/18.
//  Copyright © 2017年 Tuya. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TuyaSmartHomeModel.h"
#import "TuyaSmartHome.h"

@class TuyaSmartHomeManager;


@protocol TuyaSmartHomeManagerDelegate <NSObject>

@optional

// 添加一个家庭
- (void)homeManager:(TuyaSmartHomeManager *)manager didAddHome:(TuyaSmartHomeModel *)home;

// 删除一个家庭
- (void)homeManager:(TuyaSmartHomeManager *)manager didRemoveHome:(long long)homeId;

// MQTT连接成功
- (void)serviceConnectedSuccess;


@end

@interface TuyaSmartHomeManager : NSObject

@property (nonatomic, weak) id <TuyaSmartHomeManagerDelegate> delegate;

@property (nonatomic, copy, readonly) NSArray <TuyaSmartHomeModel *> *homes;


/**
 *  获取家庭列表，如果要获取具体家庭的详情，需要去初始化一个home，调用接口getHomeDetailWithSuccess:failure:
 *
 *  @param success 操作成功回调
 *  @param failure 操作失败回调
 */
- (void)getHomeListWithSuccess:(void(^)(NSArray <TuyaSmartHomeModel *> *homes))success
                       failure:(TYFailureError)failure;

/**
 *  添加家庭
 *
 *  @param homeName    家庭名字
 *  @param geoName     城市名字
 *  @param rooms       房间列表
 *  @param latitude    维度
 *  @param longitude   经度
 *  @param success     操作成功回调
 *  @param failure     操作失败回调
 */
- (void)addHomeWithName:(NSString *)homeName
                geoName:(NSString *)geoName
                  rooms:(NSArray <NSString *>*)rooms
               latitude:(double)latitude
              longitude:(double)longitude
                success:(TYSuccessLongLong)success
                failure:(TYFailureError)failure;

/**
 *  家庭排序
 *
 *  @param homeList    家庭列表
 *  @param success     操作成功回调
 *  @param failure     操作失败回调
 */
- (void)sortHomeList:(NSArray <TuyaSmartHomeModel *> *)homeList
             success:(TYSuccessHandler)success
             failure:(TYFailureError)failure;

/**
 *  接受或拒绝加⼊家庭
 *
 *  @param homeId       家庭Id
 *  @param isAccept     是否接受邀请
 *  @param success      操作成功回调
 *  @param failure      操作失败回调
 */
- (void)joinFamilyWithHomeId:(long long)homeId
                      action:(BOOL)isAccept
                     success:(TYSuccessBOOL)success
                     failure:(TYFailureError)failure;

@end
