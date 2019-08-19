//
//  TYApiMergeService.h
//  TuyaSmartKit
//
//  Created by 冯晓 on 2017/4/11.
//  Copyright © 2017年 Tuya. All rights reserved.
//

#import "TYApiMergeModel.h"
#import "TuyaSmartRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface TYApiMergeService : TuyaSmartRequest

@property (nonatomic, strong) NSMutableArray *requestList;


/**
 add api request

 @param apiName     api name
 @param postData    post data
 @param version     version
 */
- (void)addApiRequest:(NSString *)apiName postData:(NSDictionary *)postData version:(NSString *)version;


/**
 send request

 @param getData get data
 @param success Success block
 @param failure Failure block
 */
- (void)sendRequest:(NSDictionary *)getData success:(nullable void (^)(NSArray <TYApiMergeModel *> *list))success failure:(nullable TYFailureError)failure;

@end

NS_ASSUME_NONNULL_END
