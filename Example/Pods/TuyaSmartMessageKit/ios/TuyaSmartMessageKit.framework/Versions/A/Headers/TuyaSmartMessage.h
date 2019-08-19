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
 *  Get the message list.
 *  获取消息列表
 *
 *  @param success      Success block
 *  @param failure      Failure block
 */
- (void)getMessageList:(void (^)(NSArray<TuyaSmartMessageListModel *> *list))success
               failure:(TYFailureError)failure __deprecated_msg("This method is deprecated, Use -[TuyaSmartMessage getMessageListWithType:limit:offset:success:failure:] or -[TuyaSmartMessage getMessageDetailListWithType:msgSrcId:limit:offset:success:failure:] instead");


/**
 *  Get next page message list.
 *  获取分页的消息列表
 *
 *  @param limit        Limit
 *  @param offset       Offset  start from zero
 *  @param success      Success block
 *  @param failure      Failure block
 */
- (void)getMessageList:(NSInteger)limit
                offset:(NSInteger)offset
               success:(void (^)(NSArray<TuyaSmartMessageListModel *> *list))success
               failure:(TYFailureError)failure __deprecated_msg("This method is deprecated, Use -[TuyaSmartMessage getMessageListWithType:limit:offset:success:failure:] or -[TuyaSmartMessage getMessageDetailListWithType:msgSrcId:limit:offset:success:failure:] instead");


/**
 *  Delete a batch of messages
 *  批量删除消息
 *
 *  @param messgeIdList Message Id list
 *  @param success      Success block
 *  @param failure      Failure block
 */
- (void)deleteMessage:(NSArray <NSString *> *)messgeIdList
              success:(TYSuccessHandler)success
              failure:(TYFailureError)failure __deprecated_msg("This method is deprecated, Use -[TuyaSmartMessage deleteMessageWithType:ids:msgSrcIds:success:failure:] instead");


/**
 *  Get the timestamp of the newest message
 *  获取最新一条消息的时间戳
 *
 *  @param success      Success block
 *  @param failure      Failure block
 */
- (void)getMessageMaxTime:(TYSuccessInt)success
                  failure:(TYFailureError)failure __deprecated_msg("This method is deprecated, Use -[TuyaSmartMessage getLatestMessageWithSuccess:failure:] instead");


/**
 *  Get the message list.
 *  获取消息列表
 *
 *  @param msgType      Message type
 *  @param limit        Limit
 *  @param offset       Offset  start from zero
 *  @param success      Success block
 *  @param failure      Failure block
 */
- (void)getMessageListWithType:(NSInteger)msgType limit:(NSInteger)limit offset:(NSInteger)offset success:(void (^)(NSArray<TuyaSmartMessageListModel *> *list))success failure:(TYFailureError)failure;

/**
 *  Get the message list by message type.
 *  获取分类消息列表
 *
 *  @param msgType      Message type
 *  @param msgSrcId     Detail message Id
 *  @param limit        Limit
 *  @param offset       Offset  start from zero
 *  @param success      Success block
 *  @param failure      Failure block
 */
- (void)getMessageDetailListWithType:(NSInteger)msgType msgSrcId:(NSString *)msgSrcId limit:(NSInteger)limit offset:(NSInteger)offset success:(void (^)(NSArray<TuyaSmartMessageListModel *> *list))success failure:(TYFailureError)failure;

/**
 *  Get three types of messages if there are new ones
 *  获取三类消息是否有新消息
 *
 *  @param success      Success block
 *  @param failure      Failure block
 */
- (void)getLatestMessageWithSuccess:(TYSuccessDict)success failure:(TYFailureError)failure;

/**
 *  Delete a batch of messages
 *  批量删除数据
 *
 *  @param msgType      Message type
 *  @param ids          Delete message Id list
 *  @param msgSrcIds    Delete alarm message Id list
 *  @param success      Success block
 *  @param failure      Failure block
 */
- (void)deleteMessageWithType:(NSInteger)msgType ids:(NSArray *)ids msgSrcIds:(NSArray *)msgSrcIds success:(TYSuccessHandler)success failure:(TYFailureError)failure;


/**
 *  Cancel the request being executed.
 *  取消正在进行的操作。
 */
- (void)cancelRequest;


@end
