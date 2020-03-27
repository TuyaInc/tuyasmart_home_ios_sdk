//
//  TuyaSmartSceneConditionExprBuilder.h
//  TuyaSmartSceneKit
//
//  Created by TuyaInc on 2019/4/19.
//

#import <Foundation/Foundation.h>
#import "TuyaSmartSceneExprModel.h"

typedef enum {
    kExprTypeWhether,
    kExprTypeDevice
}ExprType;

NS_ASSUME_NONNULL_BEGIN

@interface TuyaSmartSceneConditionExprBuilder : NSObject

/**
 zh^
 创建值为bool类型的条件的expr数据对象, 如“开关”这种布尔型dp点类型创建条件时使用。
 zh$
 en^
 Create a exprModel with bool value and condition type.
 en$

 @param type Whether type or device's dpId.
 @param isTrue BOOL value.
 @param exprType To distinguish the entity type.
 @return An ExprModel object.
 */
+ (TuyaSmartSceneExprModel *)createBoolExprWithType:(NSString *)type isTrue:(BOOL)isTrue exprType:(ExprType)exprType;

/**
 zh^
 创建值为枚举类型类型的条件的expr数据对象。
 zh$
 en^
 Create a exprModel with enum string value and condition type.
 en$

 @param type Whether type or device's dpId.
 @param chooseValue enum string value, get it in TuyaSmartSceneDPModel.dpModel.property.range
 @param exprType To distinguish the entity type.
 @return An ExprModel object.
 */
+ (TuyaSmartSceneExprModel *)createEnumExprWithType:(NSString *)type chooseValue:(NSString *)chooseValue exprType:(ExprType)exprType;

/**
 zh^
 创建值为“temp <= 40”形式的expr数据对象。
 zh$
 en^
 Create exprModel like "temp <= 40".
 en$

 @param type Whether type or device's dpId.
 @param operateString @"==",@"<=",@"=="
 @param value selected value
 @param exprType To distinguish the entity type.
 @return An ExprModel object.
 */
+ (TuyaSmartSceneExprModel *)createValueExprWithType:(NSString *)type operater:(NSString *)operateString chooseValue:(NSInteger )value exprType:(ExprType)exprType;

/**
zh^
创建值为“rawType”形式的expr数据对象。
zh$
en^
Create exprModel like "rawType".
en$

@param type Whether type or device's dpId.
@param exprType To distinguish the entity type.
@return An ExprModel object.
*/
+ (TuyaSmartSceneExprModel *)createRawExprWithType:(NSString *)type exprType:(ExprType)exprType;

/**
 zh^
 创建定时器条件。
 zh$
 en^
 Create timer condition.
 en$

 @param timeZoneId timeZoneId like @"Asia/Shanghai"
 @param loops eg: @"0111110", each charactor represent from Sunday to Monday. @"0000000" represent only once.
 @param date eg: @"20190501"
 @param time eg: @"20:40"
 @return An ExprModel object.
 */
+ (TuyaSmartSceneExprModel *)createTimerExprWithTimeZoneId:(NSString *)timeZoneId loops:(NSString *)loops date:(NSString *)date time:(NSString *)time;

@end

NS_ASSUME_NONNULL_END

