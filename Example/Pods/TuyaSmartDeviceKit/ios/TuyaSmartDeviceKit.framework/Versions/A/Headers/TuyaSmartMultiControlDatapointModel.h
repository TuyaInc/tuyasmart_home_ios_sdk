//
//  TuyaSmartMultiControlDatapointModel.h
//  TuyaSmartDeviceKit
//
//  Created by Misaka on 2020/5/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TuyaSmartMultiControlDatapointModel : NSObject

@property (copy, nonatomic) NSString *dpId;///< dp id
@property (copy, nonatomic) NSString *name;///< dp 名称
@property (copy, nonatomic) NSString *code;///< dp 标准名称（dpCode）
@property (copy, nonatomic) NSString *schemaId;///< 按键所属的 schema Id

@end

NS_ASSUME_NONNULL_END
