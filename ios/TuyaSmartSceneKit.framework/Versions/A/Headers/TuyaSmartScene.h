//
//  TuyaSmartScene.h
//  TuyaSmartSceneKit
//
//  Created by TuyaInc on 2017/9/4.
//  Copyright © 2017年 Tuya. All rights reserved.
//

#import <TuyaSmartUtil/TuyaSmartUtil.h>
#import "TuyaSmartSceneModel.h"
#import "TuyaSmartSceneActionModel.h"
#import "TuyaSmartSceneConditionModel.h"

@interface TuyaSmartScene : NSObject

/**
 * 使用场景数据对象初始化一个TuyaSmartScene对象。
 * Initialize method of TuyaSmartScene.
 *
 * @param sceneModel scene model.
 * @return instance of TuyaSmartScene.
 */
+ (instancetype)sceneWithSceneModel:(TuyaSmartSceneModel *)sceneModel;

/**
 * 使用场景数据对象初始化一个TuyaSmartScene对象。
 * Initialize method of TuyaSmartScene.
 *
 * @param sceneModel scene model.
 * @return instance of TuyaSmartScene.
 */
- (instancetype)initWithSceneModel:(TuyaSmartSceneModel *)sceneModel;

/**
 * 不要使用init进行初始化。
 * Don't initialize an instance with init methed.
 *
 * @return    This method will return an unavailable instance.
 */
- (instancetype)init NS_UNAVAILABLE;

/**
 * 添加场景（已废弃)
 * Add a scene,deprecated.
 *
 * @param name               scene name
 * @param homeId             homeId
 * @param background         background image url
 * @param showFirstPage      show the scene in index page or not
 * @param conditionList      condition list
 * @param actionList         action list
 * @param matchType          Match all conditons/any conditon will execute the automation.
 * @param success            success block
 * @param failure            failure block
 */
+ (void)addNewSceneWithName:(NSString *)name
                     homeId:(long long)homeId
                 background:(NSString *)background
              showFirstPage:(BOOL)showFirstPage
              conditionList:(NSArray<TuyaSmartSceneConditionModel*> *)conditionList
                 actionList:(NSArray<TuyaSmartSceneActionModel*> *)actionList
                  matchType:(TuyaSmartConditionMatchType)matchType
                    success:(void (^)(TuyaSmartSceneModel *sceneModel))success
                    failure:(TYFailureError)failure __deprecated_msg("This method is deprecated, Use -[TuyaSmartScene addNewSceneWithName:homeId:background:showFirstPage:preConditionList:conditionList:actionList:matchType:success:failure:] instead");

/**
 * 添加场景
 * Add a new scene.
 *
 * @param name                   scene name
 * @param homeId                 homeId
 * @param background             background image url
 * @param showFirstPage          show the scene in index page or not
 * @param preConditionList       preconditons, like valid time period.
 * @param conditionList          condition list
 * @param actionList             action list
 * @param matchType              Match all conditons/any conditon will execute the automation.
 * @param success                success block
 * @param failure                failure block
 */
+ (void)addNewSceneWithName:(NSString *)name
                     homeId:(long long)homeId
                 background:(NSString *)background
              showFirstPage:(BOOL)showFirstPage
           preConditionList:(NSArray<TuyaSmartScenePreConditionModel*> *)preConditionList
              conditionList:(NSArray<TuyaSmartSceneConditionModel*> *)conditionList
                 actionList:(NSArray<TuyaSmartSceneActionModel*> *)actionList
                  matchType:(TuyaSmartConditionMatchType)matchType
                    success:(void (^)(TuyaSmartSceneModel *sceneModel))success
                    failure:(TYFailureError)failure;

/**
 * 修改场景(已废弃)
 * Edit a existed scene, deprecated.
 *
 * @param name               scene name
 * @param background         background image url
 * @param showFirstPage      show the scene in index page or not
 * @param conditionList      condition list
 * @param actionList         action list
 * @param matchType          Match all conditons/any conditon will execute the automation.
 * @param success            success block
 * @param failure            failure block
 */
- (void)modifySceneWithName:(NSString *)name
                 background:(NSString *)background
              showFirstPage:(BOOL)showFirstPage
              conditionList:(NSArray<TuyaSmartSceneConditionModel*> *)conditionList
                 actionList:(NSArray<TuyaSmartSceneActionModel*> *)actionList
                  matchType:(TuyaSmartConditionMatchType)matchType
                    success:(TYSuccessHandler)success
                    failure:(TYFailureError)failure __deprecated_msg("This method is deprecated, Use -[TuyaSmartScene modifySceneWithName:background:showFirstPage:preConditionList:conditionList:actionList:matchType:success:failure:] instead");

/**
 * 修改场景
 * Edit a existed scene.
 *
 * @param name               scene name
 * @param background         background image url
 * @param showFirstPage      show the scene in index page or not
 * @param preConditionList       preconditons, like valid time period.
 * @param conditionList      condition list
 * @param actionList         action list
 * @param matchType          Match all conditons/any conditon will execute the automation.
 * @param success            success block
 * @param failure            failure block
 */
- (void)modifySceneWithName:(NSString *)name
                 background:(NSString *)background
              showFirstPage:(BOOL)showFirstPage
           preConditionList:(NSArray<TuyaSmartScenePreConditionModel*> *)preConditionList
              conditionList:(NSArray<TuyaSmartSceneConditionModel*> *)conditionList
                 actionList:(NSArray<TuyaSmartSceneActionModel*> *)actionList
                  matchType:(TuyaSmartConditionMatchType)matchType
                    success:(TYSuccessHandler)success
                    failure:(TYFailureError)failure;

/**
 * 删除场景。
 * Delete a scene.
 *
 * @param success    success callback
 * @param failure    failure callback
 */
- (void)deleteSceneWithSuccess:(TYSuccessHandler)success
                       failure:(TYFailureError)failure;


/**
 * 执行场景
 * Execute a scene.
 *
 * @param success    success callback
 * @param failure    failure callback
 */
- (void)executeSceneWithSuccess:(TYSuccessHandler)success
                        failure:(TYFailureError)failure;


/**
 * 设置一个自动化为关闭状态，不会自动触发。
 * Disable an automation, which will not executed automaticaly.
 *
 * @param success    success callback
 * @param failure    failure callback
 */
- (void)disableSceneWithSuccess:(TYSuccessHandler)success
                        failure:(TYFailureError)failure;


/**
 * 设置一个自动化为生效状态。
 * Enable an automation, which will be executed whild the conditons are matched.
 *
 * @param success    success callback
 * @param failure    failure callback
 */
- (void)enableSceneWithSuccess:(TYSuccessHandler)success
                       failure:(TYFailureError)failure;


/**
 * 取消正在进行的操作。
 * Cancel the request being executed.
 */
- (void)cancelRequest;


@end
