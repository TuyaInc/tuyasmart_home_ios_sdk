//
//  TuyaSmartSceneLogModel.h
//  TuyaSmartSceneKit
//
//  Created by TuyaInc on 2020/2/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class TuyaSmartSceneLogData;

@interface TuyaSmartSceneLogModel : NSObject
/**
 [^en]
 scene log datas
 [$en]

 [^zh]
 场景日志数据
 [$zh]
 */
@property (nonatomic, strong) NSArray<TuyaSmartSceneLogData *> * datas;

/**
 [^en]
 total count, equal to datas.count
 [$en]

 [^zh]
 日志总数量 等于datas.count
 [$zh]
 */
@property (nonatomic, assign) NSInteger totalCount;
@end

@interface TuyaSmartSceneLogData : NSObject

/**
[^en]
event id
[$en]

[^zh]
事件id
[$zh]
*/
@property (nonatomic, strong) NSString * eventId;

/**
 [^en]
 execute result
 [$en]

 [^zh]
 执行结果
 [$zh]
 */
@property (nonatomic, assign) NSInteger execResult;

/**
 [^en]
 execute result message
 [$en]

 [^zh]
 执行结果信息
 [$zh]
 */
@property (nonatomic, strong) NSString * execResultMsg;

/**
 [^en]
 execute time
 [$en]

 [^zh]
 执行时间
 [$zh]
 */
@property (nonatomic, strong) NSString * execTime;

/**
 [^en]
 failure reason
 [$en]

 [^zh]
 错误原因
 [$zh]
 */
@property (nonatomic, strong) NSString * failureCause;

/**
 [^en]
 failure code
 [$en]

 [^zh]
 错误码
 [$zh]
 */
@property (nonatomic, assign) NSInteger failureCode;

/**
 [^en]
 owner id
 [$en]

 [^zh]
 拥有者id
 [$zh]
 */
@property (nonatomic, strong) NSString * ownerId;

/**
 [^en]
 rule id
 [$en]

 [^zh]
 规则 id
 [$zh]
 */
@property (nonatomic, strong) NSString * ruleId;

/**
 [^en]
 rule name
 [$en]

 [^zh]
 规则名称
 [$zh]
 */
@property (nonatomic, strong) NSString * ruleName;

/**
 [^en]
 scene type: 1 Tap to Run, 2 automation
 [$en]

 [^zh]
 场景类型：1：一键执行，2：自动化
 [$zh]
 */
@property (nonatomic, assign) NSInteger sceneType;

/**
 [^en]
 user id
 [$en]

 [^zh]
 用户id
 [$zh]
 */
@property (nonatomic, strong) NSString * uid;

/**
 [^en]
 this data is not from service, you can set this property just for display
 [$en]

 [^zh]
 此数据并非来自于云端，可以给此属性赋值仅做辅助展示作用
 [$zh]
 */
@property (nonatomic, strong) NSString *detailTime;

/**
 [^en]
 this data is not from service, you can set this property to assist sort the list into category
  use this property just for display. 0 first , 1 middel, 2 last, -1 needless(just one item)
 [$en]

 [^zh]
 此数据并非来源于云端接口，可以使用此属性作为数据列表分类排序的标记位。
 此属性仅用作于展示， 0 首位 ， 1中间位， 2最后位， -1只有单条数据
 [$zh]
 */
@property (nonatomic, assign) NSInteger indexType;
@end

NS_ASSUME_NONNULL_END
