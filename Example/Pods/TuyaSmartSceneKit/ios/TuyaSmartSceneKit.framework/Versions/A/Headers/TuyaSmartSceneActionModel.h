//
//  TuyaSmartSceneActionModel.h
//  TuyaSmartKit
//
//  Created by xuyongbo on 2017/9/4.
//  Copyright © 2017年 Tuya. All rights reserved.
//

#import "TuyaSmartSceneDPModel.h"

typedef NS_ENUM(NSInteger, TYSceneActionStatus)
{
    TYSceneActionStatusLoading = 0,
    TYSceneActionStatusSuccess,
    TYSceneActionStatusOffline,
    TYSceneActionStatusTimeout,
    TYSceneActionStatusDelay,
};

@interface TuyaSmartSceneActionModel : NSObject

/**
 任务id
 */
@property (nonatomic, strong) NSString *actionId;

/**
 设备id
 */
@property (nonatomic, strong) NSString *entityId;

/**
 设备名称 如：“智能插座”
 */
@property (nonatomic, strong) NSString *entityName;

/**
 场景id
 */
@property (nonatomic, strong) NSString *scenarioId;

/**
 任务显示内容 如：“开关 : 关闭”
 */
@property (nonatomic, strong) NSString *actionDisplay;

/**
 任务显示内容
 {
    1: [
        "开关",
        "开启"
        ]
 },
 */
@property (nonatomic, strong) NSDictionary *actionDisplayNew;

/**
 任务执行属性 如："dpIssue","ruleTrigger","ruleEnable","ruleDisable"
 dpIssue 执行设备
 deviceGroupDpIssue 执行群组
 irIssue 执行红外设备
 ruleTrigger 触发场景
 ruleEnable  启用场景
 ruleDisable 禁用场景
 */
@property (nonatomic, strong) NSString *actionExecutor;

/**
 执行属性value 如："{1 = 0, ...}"
 */
@property (nonatomic, strong) NSDictionary *executorProperty;

/**
 zigbee 本地场景
 */
@property (nonatomic, strong) NSDictionary *extraProperty;

/**
 执行状态
 */
@property (nonatomic, assign) TYSceneActionStatus status;


@end
