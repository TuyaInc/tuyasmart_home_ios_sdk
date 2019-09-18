//
//  TuyaSmartSchemaPropertyModel.h
//  TuyaSmartKit
//
//  Created by fengyu on 15/9/15.
//  Copyright (c) 2015年 Tuya. All rights reserved.
//

#ifndef TuyaSmart_TuyaSmartSchemaPropertyModel
#define TuyaSmart_TuyaSmartSchemaPropertyModel

#import <Foundation/Foundation.h>

@interface TuyaSmartSchemaPropertyModel : NSObject


/**
 *  类型： enum - 枚举型 | bool - 布尔型 | string - 字符串型 | value - 数值型 | bitmap - 故障型
 *  type
 */
@property (nonatomic, strong) NSString   *type;

/**
 *  单位 比如 ℃
 *  unit
 */
@property (nonatomic, strong) NSString   *unit;

/**
 *  数值型的最小值
 *  minimum when type is value
 */
@property (nonatomic, assign) double     min;

/**
 *  数值型的最大值
 *  max when type is value
 */
@property (nonatomic, assign) double     max;

/**
 *  数值型的步长
 *  step when type is value
 */
@property (nonatomic, assign) double     step;

/**
 *  数值型中表示 10 的指数,乘以对应的传输数值,等于实际值,用于避免小数传输
 */
@property (nonatomic, assign) NSInteger  scale;

/**
 *  故障型的最大位数
 *  biggest digit fault type
 */
@property (nonatomic, assign) NSInteger  maxlen;

/**
 *  故障型的具体描述
 *  Detailed description of the fault type
 */
@property (nonatomic, strong) NSArray    *label;

/**
 *  枚举型的范围
 *  scope of the enumeration type
 */
@property (nonatomic, strong) NSArray    *range;

/**
 * 用户选择的值，业务字段
 * value of the user to select
 */
@property (nonatomic, assign) NSInteger selectedValue;


@end

#endif
