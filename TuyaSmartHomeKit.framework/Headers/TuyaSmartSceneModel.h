//
//  TuyaSmartSceneModel.h
//  TuyaSmartKit
//
//  Created by xuyongbo on 2017/9/4.
//  Copyright © 2017年 Tuya. All rights reserved.
//

#import "TYModel.h"

@class TuyaSmartSceneActionModel;
@class TuyaSmartSceneConditionModel;


typedef enum : NSUInteger {
    TuyaSmartConditionMatchAny = 1,        //满足任一条件
    TuyaSmartConditionMatchAll      //满足所有条件
} TuyaSmartConditionMatchType;

/**
 场景Model
 */
@interface TuyaSmartSceneModel : TYModel

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
 场景条件
 */
@property (nonatomic, strong) NSMutableArray <TuyaSmartSceneConditionModel *> *conditions;

/**
 场景任务
 */
@property (nonatomic, strong) NSMutableArray <TuyaSmartSceneActionModel *> *actions;

/**
 是否有离线设备
 */
@property (nonatomic, assign) BOOL offline;

/**
 是否有设备全部离线
 */
@property (nonatomic, assign) BOOL allOffline;

/**
 是否有设备被全部移除
 */
@property (nonatomic, assign) BOOL deviceRemoved;

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
 是否有设备离线

 @return 离线状态
 */
- (BOOL)getOfflineStatus;

/**
 是否所有设备离线

 @return 离线状态
 */
- (BOOL)getAllOfflineStatus;

/**
 是否有设备被全部移除

 @return 移除状态
 */
- (BOOL)getDeviceRemovedStatus;

@end
