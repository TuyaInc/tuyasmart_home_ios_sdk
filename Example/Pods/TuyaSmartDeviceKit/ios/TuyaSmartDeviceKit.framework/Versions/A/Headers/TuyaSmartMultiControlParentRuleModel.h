//
//  TuyaSmartMultiControlParentRuleModel.h
//  TuyaSmartDeviceKit
//
//  Created by Misaka on 2020/5/18.
//

#import <Foundation/Foundation.h>
#import "TuyaSmartMultiControlDatapointModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TuyaSmartMultiControlParentRuleDpModel : NSObject

@property (copy, nonatomic) NSString *dpId;///< dp id
@property (copy, nonatomic) NSString *dpName;///< dp 名称

@end

@interface TuyaSmartMultiControlParentRuleModel : NSObject

@property (copy, nonatomic) NSString *ruleId;///< 自动化 id
@property (copy, nonatomic) NSString *name;///< 自动化名称

@property (strong, nonatomic) NSArray<TuyaSmartMultiControlParentRuleDpModel *> *dpList;

@end

NS_ASSUME_NONNULL_END
