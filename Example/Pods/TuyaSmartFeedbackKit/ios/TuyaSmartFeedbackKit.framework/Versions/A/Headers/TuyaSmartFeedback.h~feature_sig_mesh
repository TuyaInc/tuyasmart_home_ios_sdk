//
//  TuyaSmartFeedback.h
//  TuyaSmartKit
//
//  Created by 高森 on 16/4/8.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import <TuyaSmartUtil/TuyaSmartUtil.h>
#import "TuyaSmartFeedbackTalkListModel.h"
#import "TuyaSmartFeedbackModel.h"
#import "TuyaSmartFeedbackTypeListModel.h"

@interface TuyaSmartFeedback : NSObject


/**
 *  Get feedback session list.
 *  获取反馈会话列表
 *
 *  @param success      Success block
 *  @param failure      Failure block
 */
- (void)getFeedbackTalkList:(void (^)(NSArray<TuyaSmartFeedbackTalkListModel *> *list))success
                    failure:(TYFailureError)failure;


/**
 *  Get feedback list.
 *  获取反馈列表
 *
 *  @param hdId         Feedback Id
 *  @param hdType       Feedback type
 *  @param success      Success block
 *  @param failure      Failure block
 */
- (void)getFeedbackList:(NSString *)hdId
                 hdType:(NSUInteger)hdType
                success:(void (^)(NSArray<TuyaSmartFeedbackModel *> *list))success
                failure:(TYFailureError)failure;


/**
 *  Get feedback type list.
 *  获取反馈类型列表
 *
 *  @param success      Success block
 *  @param failure      Failure block
 */
- (void)getFeedbackTypeList:(void (^)(NSArray<TuyaSmartFeedbackTypeListModel *> *list))success
                    failure:(TYFailureError)failure;


/**
 *  Submit feedback.
 *  添加反馈
 *
 *  @param content      Feedback content
 *  @param hdId         Feedback Id
 *  @param hdType       Feedback type
 *  @param contact      Contact
 *  @param success      Success block
 *  @param failure      Failure block
 */
- (void)addFeedback:(NSString *)content
               hdId:(NSString *)hdId
             hdType:(NSUInteger)hdType
            contact:(NSString *)contact
            success:(TYSuccessHandler)success
            failure:(TYFailureError)failure;


/**
 *  Cancel the request being executed.
 *  取消正在进行的操作
 */
- (void)cancelRequest;


@end
