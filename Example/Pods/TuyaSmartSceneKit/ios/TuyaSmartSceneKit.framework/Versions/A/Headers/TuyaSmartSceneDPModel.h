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
    SceneDisplayTemp = (1 << 5)
} SceneDisplayType;

@class TuyaSmartSchemaModel;

@interface TuyaSmartSceneDPModel : NSObject

@property (nonatomic, assign) NSInteger sceneDPId;

/**
 条件或设备id
 */
@property (nonatomic, assign) NSInteger dpId;

/**
 条件或设备DP id
 */
@property (nonatomic, strong) NSString *entityId;

/**
 条件或设备DP名称
 */
@property (nonatomic, strong) NSString *entityName;

/**
 条件或设备类型 （气象数据 = 3、设备数据 ！= 3）
 */
@property (nonatomic, assign) NSInteger entityType;

/**
 非设备的图标
 */
@property (nonatomic, strong) NSString *iconUrl;

/**
 设备id
 */
@property (nonatomic, strong) NSString *devId;

/**
 条件DP或设备DP取值范围 如：(("dry", "干燥"), ("comfort", "舒适"), ("wet", "潮湿"))
 */
@property (nonatomic, strong) NSArray *valueRangeJson;

/**
 设备属性{"id":1,"desc":"","name":"开关","property":{"type":"bool"},"attr":3,"code":"switch_on","type":"obj","mode":"rw"}
 */
@property (nonatomic, strong) NSString *actDetail;

/**
 DP描述及取值
 */
@property (nonatomic, strong) TuyaSmartSchemaModel *dpModel;

/**
 城市id
 */
@property (nonatomic, strong) NSString *cityId;

/**
 城市名称
 */
@property (nonatomic, strong) NSString *cityName;

//经纬度信息
@property (nonatomic, assign) CLLocationDegrees cityLatitude;
@property (nonatomic, assign) CLLocationDegrees cityLongitude;

/**
 取值关系 如：“["=="]”
 */
@property (nonatomic, strong) NSString *operators;

/**
 条件名称、code、属性等信息
 */
@property (nonatomic, strong) NSDictionary *property;

/**
 条件或设备的DP点id 如：“humidity” 或 “1”
 */
@property (nonatomic, strong) NSString *entitySubId;



/**************业务属性，用户可忽略以下字段**************/
/**
 选择行,-1表示没选择
 */
@property (nonatomic, assign) NSInteger selectedRow;

/**
 操作选择行,-1表示没选择 如：">"
 */
@property (nonatomic, assign) NSInteger selectedOperationRow;

/**
 条件具体内容 (二维数组)
 如：(("$humidity","==","comfort"), (“$dp1”，“==”，“1”), ...)
 */
@property (nonatomic, strong) NSArray *expr;

@end
