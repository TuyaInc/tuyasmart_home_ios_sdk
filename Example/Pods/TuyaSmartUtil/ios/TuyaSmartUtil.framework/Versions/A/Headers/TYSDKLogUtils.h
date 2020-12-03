//
//  TYLogUtils.h
//  TuyaSmartKit
//
//  Created by 冯晓 on 2017/2/14.
//  Copyright © 2017年 Tuya. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TYSDKLogUtils : NSObject

//byte 字节打印
+ (void)tysdk_logByte:(uint8_t *)bytes len:(int)len str:(NSString *)str;

+ (void)tysdk_eventWithType:(NSString *)type attribute:(NSDictionary *)attribute;

+ (void)tysdk_eventWithType:(NSString *)type attribute:(NSDictionary *)attribute identifier:(NSString *)identifier;

/* 开始一个（时长类）事件
 
 @params type 事件名称
 @params attributes 公共事件参数
 @params infos 事件信息
 @params identifier 事件ID（调用 [xxx ty_apm_identifier] 生成）
 @params trackType 连路点状态  （trackType = @”begin“ 开始 / @"track" 发送/ @"end" 结束）
 
 */
+ (void)tysdk_eventWithType:(NSString *)type attribute:(NSDictionary *)attribute infos:(NSDictionary *)infos trackType:(NSString *)trackType identifier:(NSString *)identifier;

+ (NSString *)tysdk_eventIdentifiter;


/// 压缩点
///
/// @param type 事件名称，对应平台上的唯一标示
/// @param attribute 事件参数
/// @param identify 事件标示，用于区分开与其他埋点数据
/// @param maxCount 最大压缩收集数，当收集到 x 条数时，会执行 handler
/// @param handler 当收集到 x 条数时，会执行 handler，返回值为上报的格式数据
+ (void)tysdk_eventWithType:(NSString *)type attribute:(NSDictionary *)attribute identify:(NSString *)identify maxCount:(int)maxCount handler:(NSDictionary *(^)(NSInteger index, NSArray * datas))handler;

@end
