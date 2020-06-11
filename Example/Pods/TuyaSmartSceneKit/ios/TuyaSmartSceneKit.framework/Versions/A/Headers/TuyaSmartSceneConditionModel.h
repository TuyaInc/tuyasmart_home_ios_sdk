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
    AutoTypeDevice = 1, //设备条件
    AutoTypeWhether = 3,    //天气条件
    AutoTypeTimer = 6,  //定时条件
    AutoTypePir = 7,    //人体传感器
    AutoTypeFaceRecognition = 9,    //人脸识别条件
    AutoTypeGeofence = 10,  //地理围栏条件
    AutoTypeLockMemberGoHome = 11,  //家人回家条件
    AutoTypeConditionCalculate = 13,    //设备合成功能条件计算,如某dp持续x小时
    AutoTypeManual = 99,    //“手动执行”条件，本地生成的条件。不保存到云端接口，云端接口也不会返回。 This type of condition should not be saved to server, and server will not return this type of conditon neither.
};


@interface TuyaSmartSceneConditionModel : NSObject<NSCoding>

/**
 * 条件id
 * condition's Id.
 */
@property (nonatomic, strong) NSString *conditionId;

/**
 * 图标的url
 * iconUrl of the conditon's icon.
 */
@property (nonatomic, strong) NSString *iconUrl;

/**
 * 城市Id或设备id, 条件对应的实体的Id。
 * cityId if this condition is a meteorological condition, devId if this is a device condition, @"timer" if this is a timer condition.
 */
@property (nonatomic, strong) NSString *entityId;

/**
 * 城市或设备名称 如：“杭州市” 或 “智能插座”,定时条件设置为“定时”。
 * City name if this is a meteorological condition, device name if this is a device condition, @"timer" if this is a timer conditon.
 */
@property (nonatomic, strong) NSString *entityName;

/**
 * 实体类型，定时、设备类型（设备数据 = 1、气象数据 = 3、定时 = 6、pir人体传感器 = 7、地理围栏 = 10）
 * Entity's type, device as conditon it will be NSInteger 1, 3 for meteorological conditon, 6 for timer conditon, 7 for human body detector conditon, 10 for  geofencing conditon.
 */
@property (nonatomic, assign) TYConditionAutoType entityType;

/**
 * 条件显示内容，如: “湿度 : 舒适” 或 “开关 : 开启"
 * Description of conditon, like "Switch : Open","Humidity : Comfort"
 */
@property (nonatomic, strong) NSString *exprDisplay;

/**
 * 场景id, 可用来保存所属场景。
 * Scene's Id ,can be used to save the scene's Id which this action belonged to.
 */
@property (nonatomic, strong) NSString *scenarioId;

/**
 * 条件或设备的DP点id 如：“humidity” 或 “1”, 定时条件传"timer"。
 * Meteorological condition's subId or device's dpId, timer contion is "timer".
 */
@property (nonatomic, strong) NSString *entitySubIds;

/**
 * 条件表达式
 * 如：("$humidity","==","comfort") 或（“$dp1”，“==”，1）
 * 定时：{timeZoneId = "Asia/Shanghai",loops = "0000000",time = "08:00",date = "20180308"}
 * loops = "0000000"  表示 ： 周日周一周二周三周四周五周六
 * 详情参见文档:https://tuyainc.github.io/tuyasmart_home_ios_sdk_doc/zh-hans/resource/SmartScene.html#%E5%8D%95%E4%B8%AA%E5%9C%BA%E6%99%AF%E6%93%8D%E4%BD%9C
 *
 * Condition's expression, like
 * ("$humidity","==","comfort") or（“$dp1”，“==”，1）
 * timer：{timeZoneId = "Asia/Shanghai",loops = "0000000",time = "08:00",date = "20180308"}
 * loops = "0000000" ,each bit representing from sunday to saturday.
 * Details in Doc: https://tuyainc.github.io/tuyasmart_home_ios_sdk_doc/en/resource/SmartScene.html#smart-scene
 */
@property (nonatomic, strong) NSArray *expr;

/**
 * 条件状态
 * condition's status
 */
@property (nonatomic, assign) TYSceneConditionStatus status;

/**
 * 温度的单位,地理围栏详情等。{"tempUnit":"fahrenheit","Hangzhou City":"cityName"}，{"center":{"latitude":30.273173191721956,"longitude":120.09600875035049},"geotitle":"浙商财富中心B座","radius":180.00011311593616}}
 *
 * Unit of temprature, or geofence detail, {"tempUnit":"fahrenheit","Hangzhou City":"cityName"}，{"center":{"latitude":30.273173191721956,"longitude":120.09600875035049},"geotitle":"浙商财富中心B座","radius":180.00011311593616}}.
 */
@property (nonatomic, strong) NSDictionary *extraInfo;

/**
 * 城市名称
 * city name
 */
@property (nonatomic, strong) NSString *cityName;

@property (nonatomic, assign) CLLocationDegrees cityLatitude;

@property (nonatomic, assign) CLLocationDegrees cityLongitude;

#pragma mark - Recommend info

/**
* 推荐商品id。
* Recommend product id.
*/
@property (nonatomic, copy) NSString *productId;

/**
* 推荐商品图标。
* Recommend product icon.
*/
@property (nonatomic, copy) NSString *productPic;

@end
