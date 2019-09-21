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

@interface TuyaSmartSceneActionModel : NSObject<NSCoding>

/**
 * 场景动作Id.
 * action's Id.
 */
@property (nonatomic, copy) NSString *actionId;

/**
 * 实体Id，如果动作是设备则是设备Id；如果动作是群组则是groupId；如果是触发一个场景或者设置自动化启动/禁用，则是操作的场景的sceneId；如果是一个延时动作，则是字符串@"delay"。
 * Entity's Id. If action is a device, entityId is devId, and groupId for group action, @"delay" for a delay action, sceneId of operated scene for scene action.
 */
@property (nonatomic, copy) NSString *entityId;

/**
 * 实体名称 如："智能插座","灯群组"等。
 * Entity's name, like "lamp", "lamp group".
 */
@property (nonatomic, copy) NSString *entityName;

/**
 * 场景id, 可用来保存所属场景。
 * Scene's Id ,can be used to save the scene's Id which this action belonged to.
 */
@property (nonatomic, copy) NSString *scenarioId;

/**
 * 动作要做的内容描述 如：“开关 : 关闭”。
 * Describe what this action will do, like "Switch : Open".
 */
@property (nonatomic, copy) NSString *actionDisplay;

/**
 * 动作要做的内容的新版描述，可自行拼成要展示的样式。
 * {
 *   1: [
 *        "开关",
 *        "开启"
 *        ]
 * }
 * Describe what this action will do with origin format like the below example, you can use it to create the description.
 * {
 *    1: [
 *        "Switch",
 *        "Open"
 *        ]
 * },
 */
@property (nonatomic, strong) NSDictionary *actionDisplayNew;

/**
 * 任务执行属性 如："dpIssue","ruleTrigger","ruleEnable","ruleDisable"
 * "dpIssue" 执行设备
 * "deviceGroupDpIssue" 执行群组
 * "irIssue" 执行红外设备
 * "irIssueVii" 执行红外设备（执行参数为真实红外控制码）
 * "ruleTrigger" 触发场景
 * "ruleEnable"  启用场景
 * "ruleDisable" 禁用场景
 * "dealy" 延时
 * The action type, can be the followed types:
 * "dpIssue" :execute a device action.
 * "deviceGroupDpIssue": execute a group action.
 * "irIssue": execete a infrared device, like a air conditoner which is controled by a remote control.
 * "irIssueVii": execete a infrared device, like a air conditoner which is controled by a remote control.ExecutorProperty is real infrared ray remotes control code.
 * "ruleTrigger": execute a scene.
 * "ruleEnable":  Enable an automation.
 * "ruleDisable": Disable an antomation.
 * "dealy": Delay for a while.
 */
@property (nonatomic, strong) NSString *actionExecutor;

/**
 * 执行属性value 如："{"1":true, ...}","1"是dpId，也就是数据点Id,后面跟的值是这个dp点要设置的值。延时动作格式"executorProperty":{"seconds":"5","minutes":"0"}
 * Execute property, like {"1":true, ...}, "1" is dpId, a data point's Id, value is the value you want this datapoint to set. Delay action should be like "executorProperty":{"seconds":"5","minutes":"0"}.
 */
@property (nonatomic, strong) NSDictionary *executorProperty;

/**
 * Zigbee 本地场景使用的字段，保存gId，gwId。
 * Local scene's property, save gId and gwId.
 */
@property (nonatomic, strong) NSDictionary *extraProperty;

/**
 * 执行状态
 * Execute actions, you can use this property to store the execute status when executing.
 */
@property (nonatomic, assign) TYSceneActionStatus status;

#pragma mark - Panel info

/**
 * 面板id，在使用RN面板处理场景动作时云端会返回这个值。
 * panel id, this value will be assigned by cloud server when this action should be oprate by a React Native panel.
 */
@property (nonatomic, copy) NSString *uiid;

@end
