//
//  TuyaSmartScenePreConditionFactory.h
//  TuyaSmartSceneKit
//
//  Created by TuyaInc on 2019/6/11.
//

#import <Foundation/Foundation.h>
#import <TuyaSmartSceneKit/TuyaSmartSceneKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TuyaSmartScenePreConditionFactory : NSObject

/**
 zh^
 创建全天生效的前置条件
 zh$
 en^
 Create a allday valid precondition.
 en$

 @param sceneId zh^ 所属的场景Id zh$ en^ scene Id en$
 @param conditionId zh^ 如果是编辑生效时间段，需要传递原有的preConditionModel的id zh$ en^ If you created a preconditon and saved the automation,there will be a precondition Id. en$
 @param loops zh^ 格式为"1111111",每一位分别代表周日到周一 zh$ en^ @"1111111" each present from sunday to saturday. en$
 @param timeZoneId zh^ 时区名 如 "Asia/Shanghai" zh$ en^ timeZoneId eg:"Asia/Shanghai" en$
 @return preCondition
 */
+ (TuyaSmartScenePreConditionModel *)creatAllDayPreConditionWithSceneId:(NSString *)sceneId existConditionId:(NSString * __nullable)conditionId loops:(NSString *)loops timeZoneId:(NSString *)timeZoneId;

/**
 zh^
 创建白天生效的前置条件
 zh$
 en^
 Create a daytime valid precondition.
 en$

 @param sceneId zh^ 所属的场景Id zh$ en^ scene Id en$
 @param conditionId zh^ 如果是编辑生效时间段，需要传递原有的preConditionModel的id zh$ en^ If you created a preconditon and saved the automation,there will be a precondition Id. en$
 @param loops zh^ 格式为"1111111",每一位分别代表周日到周一 zh$ en^ @"1111111" each present from sunday to saturday. en$
 @param cityId zh^ 所在城市的城市Id zh$ en^ The cityId of current city. en$
 @param cityName zh^ 所在城市的城市名称 zh$ en^ City name. en$
 @param timeZoneId zh^ 时区名 如 "Asia/Shanghai" zh$ en^ timeZoneId eg:"Asia/Shanghai" en$
 @return preCondition
 */
+ (TuyaSmartScenePreConditionModel *)createDayTimePreConditionWithSceneId:(NSString *)sceneId existConditionId:(NSString * __nullable)conditionId loops:(NSString *)loops cityId:(NSString *)cityId cityName:(NSString *)cityName timeZoneId:(NSString *)timeZoneId;

/**
 zh^
 创建夜间生效的前置条件
 zh$
 en^
 Create a night valid precondition.
 en$

 @param sceneId zh^ 所属的场景Id zh$ en^ scene Id en$
 @param conditionId zh^ 如果是编辑生效时间段，需要传递原有的preConditionModel的id zh$ en^ If you created a preconditon and saved the automation,there will be a precondition Id. en$
 @param loops zh^ 格式为"1111111",每一位分别代表周日到周一 zh$ en^ @"1111111" each present from sunday to saturday. en$
 @param cityId zh^ 所在城市的城市Id zh$ en^ The cityId of current city. en$
 @param cityName zh^ 所在城市的城市名称 zh$ en^ City name. en$
 @param timeZoneId zh^ 时区名 如 "Asia/Shanghai" zh$ en^ timeZoneId eg:"Asia/Shanghai" en$
 @return preCondition
 */
+ (TuyaSmartScenePreConditionModel *)createNightTimePreConditionWithSceneId:(NSString *)sceneId existConditionId:(NSString * __nullable)conditionId loops:(NSString *)loops cityId:(NSString *)cityId cityName:(NSString *)cityName timeZoneId:(NSString *)timeZoneId;

/**
 zh^
 创建自定义时间段生效的前置条件
 zh$
 en^
 Create a valid preconditon of custom time period.
 en$

 @param sceneId zh^ 所属的场景Id zh$ en^ scene Id en$
 @param conditionId zh^ 如果是编辑生效时间段，需要传递原有的preConditionModel的id zh$ en^ If you created a preconditon and saved the automation,there will be a precondition Id. en$
 @param loops zh^ 格式为"1111111",每一位分别代表周日到周一 zh$ en^ @"1111111" each present from sunday to saturday. en$
 @param cityId zh^ 所在城市的城市Id zh$ en^ The cityId of current city. en$
 @param cityName zh^ 所在城市的城市名称 zh$ en^ City name. en$
 @param timeZoneId zh^ 时间段所属的时区名 如 "Asia/Shanghai" zh$ en^ timeZoneId eg:"Asia/Shanghai" en$
 @param begin zh^ 自定义开始时间 eg:"00:59" zh$ en^ custom begin time, eg:"00:59" en$
 @param end zh^ 自定义结束时间 eg:"18:30" zh$ en^ custom end time, eg:"18:30" en$
 @return preCondition
 */
+ (TuyaSmartScenePreConditionModel *)createCustomTimePreConditionWithSceneId:(NSString *)sceneId existConditionId:(NSString * __nullable)conditionId loops:(NSString *)loops cityId:(NSString *)cityId cityName:(NSString *)cityName timeZoneId:(NSString *)timeZoneId beginTime:(NSString *)begin endTime:(NSString *)end;

@end

NS_ASSUME_NONNULL_END

