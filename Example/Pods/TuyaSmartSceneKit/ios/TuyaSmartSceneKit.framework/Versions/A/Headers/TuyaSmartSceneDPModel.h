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
 * 条件id或设备id。
 * Id of device or condition.
 */
@property (nonatomic, assign) NSInteger dpId;

/**
 * 产品ID.代表这个dataPoint所属于的产品的id。设备类型的dp才有这个值。
 * Produce ID.This property represent the product's id this datapoints belongs to. Only device's datapoints has this value.
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
 * 非设备dp的图标,比如天气条件的图标。
 * icon url of condition.
 */
@property (nonatomic, strong) NSString *iconUrl;


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
 * 取值关系 如：“["=="]”
 * operators like "["=="]"
 */
@property (nonatomic, strong) NSString *operators;

/**
 * 条件名称、code、属性等信息，具体内容查看dpModel属性。
 * condition name, code , propertys.For details check the dpModel property.
 */
@property (nonatomic, strong) NSDictionary *property;

/**
 * 条件或设备的DP点子id 如：“humidity” 或 “1”。设备使用dpId属性即可。
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




#pragma mark - 业务字段，可忽略。Logic properties blow can be ignored.
/**************辅助业务属性，用户可忽略以下字段**************/
/*******Properties below are used to store user selected value, you can ignore.********/

/**
 * 选择的step,-1表示没选择，需要手动赋值。value类型的，表示从min向上加了x个step。bool类型的，0表示YES，1表示NO。enum类型表示在enum列表中的位置。
 * selected row, -1 means haven't selected, setted by you.
 */
@property (nonatomic, assign) NSInteger selectedRow;

/**
 * 操作选择行,-1表示没选择 如：">"，需要手动赋值。选中的操作符在operators中的index。
 * selected operator, -1 means haven't selected, setted by you.
 */
@property (nonatomic, assign) NSInteger selectedOperationRow;

/**
 * 条件具体内容 (二维数组)，需要手动赋值。
 * 如：(("$humidity","==","comfort"), (“$dp1”，“==”，“1”), ...)
 *
 * expression, eg:(("$humidity","==","comfort"), (“$dp1”，“==”，“1”), ...), setted by you.
 */
@property (nonatomic, strong) NSArray *expr __deprecated;

/**
 * 城市id，需要手动赋值。
 * city Id, setted by you.
 */
@property (nonatomic, strong) NSString *cityId __deprecated;

/**
 * 城市名称，需要手动赋值。
 * city name, setted by you.
 */
@property (nonatomic, strong) NSString *cityName __deprecated;

/**
 * 城市经度，需要手动赋值。
 * city's latitude, setted by you.
 */
@property (nonatomic, assign) CLLocationDegrees cityLatitude __deprecated;

/**
 * 城市纬度，需要手动赋值。
 * city's longitude, setted by you.
 */
@property (nonatomic, assign) CLLocationDegrees cityLongitude __deprecated;

/**
 * 设备Id, 需要手动赋值。
 * device Id，setted by you.
 */
@property (nonatomic, strong) NSString *devId;

/**
 * 废弃属性，表示表中的id。
 * deprecated property.
 */
@property (nonatomic, assign) NSInteger sceneDPId __deprecated;

/**
* DP值的展示类型，见枚举列表
* displayType of this datapoint‘s value.
*/
@property (nonatomic, assign) SceneDisplayType displayType;

@property (nonatomic, strong) NSDictionary *percentDp __deprecated;


@end
