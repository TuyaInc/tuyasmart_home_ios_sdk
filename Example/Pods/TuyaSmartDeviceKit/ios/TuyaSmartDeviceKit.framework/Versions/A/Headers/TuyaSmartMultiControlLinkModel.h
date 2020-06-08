//
//  TuyaSmartMultiControlLinkModel.h
//  TuyaSmartDeviceKit
//
//  Created by Misaka on 2020/5/18.
//

#import <Foundation/Foundation.h>
#import "TuyaSmartMultiControlParentRuleModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TuyaSmartMultiControlGroupDetailModel : NSObject

@property (copy, nonatomic) NSString *detailId;
@property (copy, nonatomic) NSString *multiControlId;///< 多控组id
@property (copy, nonatomic) NSString *devId;///< 附属设备 id
@property (copy, nonatomic) NSString *devName;///< 附属设备名称
@property (copy, nonatomic) NSString *dpId;///< 已关联的附属设备的 dp id
@property (copy, nonatomic) NSString *dpName;///< 已关联的附属设备的 dp 名称
@property (assign, nonatomic) BOOL enabled;///< 已关联的附属设备是否可以通过多控功能控制
@property (strong, nonatomic) NSArray<TuyaSmartMultiControlDatapointModel *> *datapoints;

@end


@interface TuyaSmartMultiControlGroupModel : NSObject

@property (copy, nonatomic) NSString *multiControlId;///< 多控组id
@property (copy, nonatomic) NSString *groupName;///< 多控组名称
@property (strong, nonatomic) NSArray<TuyaSmartMultiControlGroupDetailModel *> *groupDetail;///< 多控组详情

@property (assign, nonatomic) BOOL enabled;
@property (assign, nonatomic) NSInteger groupType;///< 多控组类型
@property (copy, nonatomic) NSString *multiRuleId;
@property (copy, nonatomic) NSString *ownerId;///< 家庭id
@property (copy, nonatomic) NSString *uid;///< 用户id

@end


@interface TuyaSmartMultiControlLinkModel : NSObject

@property (strong, nonatomic) TuyaSmartMultiControlGroupModel *multiGroup;
@property (strong, nonatomic) NSArray<TuyaSmartMultiControlParentRuleModel *> *parentRules;

@end

NS_ASSUME_NONNULL_END
