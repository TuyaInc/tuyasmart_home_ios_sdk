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

/* 开始一个（时长类）事件
 
 @params type 事件名称
 @params attributes 公共事件参数
 @params infos 事件信息
 @params identifier 事件ID（调用 [xxx ty_apm_identifier] 生成）
 @params trackType 连路点状态  （trackType = @”begin“ 开始 / @"track" 发送/ @"end" 结束）
 
 */
+ (void)tysdk_eventWithType:(NSString *)type attribute:(NSDictionary *)attribute infos:(NSDictionary *)infos trackType:(NSString *)trackType identifier:(NSString *)identifier;

+ (NSString *)tysdk_eventIdentifiter;


@end
