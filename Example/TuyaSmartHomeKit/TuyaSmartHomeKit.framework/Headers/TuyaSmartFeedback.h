//
//  TuyaSmartFeedback.h
//  TuyaSmartKit
//
//  Created by 高森 on 16/4/8.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TuyaSmartFeedbackTalkListModel.h"
#import "TuyaSmartFeedbackModel.h"
#import "TuyaSmartFeedbackTypeListModel.h"

/// 意见反馈相关功能
@interface TuyaSmartFeedback : NSObject

#pragma mark - 获取反馈

/**
 *  获取反馈会话列表
 *
 *  @param success 操作成功回调
 *  @param failure 操作失败回调
 */
- (void)getFeedbackTalkList:(void (^)(NSArray<TuyaSmartFeedbackTalkListModel *> *list))success
                    failure:(TYFailureError)failure;

/**
 *  获取反馈列表
 *
 *  @param hdId    hdId
 *  @param hdType  hdType
 *  @param success 操作成功回调
 *  @param failure 操作失败回调
 */
- (void)getFeedbackList:(NSString *)hdId
                 hdType:(NSUInteger)hdType
                success:(void (^)(NSArray<TuyaSmartFeedbackModel *> *list))success
                failure:(TYFailureError)failure;

#pragma mark - 添加反馈

/**
 *  获取反馈类型列表
 *
 *  @param success 操作成功回调
 *  @param failure 操作失败回调
 */
- (void)getFeedbackTypeList:(void (^)(NSArray<TuyaSmartFeedbackTypeListModel *> *list))success
                    failure:(TYFailureError)failure;

/**
 *  添加反馈
 *
 *  @param content 反馈内容
 *  @param hdId    hdId
 *  @param hdType  hdType
 *  @param contact contact
 *  @param success 操作成功回调
 *  @param failure 操作失败回调
 */
- (void)addFeedback:(NSString *)content
               hdId:(NSString *)hdId
             hdType:(NSUInteger)hdType
            contact:(NSString *)contact
            success:(TYSuccessHandler)success
            failure:(TYFailureError)failure;


/// 取消未完成的操作
- (void)cancelRequest;

@end
