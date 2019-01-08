//
//  TuyaSmartFeedbackModel.h
//  TuyaSmartKit
//
//  Created by xuyongbo on 2017/9/11.
//  Copyright © 2017年 Tuya. All rights reserved.
//


typedef enum : NSUInteger {
    TuyaSmartFeedbackQuestion,      //提问
    TuyaSmartFeedbackAnswer,        //回答
} TuyaSmartFeedbackType;

@interface TuyaSmartFeedbackModel : TYModel

/**
 反馈类型
 */
@property (nonatomic, assign) TuyaSmartFeedbackType     type;

/**
 反馈时间
 */
@property (nonatomic, assign) NSTimeInterval            ctime;

/**
 反馈id
 */
@property (nonatomic, assign) NSUInteger                uniqueId;

/**
 反馈内容
 */
@property (nonatomic, strong) NSString                  *content;

@end
