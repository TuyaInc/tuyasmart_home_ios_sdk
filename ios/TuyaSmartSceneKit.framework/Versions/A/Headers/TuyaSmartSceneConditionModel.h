//
//  TuyaSmartSceneConditionModel.h
//  TuyaSmartKit
//
//  Created by xuyongbo on 2017/9/5.
//  Copyright © 2017年 Tuya. All rights reserved.
//

#import "TuyaSmartSceneDPModel.h"

#import <CoreLocation/CoreLocation.h>

typedef NS_ENUM(NSInteger, TYSceneConditionStatus)
{
    TYSceneConditionStatusLoading = 0,
    TYSceneConditionStatusSuccess,
    TYSceneConditionStatusOffline,
    TYSceneConditionStatusTimeout,
};


typedef NS_ENUM(NSInteger, TYConditionAutoType)
{
    AutoTypeGeofence = 10,
    AutoTypeTimer = 6,
};


@interface TuyaSmartSceneConditionModel : NSObject

/**
 条件id
 */
@property (nonatomic, strong) NSString *conditionId;

/**
 图标
 */
@property (nonatomic, strong) NSString *iconUrl;

/**
 城市或设备id 新增场景id
 */
@property (nonatomic, strong) NSString *entityId;

/**
 城市或设备名称 如：“杭州市” 或 “智能插座”
 */
@property (nonatomic, strong) NSString *entityName;

/**
 条件、定时、设备类型（气象数据 = 3、设备数据 = 1、定时 = 6、pir倒计时 = 7）
 */
@property (nonatomic, assign) TYConditionAutoType entityType;

/**
 条件显示内容，如: “湿度 : 舒适” 或 “开关 : 开启”
 */
@property (nonatomic, strong) NSString *exprDisplay;

/**
 场景id
 */
@property (nonatomic, strong) NSString *scenarioId;

/**
 条件或设备的DP点id 如：“humidity” 或 “1”
 */
@property (nonatomic, strong) NSString *entitySubIds;

/**
 条件具体内容
 如：("$humidity","==","comfort") 或（“$dp1”，“==”，“1”）
 定时：{timezoneId = "Asia/Shanghai",loops = "0000000",time = "08:00",date = "20180308"}
 loops = "0000000"  表示 ： 周一周二周三周四周五周六周日
 */
@property (nonatomic, strong) NSArray *expr;

/**
 条件状态
 */
@property (nonatomic, assign) TYSceneConditionStatus status;

/**
 温度的单位
 */
@property (nonatomic, strong) NSDictionary *extraInfo;

/**
 城市名称
 */
@property (nonatomic, strong) NSString *cityName;

//经纬度信息
@property (nonatomic, assign) CLLocationDegrees cityLatitude;
@property (nonatomic, assign) CLLocationDegrees cityLongitude;




@end
