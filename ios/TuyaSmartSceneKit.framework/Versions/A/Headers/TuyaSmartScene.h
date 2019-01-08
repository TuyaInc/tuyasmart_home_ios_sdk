//
//  TuyaSmartScene.h
//  TuyaSmartKit
//
//  Created by xuyongbo on 2017/9/4.
//  Copyright © 2017年 Tuya. All rights reserved.
//

#import <TuyaSmartUtil/TuyaSmartUtil.h>
#import "TuyaSmartSceneModel.h"
#import "TuyaSmartSceneActionModel.h"
#import "TuyaSmartSceneConditionModel.h"

@interface TuyaSmartScene : NSObject

//自定义场景根据id初始化
+ (instancetype)sceneWithSceneModel:(TuyaSmartSceneModel *)sceneModel;
- (instancetype)initWithSceneModel:(TuyaSmartSceneModel *)sceneModel;

- (instancetype)init NS_UNAVAILABLE;

/**
 添加场景（旧）

 @param name            场景名称
 @param homeId          家庭Id
 @param background      场景背景图片
 @param showFirstPage   是否显示在首页
 @param conditionList   条件list
 @param actionList      任务list
 @param matchType       满足任一条件还是满足所有条件时执行
 @param success         操作成功回调，返回场景
 @param failure         操作失败回调
 */
+ (void)addNewSceneWithName:(NSString *)name
                     homeId:(long long)homeId
                 background:(NSString *)background
              showFirstPage:(BOOL)showFirstPage
              conditionList:(NSArray<TuyaSmartSceneConditionModel*> *)conditionList
                 actionList:(NSArray<TuyaSmartSceneActionModel*> *)actionList
                  matchType:(TuyaSmartConditionMatchType)matchType
                    success:(void (^)(TuyaSmartSceneModel *sceneModel))success
                    failure:(TYFailureError)failure __deprecated_msg("This method is deprecated, Use - “添加场景(新)” - [TuyaSmartScene addNewSceneWithName:homeId:background:showFirstPage:preConditionList:conditionList:actionList:matchType:success:failure:] instead");

/**
 添加场景(新)
 
 @param name                场景名称
 @param homeId              家庭Id
 @param background          场景背景图片
 @param showFirstPage       是否显示在首页
 @param preConditionList    前置条件list，如生效时间段条件
 @param conditionList       条件list
 @param actionList          任务list
 @param matchType           满足任一条件还是满足所有条件时执行
 @param success             操作成功回调，返回场景
 @param failure             操作失败回调
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
 修改场景(旧)

 @param name            场景名称
 @param background      场景背景图片
 @param showFirstPage   是否显示在首页
 @param conditionList   条件list
 @param actionList      任务list
 @param matchType       满足任一条件还是满足所有条件时执行
 @param success         操作成功回调
 @param failure         操作失败回调
 */
- (void)modifySceneWithName:(NSString *)name
                 background:(NSString *)background
              showFirstPage:(BOOL)showFirstPage
              conditionList:(NSArray<TuyaSmartSceneConditionModel*> *)conditionList
                 actionList:(NSArray<TuyaSmartSceneActionModel*> *)actionList
                  matchType:(TuyaSmartConditionMatchType)matchType
                    success:(TYSuccessHandler)success
                    failure:(TYFailureError)failure __deprecated_msg("This method is deprecated, Use - “修改场景(新)” - [TuyaSmartScene modifySceneWithName:background:showFirstPage:preConditionList:conditionList:actionList:matchType:success:failure:] instead");

/**
 修改场景(新)
 
 @param name                场景名称
 @param background          场景背景图片
 @param showFirstPage       是否显示在首页
 @param preConditionList    前置条件list，如生效时间段条件
 @param conditionList       条件list
 @param actionList          任务list
 @param matchType           满足任一条件还是满足所有条件时执行
 @param success             操作成功回调
 @param failure             操作失败回调
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
 删除场景

 @param success 操作成功回调
 @param failure 操作失败回调
 */
- (void)deleteSceneWithSuccess:(TYSuccessHandler)success
                       failure:(TYFailureError)failure;


/**
 执行场景

 @param success 操作成功回调
 @param failure 操作失败回调
 */
- (void)executeSceneWithSuccess:(TYSuccessHandler)success
                        failure:(TYFailureError)failure;


/**
 失效场景
 
 @param success 操作成功回调
 @param failure 操作失败回调
 */
- (void)disableSceneWithSuccess:(TYSuccessHandler)success
                        failure:(TYFailureError)failure;


/**
 开启场景
 
 @param success 操作成功回调
 @param failure 操作失败回调
 */
- (void)enableSceneWithSuccess:(TYSuccessHandler)success
                       failure:(TYFailureError)failure;


/**
 取消操作
 */
- (void)cancelRequest;


@end
