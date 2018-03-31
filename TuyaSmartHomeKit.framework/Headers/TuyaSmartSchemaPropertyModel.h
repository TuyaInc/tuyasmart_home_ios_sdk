//
//  TuyaSmartSchemaPropertyModel.h
//  TuyaSmartKit
//
//  Created by fengyu on 15/9/15.
//  Copyright (c) 2015年 Tuya. All rights reserved.
//

#ifndef TuyaSmart_TuyaSmartSchemaPropertyModel
#define TuyaSmart_TuyaSmartSchemaPropertyModel

#import "TYModel.h"

@interface TuyaSmartSchemaPropertyModel : TYModel


/**
 *  类型： enum - 枚举型 | bool - 布尔型 | string - 字符串型 | value - 数值型 | bitmap - 故障型
 */
@property (nonatomic, strong) NSString   *type;

/**
 *  单位 比如 ℃
 */
@property (nonatomic, strong) NSString   *unit;

/**
 *  数值型的最小值
 */
@property (nonatomic, assign) double     min;

/**
 *  数值型的最大值
 */
@property (nonatomic, assign) double     max;

/**
 *  数值型的步长
 */
@property (nonatomic, assign) double     step;

/**
 *  数值型中表示 10 的指数,乘以对应的传输数值,等于实际值,用于避免小数传输
 */
@property (nonatomic, assign) NSInteger  scale;

/**
 *  故障型的最大位数
 */
@property (nonatomic, assign) NSInteger  maxlen;

/**
 *  故障型的具体描述
 */
@property (nonatomic, strong) NSArray    *label;

/**
 *  枚举型的范围
 */
@property (nonatomic, strong) NSArray    *range;



@end

#endif
