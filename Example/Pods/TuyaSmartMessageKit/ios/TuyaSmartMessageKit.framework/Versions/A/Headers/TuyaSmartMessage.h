//
//  TuyaSmartMessage.h
//  TuyaSmartKit
//
//  Created by xuyongbo on 2017/9/11.
//  Copyright © 2017年 Tuya. All rights reserved.
//

#import <TuyaSmartUtil/TuyaSmartUtil.h>
#import "TuyaSmartMessageListModel.h"
#import "TuyaSmartMessageRequestModel.h"

NS_ASSUME_NONNULL_BEGIN
@interface TuyaSmartMessage : NSObject

/// 获取消息列表数据 fetch message list
/// @param listRequestModel 列表数据请求模型 listRequestModel
/// @param success 成功回调 success
/// @param failure 失败回调 failure
- (void)fetchMessageListWithListRequestModel:(TuyaSmartMessageListRequestModel *)listRequestModel
                                     success:(void (^)(NSArray<TuyaSmartMessageListModel *> *messageList))success
                                     failure:(TYFailureError)failure;

/// 获取消息详情列表数据 fetch message detail list
/// @param detailListRequestModel 列表数据请求模型 detailListRequestModel
/// @param success 成功回调 success
/// @param failure 失败回调 failure
- (void)fetchMessageDetailListWithListRequestModel:(TuyaSmartMessageDetailListRequestModel *)detailListRequestModel
                                           success:(void (^)(NSArray<TuyaSmartMessageListModel *> *messageList))success
                                           failure:(TYFailureError)failure;

/// 获取三类消息是否有新消息 Get three types of messages if there are new ones
/// @param success 成功回调 success
/// @param failure 失败回调 failure
- (void)getLatestMessageWithSuccess:(TYSuccessDict)success failure:(TYFailureError)failure;

/// 已阅消息中心列表数据 have read message
/// @param readRequestModel 已阅的消息列表(支持全部已读) readRequestModel(support read all)
/// @param success 成功回调 success
/// @param failure 失败回调 failure
- (void)readMessageWithReadRequestModel:(TuyaSmartMessageListReadRequestModel *)readRequestModel success:(TYSuccessBOOL)success failure:(TYFailureError)failure;


/// 删除消息中心列表数据 delete message
/// @param deleteRequestModel 删除的消息列表(不支持删除全部) deleteRequestModel(nonsupport delete all)
/// @param success 成功回调 success
/// @param failure 失败回调 failure
- (void)deleteMessageWithDeleteRequestModel:(TuyaSmartMessageListDeleteRequestModel *)deleteRequestModel success:(TYSuccessBOOL)success failure:(TYFailureError)failure;

/// 取消正在进行的操作 Cancel the request being executed
- (void)cancelRequest;

@end
NS_ASSUME_NONNULL_END
