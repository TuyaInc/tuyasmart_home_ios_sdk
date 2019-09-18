//
//  TuyaSmartSceneDPModel.h
//  TuyaSmartKit
//
//  Created by xuyongbo on 2017/9/5.
//  Copyright © 2017年 Tuya. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

typedef enum : NSUInteger {
    SceneDisplayNormal = 1,
    SceneDisplayPercent = (1 << 1),
    SceneDisplayNewPercent = (1 << 2),
    SceneDisplayCountDown = (1 << 3), //倒计时类型
    SceneDisplayBrightness = (1 << 4),
    SceneDisplayTemp = (1 << 5),
    SceneDisplayCountDown1 = (1<< 6) //倒计时类型1
} SceneDisplayType;

@class TuyaSmartSchemaModel;

@interface TuyaSmartSceneDPModel : NSObject

/**
 * 废弃属性
 * deprecated property.
 */
@property (nonatomic, assign) NSInteger sceneDPId __deprecated;

/**
 * 条件id或设备id
 * Id of device or condition.
 */
@property (nonatomic, assign) NSInteger dpId;

/**
 * 条件DP Id或设备DP Id
 * Datapoint Id of device or confition.
 */
@property (nonatomic, strong) NSString *entityId;

/**
 * 条件dp名称或设备DP名称
 * Condition name or datapoint name of device.
 */
@property (nonatomic, strong) NSString *entityName;

/**
 * 条件dp或设备dp类型 （设备数据 = 1、气象数据 = 3、定时 = 6、pir人体传感器 = 7、地理围栏 = 10）
 *
 * Entity's type, device as conditon it will be NSInteger 1, 3 for meteorological conditon, 6 for timer conditon, 7 for human body detector conditon, 10 for  geofencing conditon.
 */
@property (nonatomic, assign) NSInteger entityType;

/**
 * 非设备dp的图标,比如条件的图标。
 * icon url of condition.
 */
@property (nonatomic, strong) NSString *iconUrl;

/**
 * 设备Id
 * device Id.
 */
@property (nonatomic, strong) NSString *devId;

/**
 * 条件DP或设备DP取值范围 如：(("dry", "干燥"), ("comfort", "舒适"), ("wet", "潮湿"))
 *
 * Condition's or device's data point' value range, like "value:{"unit":"","min":10,"max":1000,"scale":0,"step":1,"type":"value"}"
 */
@property (nonatomic, strong) NSArray *valueRangeJson;

/**
 * 设备属性{"id":1,"desc":"","name":"开关","property":{"type":"bool"},"attr":3,"code":"switch_on","type":"obj","mode":"rw"}
 *
 * Propertys of device, like {"id":1,"desc":"","name":"Switch","property":{"type":"bool"},"attr":3,"code":"switch_on","type":"obj","mode":"rw"}
 
 */
@property (nonatomic, strong) NSString *actDetail;

/**
 * DP描述及取值
 * Description of data point and selected value.
 */
@property (nonatomic, strong) TuyaSmartSchemaModel *dpModel;

/**
 * 城市id
 * city Id
 */
@property (nonatomic, strong) NSString *cityId;

/**
 * 城市名称
 * city name
 */
@property (nonatomic, strong) NSString *cityName;

/**
 * 城市经度
 * city's latitude
 */
@property (nonatomic, assign) CLLocationDegrees cityLatitude;

/**
 * 城市纬度
 * city's longitude
 */
@property (nonatomic, assign) CLLocationDegrees cityLongitude;

/**
 * 取值关系 如：“["=="]”
 * operators like "["=="]"
 */
@property (nonatomic, strong) NSString *operators;

/**
 * 条件名称、code、属性等信息
 * condition name, code , propertys.
 */
@property (nonatomic, strong) NSDictionary *property;

/**
 * 条件或设备的DP点子id 如：“humidity” 或 “1”
 * subId of condition or datapoint of device, condition's subId like @"humidity", device data point's subId like "1".
 */
@property (nonatomic, strong) NSString *entitySubId;

/**
 * 所属多控组信息，不属于任何多控组则为空,默认最多有一个多控组,[{"id":123,"groupName":"多控组1"}]
 * Multi control infomation, value is nil if not belong to any multi control group, format:[{"id":123,"groupName":"多控组1"}]
 */
@property (nonatomic, strong) NSArray *mcGroups;

/**
 * dp点额外信息，用于标记dp点的计算类型等额外信息，calType枚举范围:["sum","average","max","min","count","duration"]
 * extra infomation about dp value's calculate type and other extra infomation, calType's range is ["sum","average","max","min","count","duration"].
 */
@property (nonatomic, strong) NSDictionary *condCalExtraInfo;



/**************业务属性，用户可忽略以下字段**************/
/*******Properties below are used to store user selected value, you can ignore.********/

/**
 * 选择行,-1表示没选择
 * selected row, -1 means haven't selected.
 */
@property (nonatomic, assign) NSInteger selectedRow;

/**
 * 操作选择行,-1表示没选择 如：">"
 * selected operator, -1 means haven't selected.
 */
@property (nonatomic, assign) NSInteger selectedOperationRow;

/**
 * 条件具体内容 (二维数组)
 * 如：(("$humidity","==","comfort"), (“$dp1”，“==”，“1”), ...)
 *
 * expression, eg:(("$humidity","==","comfort"), (“$dp1”，“==”，“1”), ...)
 */
@property (nonatomic, strong) NSArray *expr;

@end
