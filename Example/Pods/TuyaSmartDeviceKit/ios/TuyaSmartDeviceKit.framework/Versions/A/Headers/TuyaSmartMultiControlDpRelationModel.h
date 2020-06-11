//
//  TuyaSmartMultiControlDpRelationModel.h
//  TuyaSmartDeviceKit
//
//  Created by Misaka on 2020/5/18.
//

#import <Foundation/Foundation.h>
#import "TuyaSmartMultiControlParentRuleModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TuyaSmartMcGroupDetailModel : NSObject

@property (copy, nonatomic) NSString *detailId;
@property (copy, nonatomic) NSString *dpId;///< dp id
@property (copy, nonatomic) NSString *dpName;///< dp 名称
@property (copy, nonatomic) NSString *devId;///< 设备 id
@property (copy, nonatomic) NSString *devName;///< 设备名称
@property (assign, nonatomic) BOOL enabled;///< 是否可用
@property (copy, nonatomic) NSString *multiControlId;///< 多控组 id

@end


@interface TuyaSmartMcGroupModel : NSObject

@property (copy, nonatomic) NSString *multiControlId;///< 多控组id
@property (copy, nonatomic) NSString *groupName;///< 多控组名称
@property (strong, nonatomic) NSArray<TuyaSmartMcGroupDetailModel *> *groupDetail;///< 多控组关联详情

@property (assign, nonatomic) BOOL enabled;
@property (assign, nonatomic) NSInteger groupType;///< 多控组类型
@property (copy, nonatomic) NSString *multiRuleId;
@property (copy, nonatomic) NSString *ownerId;///< 家庭id
@property (copy, nonatomic) NSString *uid;///< 用户id

@end


@interface TuyaSmartMultiControlDpRelationModel : NSObject

@property (strong, nonatomic) NSArray<TuyaSmartMultiControlDatapointModel *> *datapoints;
@property (strong, nonatomic) NSArray<TuyaSmartMcGroupModel *> *mcGroups;
@property (strong, nonatomic) NSArray<TuyaSmartMultiControlParentRuleModel *> *parentRules;

@end

NS_ASSUME_NONNULL_END
