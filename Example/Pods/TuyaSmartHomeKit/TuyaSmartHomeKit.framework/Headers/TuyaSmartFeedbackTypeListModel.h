//
//  TuyaSmartFeedbackTypeListModel.h
//  TuyaSmartKit
//
//  Created by xuyongbo on 2017/9/11.
//  Copyright © 2017年 Tuya. All rights reserved.
//

#import "TuyaSmartFeedbackItemModel.h"

@interface TuyaSmartFeedbackTypeListModel : TYModel

/**
 反馈类型，如：“故障设备”, "更多"
 */
@property (nonatomic, strong) NSString *type;

/**
 反馈类型包含的item列表
 */
@property (nonatomic, strong) NSArray<TuyaSmartFeedbackItemModel *> *list;

@end
