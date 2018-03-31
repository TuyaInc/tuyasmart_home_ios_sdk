//
//  TuyaSmartMessage.h
//  TuyaSmartKit
//
//  Created by xuyongbo on 2017/9/11.
//  Copyright © 2017年 Tuya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TuyaSmartMessageListModel.h"

@interface TuyaSmartMessage : NSObject

/**
 获取消息列表

 @param success 操作成功回调，返回消息列表
 @param failure 操作失败回调
 */
- (void)getMessageList:(void (^)(NSArray<TuyaSmartMessageListModel *> *list))success
               failure:(TYFailureError)failure;



/**
 获取分页的消息列表

 @param limit limit
 @param offset offset 从0开始
 @param success 操作成功回调，返回消息列表
 @param failure 操作失败回调
 */
- (void)getMessageList:(NSInteger)limit
                offset:(NSInteger)offset
               success:(void (^)(NSArray<TuyaSmartMessageListModel *> *list))success
               failure:(TYFailureError)failure;


/**
 批量删除消息

 @param messgeIdList 消息id列表
 @param success 操作成功回调
 @param failure 操作失败回调
 */
- (void)deleteMessage:(NSArray <NSString *> *)messgeIdList
              success:(TYSuccessHandler)success
              failure:(TYFailureError)failure;

/**
 获取最新一条消息的时间戳

 @param success 操作成功回调，返回最新时间
 @param failure 操作失败回调
 */
- (void)getMessageMaxTime:(TYSuccessInt)success
                  failure:(TYFailureError)failure;

/// 取消未完成的操作
- (void)cancelRequest;

@end
