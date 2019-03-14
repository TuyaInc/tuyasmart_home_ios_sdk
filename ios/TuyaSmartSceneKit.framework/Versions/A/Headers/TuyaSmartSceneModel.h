//
//  TuyaSmartSceneModel.h
//  TuyaSmartKit
//
//  Created by xuyongbo on 2017/9/4.
//  Copyright © 2017年 Tuya. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TuyaSmartSceneActionModel.h"
#import "TuyaSmartSceneConditionModel.h"
#import "TuyaSmartScenePreConditionModel.h"


typedef enum : NSUInteger {
    TuyaSmartConditionMatchAny = 1,        //满足任一条件
    TuyaSmartConditionMatchAll      //满足所有条件
} TuyaSmartConditionMatchType;

/**
 场景Model
 */
@interface TuyaSmartSceneModel : NSObject

/**
 场景id （只有自定义场景有该字段）
 */
@property (nonatomic, strong) NSString *sceneId;

/**
 场景code (只有默认场景有该字段)
 */
@property (nonatomic, strong) NSString *code;

/**
 场景名称
 */
@property (nonatomic, strong) NSString *name;

/**
 场景是否开启
 */
@property (nonatomic, assign) BOOL enabled;

/**
 显示在首页
 */
@property (nonatomic, assign) BOOL stickyOnTop;


/**
 场景前置条件
 */
@property (nonatomic, strong) NSArray <TuyaSmartScenePreConditionModel *> *preConditions;

/**
 场景条件
 */
@property (nonatomic, strong) NSArray <TuyaSmartSceneConditionModel *> *conditions;

/**
 场景任务
 */
@property (nonatomic, strong) NSArray <TuyaSmartSceneActionModel *> *actions;

/**
 设备列表
 */
@property (nonatomic, strong) NSArray *devList;

/**
 场景子标题
 */
@property (nonatomic, strong) NSString *subTitle;

/**
 编辑图标
 */
@property (nonatomic, strong) NSString *editIcon;

/**
 显示图标
 */
@property (nonatomic, strong) NSString *displayIcon;

/**
 背景图片
 */
@property (nonatomic, strong) NSString *background;

/**
 matchType == 1  满足任一条件时，执行
 matchType == 2  满足所有条件时，执行
 */
@property (nonatomic, assign) TuyaSmartConditionMatchType matchType;

/**
 是否有场景面板绑定
 */
@property (nonatomic, assign) BOOL boundForPanel;

/**
 是否支持本地联动
 */
@property (nonatomic, assign) BOOL localLinkage;


@end
