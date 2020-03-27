//
//  TuyaSmartSceneActionFactory.h
//  TuyaSmartSceneKit
//
//  Created by TuyaInc on 2019/4/19.
//

#import <Foundation/Foundation.h>
#import <TuyaSmartSceneKit/TuyaSmartSceneKit.h>

typedef enum : NSInteger {
    kAutoSwitchTypeEnable,
    kAutoSwitchTypeDisable
}AutoSwitchType;

//为了方便处理多语言，本类不处理动作的actionDisplay和actionDisplayNew字段，也就是动作显示相关的逻辑，需要上层自行拼装处理。这两个字段在新建的时候由开发者自己拼接，保存的时候云端会根据executerProperty和接口的语言环境生成，不会使用开发者使用接口保存的字段。

NS_ASSUME_NONNULL_BEGIN

@interface TuyaSmartSceneActionFactory : NSObject

/**
 zh^
 创建一个设备dp动作
 zh$
 en^
 Create a device action with device's datapoint.
 en$
 
 @param devId zh^ 设备Id zh$ en^ device's Id en$
 @param devName zh^ 设备名称 zh$ en^ device's name en$
 @param executerProperty zh^ 要执行的任务 格式: { dpId: dp点值 } 例：{"1":@(YES)} zh$ en^ action to execute, format:{dpId: <dpId's value>} eg: {"1":true}en$
 @param extraProperty zh^ 额外信息如百分比类型，非必传 zh$ en^ action's extraProperty,if needed en$
 @return action model
 */
+ (TuyaSmartSceneActionModel *)createDeviceDpActionWithDevId:(NSString *)devId devName:(NSString *)devName executerProperty:(NSDictionary *)executerProperty extraProperty:(NSDictionary *)extraProperty;

/**
 zh^
 创建一个群组dp动作
 zh$
 en^
 Create a group action with group's datapoint.
 en$
 
 @param groupId zh^ 群组Id zh$ en^ group's Id en$
 @param groupName zh^ 群组名称 zh$ en^ group's name en$
 @param executerProperty zh^ 要执行的群组任务 格式: { dpId: dp点值 } 例：{"1":@(YES)} zh$ en^ action to execute, format:{dpId: <dpId's value>} eg: {"1":true}en$
 @param extraProperty zh^ 额外信息如百分比类型，非必传 zh$ en^ action's extraProperty,if needed en$
 @return action model
 */
+ (TuyaSmartSceneActionModel *)createGroupDpActionWithGroupId:(NSString *)groupId groupName:(NSString *)groupName executerProperty:(NSDictionary *)executerProperty extraProperty:(NSDictionary *)extraProperty;

/**
 zh^
 创建一个执行某场景的动作
 zh$
 en^
 Create a action to trigger a scene.
 en$

 @param sceneId zh^ 场景Id zh$ en^ scene Id en$
 @param sceneName zh^ 场景名称 zh$ en^ scene name en$
 @return action model
 */
+ (TuyaSmartSceneActionModel *)createTriggerSceneActionWithSceneId:(NSString *)sceneId sceneName:(NSString *)sceneName;

/**
 zh^
 创建一个开关某个自动化的动作
 zh$
 en^
 Create a action to enable/disable a automation.
 en$

 @param sceneId zh^ 场景Id zh$ en^ scene Id en$
 @param sceneName zh^ 场景名称 zh$ en^ scene name en$
 @param type zh^ 操作类型 zh$ en^ operation type en$
 @return action model
 */
+ (TuyaSmartSceneActionModel *)createSwitchAutoActionWithSceneId:(NSString *)sceneId sceneName:(NSString *)sceneName type:(AutoSwitchType)type;

/**
 zh^
 创建一个延时动作
 zh$
 en^
 Create a delay action.
 en$

 @param hours zh^ 小时数0-5 zh$ en^ hours,range 0-5 en$
 @param minutes zh^ 分钟数0-59 zh$ en^ minutes,range 0-59 en$
 @param seconds zh^ 秒数 0-59 zh$ en^ seconds,range 0-59 en$
 @return action model
 */
+ (TuyaSmartSceneActionModel *)createDelayActionWithHours:(NSString *)hours minutes:(NSString *)minutes seconds:(NSString *)seconds;

/**
 zh^
 创建一个推送通知动作
 zh$
 en^
 Create a push notification action.
 en$

 @return action model
 */
+ (TuyaSmartSceneActionModel *)createSendNotificationAction;

/**
 zh^
 创建一个电话通知动作(内部使用，不开放)。
 zh$
 en^
 Create a call notification action(internal use, not open).
 en$
 
 @return action model
 */
+ (TuyaSmartSceneActionModel *)createCallAction;

/**
 zh^
 创建一个短信通知动作(内部使用，不开放)。
 zh$
 en^
 Create a send sms action(internal use, not open).
 en$
 
 @return action model
 */
+ (TuyaSmartSceneActionModel *)createSmsAction;

@end

NS_ASSUME_NONNULL_END

