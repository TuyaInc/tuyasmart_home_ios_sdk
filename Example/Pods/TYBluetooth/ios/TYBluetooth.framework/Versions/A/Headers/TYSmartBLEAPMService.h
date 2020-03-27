//
//  TYSmartBLEAPMService.h
//  Bolts
//
//  Created by 温明妍 on 2019/9/2.
//

#import <Foundation/Foundation.h>
#import "TYSmartBLEAPMMessageModel.h"
#import "TYSmartBLEAPMEnum.h"

@interface TYSmartBLEAPMService : NSObject

+ (instancetype)sharedInstance;

- (void)putBLEAPMInDevId:(NSString *)devId type:(TYSmartBLEAPMType)type des:(NSString *)des dps:(NSDictionary *)dps extInfo:(NSDictionary *)extInfo;

- (void)putBLEAPMWithMessageModel:(TYSmartBLEAPMMessageModel *)messageModel;


@end
