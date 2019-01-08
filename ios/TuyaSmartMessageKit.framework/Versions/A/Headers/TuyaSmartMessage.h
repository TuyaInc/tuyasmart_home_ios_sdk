//
//  TuyaSmartMessage.h
//  TuyaSmartKit
//
//  Created by xuyongbo on 2017/9/11.
//  Copyright © 2017年 Tuya. All rights reserved.
//

#import <TuyaSmartUtil/TuyaSmartUtil.h>
#import "TuyaSmartMessageListModel.h"

@interface TuyaSmartMessage : NSObject

/**
 获取消息列表(旧)

 @param success 操作成功回调，返回消息列表
 @param failure 操作失败回调
 */
- (void)getMessageList:(void (^)(NSArray<TuyaSmartMessageListModel *> *list))success
               failure:(TYFailureError)failure __deprecated_msg("This method is deprecated, Use - “获取消息列表(新)” - [TuyaSmartMessage getMessageListWithType:limit:offset:success:failure:] or - “获取分类消息列表(新)” - [TuyaSmartMessage getMessageDetailListWithType:msgSrcId:limit:offset:success:failure:] instead");



/**
 获取分页的消息列表(旧)

 @param limit limit
 @param offset offset 从0开始
 @param success 操作成功回调，返回消息列表
 @param failure 操作失败回调
 */
- (void)getMessageList:(NSInteger)limit
                offset:(NSInteger)offset
               success:(void (^)(NSArray<TuyaSmartMessageListModel *> *list))success
               failure:(TYFailureError)failure __deprecated_msg("This method is deprecated, Use - “获取消息列表(新)” - [TuyaSmartMessage getMessageListWithType:limit:offset:success:failure:] or - “获取分类消息列表(新)” - [TuyaSmartMessage getMessageDetailListWithType:msgSrcId:limit:offset:success:failure:] instead");


/**
 批量删除消息(旧)

 @param messgeIdList 消息id列表
 @param success 操作成功回调
 @param failure 操作失败回调
 */
- (void)deleteMessage:(NSArray <NSString *> *)messgeIdList
              success:(TYSuccessHandler)success
              failure:(TYFailureError)failure __deprecated_msg("This method is deprecated, Use - “批量删除数据(新)” - [TuyaSmartMessage deleteMessageWithType:ids:msgSrcIds:success:failure:] instead");

/**
 获取最新一条消息的时间戳(旧)

 @param success 操作成功回调，返回最新时间
 @param failure 操作失败回调
 */
- (void)getMessageMaxTime:(TYSuccessInt)success
                  failure:(TYFailureError)failure __deprecated_msg("This method is deprecated, Use - “获取三类消息是否有新消息(新)” - [TuyaSmartMessage getLatestMessageWithSuccess:failure:] instead");

/// 取消未完成的操作
- (void)cancelRequest;

/**
 *  获取消息列表(新)
 *
 *  @param msgType      消息类型 1告警 2家庭 3通知
 *  @param limit        开始
 *  @param offset       条数
 *  @param success      操作成功回调
 *  @param failure      操作失败回调
 */
- (void)getMessageListWithType:(NSInteger)msgType limit:(NSInteger)limit offset:(NSInteger)offset success:(void (^)(NSArray<TuyaSmartMessageListModel *> *list))success failure:(TYFailureError)failure;

/**
 *  获取分类消息列表(新)
 *
 *  @param msgType      消息类型 1告警 2家庭 3通知 现只⽤用于告警消息，传1
 *  @param msgSrcId     分类ID
 *  @param limit        开始
 *  @param offset       条数
 *  @param success      操作成功回调
 *  @param failure      操作失败回调
 */
- (void)getMessageDetailListWithType:(NSInteger)msgType msgSrcId:(NSString *)msgSrcId limit:(NSInteger)limit offset:(NSInteger)offset success:(void (^)(NSArray<TuyaSmartMessageListModel *> *list))success failure:(TYFailureError)failure;

/**
 *  获取三类消息是否有新消息(新)
 *
 *  @param success      操作成功回调
 *  @param failure      操作失败回调
 */
- (void)getLatestMessageWithSuccess:(TYSuccessDict)success failure:(TYFailureError)failure;

/**
 *  批量删除数据(新)
 *
 *  @param msgType      消息类型 1告警 2家庭 3通知 现只⽤用于告警消息，传1
 *  @param ids          消息ID列列表。其中如果消息有 msgId 则传 ids
 *  @param msgSrcIds    告警类消息需要传分类ID，可以是设备ID，⾃自动化ID。其中如果消息有 msgSrcId 则传 msgSrcIds
 *  @param success      操作成功回调
 *  @param failure      操作失败回调
 */
- (void)deleteMessageWithType:(NSInteger)msgType ids:(NSArray *)ids msgSrcIds:(NSArray *)msgSrcIds success:(TYSuccessHandler)success failure:(TYFailureError)failure;


@end
