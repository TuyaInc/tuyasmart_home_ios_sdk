//
//  TuyaSmartSceneLogDetailModel.h
//  TuyaSmartSceneKit
//
//  Created by TuyaInc on 2020/2/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class TuyaSmartSceneLogDetailData;
@interface TuyaSmartSceneLogDetailModel : NSObject
/**
 [^en]
 id of the action entity
 [$en]

 [^zh]
 动作实体对象
 [$zh]
 */
@property (nonatomic, strong) NSString * actionEntityId;

/**
 [^en]
 name of the action entity
 [$en]

 [^zh]
 动作实体名称
 [$zh]
 */
@property (nonatomic, strong) NSString * actionEntityName;

/**
 [^en]
 icon url of the action entity
 [$en]

 [^zh]
 动作实体图片url
 [$zh]
 */
@property (nonatomic, strong) NSString * actionEntityUrl;

/**
 [^en]
 executor of the action
 [$en]

 [^zh]
 动作执行者类型
 [$zh]
 */
@property (nonatomic, strong) NSString * actionExecutor;

/**
 [^en]
 id of the action
 [$en]

 [^zh]
 动作ID
 [$zh]
 */
@property (nonatomic, strong) NSString * actionId;

/**
 [^en]
 error code
 [$en]

 [^zh]
 错误编码
 [$zh]
 */
@property (nonatomic, strong) NSString * errorCode;

/**
 [^en]
 reason of the error
 [$en]

 [^zh]
 错误原因
 [$zh]
 */
@property (nonatomic, strong) NSString * errorMsg;

/**
 [^en]
 execute status of the action
 [$en]

 [^zh]
 执行状态
 [$zh]
 */
@property (nonatomic, assign) NSInteger execStatus;

/**
 [^en]
 execute time of the action
 [$en]

 [^zh]
 执行时间
 [$zh]
 */
@property (nonatomic, strong) NSString * executeTime;

/**
 [^en]
 error detail info
 [$en]

 [^zh]
 错误详情
 [$zh]
 */
@property (nonatomic, strong) NSArray<TuyaSmartSceneLogDetailData *> *detail;

@end

@interface TuyaSmartSceneLogDetailData: NSObject

/**
 [^en]
 execute code
 [$en]

 [^zh]
 执行编码
 [$zh]
 */
@property (nonatomic, strong) NSString * code;

/**
 [^en]
 error message
 [$en]

 [^zh]
 错误信息
 [$zh]
 */
@property (nonatomic, strong) NSString * msg;

/**
 
 [^en]
 status of action
 [$en]

 [^zh]
 动作执行状态
 [$zh]
 */
@property (nonatomic, assign) NSInteger status;

/**
 [^en]
 username
 [$en]

 [^zh]
 用户名称
 [$zh]
 */
@property (nonatomic, strong) NSString * detailName;

/**
 [^en]
 user id
 [$en]

 [^zh]
 用户uid
 [$zh]
 */
@property (nonatomic, strong) NSString * detailId;

/**
 [^en]
 picture url
 [$en]

 [^zh]
 图片路径
 [$zh]
 */
@property (nonatomic, strong) NSString * icon;

@end

NS_ASSUME_NONNULL_END
