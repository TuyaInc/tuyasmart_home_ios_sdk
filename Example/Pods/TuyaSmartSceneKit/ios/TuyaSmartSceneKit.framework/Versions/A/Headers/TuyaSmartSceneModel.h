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
    TuyaSmartConditionMatchAny = 1,        //满足任一条件/any condition matched will execute the scene.
    TuyaSmartConditionMatchAll      //满足所有条件//all conditions matched
} TuyaSmartConditionMatchType;

typedef enum : NSUInteger {
    TuyaSmartSceneRecommendTypeNone,        //不是推荐场景/This not a recommend scene.
    TuyaSmartSceneRecommendTypeScene,       //推荐的场景类型/This is a normal recommended scene.
    TuyaSmartSceneRecommendTypeAutomation   //推荐的自动化场景类型//This is a recommended automatic scene.
} TuyaSmartSceneRecommendType;

/**
 * 场景Model, 有conditons的场景称为自动化。
 * scene model, we call a scene with conditions "automation".
 */
@interface TuyaSmartSceneModel : NSObject<NSCoding>

/**
 * 场景id （只有自定义场景有该字段）
 * scene's Id, only custom scene has this property.
 */
@property (nonatomic, strong) NSString *sceneId;

/**
 * 场景code (只有默认场景有该字段)
 * scene's code, only default scene has this property.
 */
@property (nonatomic, strong) NSString *code;

/**
 * 场景名称
 * scene name
 */
@property (nonatomic, strong) NSString *name;

/**
 * 自动化场景是否开启
 * automation enable status
 */
@property (nonatomic, assign) BOOL enabled;

/**
 * 是否显示在首页
 * show or not to show in first page.
 */
@property (nonatomic, assign) BOOL stickyOnTop;


/**
 * 场景前置条件,如自动化生效时间
 * preconditions, eg: valid time period of automation.
 */
@property (nonatomic, strong) NSArray <TuyaSmartScenePreConditionModel *> *preConditions;

/**
 * 场景条件
 * conditions of automation.
 */
@property (nonatomic, strong) NSArray <TuyaSmartSceneConditionModel *> *conditions;

/**
 * 场景动作
 * scene actions.
 */
@property (nonatomic, strong) NSArray <TuyaSmartSceneActionModel *> *actions;

/**
 * 设备列表
 * device list
 */
@property (nonatomic, strong) NSArray *devList;

/**
 * 场景icon的url。
 * Scene's icon url.
 */
@property (nonatomic, copy) NSString *coverIcon;

/**
 * 场景的背景色。FFFFFF
 * Scene's background color. FFFFFF
 */
@property (nonatomic, copy) NSString *displayColor;


/**
 * 场景子标题
 * scene subTitle
 */
@property (nonatomic, strong) NSString *subTitle __deprecated;

/**
 * 编辑icon url
 * edit icon url
 */
@property (nonatomic, strong) NSString *editIcon __deprecated;

/**
 * 显示图标
 * display icon
 */
@property (nonatomic, strong) NSString *displayIcon __deprecated;

/**
 * 背景图片url, 目前仅可使用涂鸦提供的图片url。查看TuyaSmartSceneManager中的API。
 * scene background url, when created a new scene, use the url provided by tuya. API in TuyaSmartSceneManager.
 */
@property (nonatomic, strong) NSString *background;

/**
 * matchType == 1  满足任一条件时，执行
 * matchType == 2  满足所有条件时，执行
 *
 * matchType == 1  automation will execute when any conditon is matched.
 * matchType == 2  automation will execute when all conditons are matched.
 */
@property (nonatomic, assign) TuyaSmartConditionMatchType matchType;

/**
 * 是否有场景面板绑定
 * scene is or isn't bound by a panel.
 */
@property (nonatomic, assign) BOOL boundForPanel;

/**
 * 是否有新固件场景面板绑定，此类支持zigbee设备和wifi设备
 * scene is or isn't bound by a panel with new firware, this type of smart support zigbee and wifi devices.
 */
@property (nonatomic, assign) BOOL boundForWiFiPanel;

/**
 * 是否支持本地联动,即自动化场景是否可以在zigbee网关不联网的情况下执行。
 * Support to execute in local network, YES meas this automation can be executed when zigbee gateway is offline.
 */
@property (nonatomic, assign) BOOL localLinkage;

/**
 * 新版本地场景，可以通过tcp或者mqtt协议通知zigbee网关直接执行的场景，由云端打标。
 * New version of local scene, can be triggered via tcp or mqtt protocol to make zigbee gateway execute this scene.This property is assigned by Tuya cloud server.
 */
@property (nonatomic, assign) BOOL newLocalScene;


/**
 * 推荐场景类型
 * Recommend type.
 */
@property (nonatomic, assign) TuyaSmartSceneRecommendType recommendType;

/**
* 推荐场景描述
* Recommend description.
*/
@property (nonatomic, copy) NSString *recomDescription;

/**
* 推荐场景的推荐系数0-100
* Recommend coefficient,0-100.
*/
@property (nonatomic, assign) CGFloat recomCoefficient;

/**
 * 自动化场景将会被自动关闭的时间点的时间戳。0表示未被设置过。
 * The timeStamp when automation will be disabled automatically.0 means net setted.
 */
@property (nonatomic, assign) long long  disableTime;

@end
