//
//  TuyaSmartFeedbackItemModel.h
//  TuyaSmartKit
//
//  Created by xuyongbo on 2017/9/11.
//  Copyright © 2017年 Tuya. All rights reserved.
//

@interface TuyaSmartFeedbackItemModel : TYModel

/**
 反馈类型item id
 */
@property (nonatomic, strong) NSString      *hdId;

/**
 反馈类型item类型
 */
@property (nonatomic, assign) NSUInteger    hdType;

/**
 反馈类型item标题
 */
@property (nonatomic, strong) NSString      *title;

@end
