//
//  TYSmartBLEModel.h
//  TuyaSmartUtil-iOS-TuyaSmartUtil
//
//  Created by 温明妍 on 2019/9/23.
//

#import <Foundation/Foundation.h>
#import "TYSmartBLEAPMEnum.h"

@interface TYSmartBLEAPMMessageModel : NSObject <NSCopying>

@property (nonatomic, strong) NSString *devId;
@property (nonatomic, assign) TYSmartBLEAPMType type;
@property (nonatomic, strong) NSDictionary *dps;
@property (nonatomic, assign) NSTimeInterval time; /**< 上报时间点  */
@property (nonatomic, strong) NSString *des; /**< 描述  */
@property (nonatomic, strong) NSDictionary *extInfo; /**< 预留  */


- (NSDictionary *)attributes;

@end
