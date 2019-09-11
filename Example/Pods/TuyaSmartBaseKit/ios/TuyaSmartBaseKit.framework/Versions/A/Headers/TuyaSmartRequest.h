//
//  TuyaSmartRequest.h
//  TuyaSmartPublic
//
//  Created by 高森 on 16/5/4.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#ifndef TuyaSmart_TuyaSmartRequest
#define TuyaSmart_TuyaSmartRequest

#import <TuyaSmartUtil/TuyaSmartUtil.h>

NS_ASSUME_NONNULL_BEGIN

@interface TuyaSmartRequest : NSObject

/**
 Network request for Tuya server API.
 调用服务端API

 @param apiName API name
 @param postData API params
 @param version API version
 @param success Success block
 @param failure Failure block
 */
- (void)requestWithApiName:(NSString *)apiName
                  postData:(nullable NSDictionary *)postData
                   version:(NSString *)version
                   success:(nullable TYSuccessID)success
                   failure:(nullable TYFailureError)failure;

/**
 Network request for Tuya server API.
 调用服务端API
 
 @param apiName API name
 @param postData API params
 @param getData Common params
 @param version API version
 @param success Success block
 @param failure Failure block
 */
- (void)requestWithApiName:(NSString *)apiName
                  postData:(nullable NSDictionary *)postData
                   getData:(nullable NSDictionary *)getData
                   version:(NSString *)version
                   success:(nullable TYSuccessID)success
                   failure:(nullable TYFailureError)failure;

/// Cancel network request
- (void)cancel;

/// Remove network cache
+ (void)removeAllCache;

@end


@interface TuyaSmartRequest (ApiMerge)

/**
 Invoke multiple api in one network request.
 一次网络请求调用多个API

 @param apiName API name
 @param postData API params
 @param version API version
 @param success Success block
 @param failure Failure block
 */
- (void)addMergeRequestWithApiName:(NSString *)apiName
                          postData:(nullable NSDictionary *)postData
                           version:(NSString *)version
                           success:(nullable TYSuccessID)success
                           failure:(nullable TYFailureError)failure;


/**
 Send multiple api request.
 发送合并API请求
 
 @param success Success block
 @param failure Failure block
 */
- (void)sendMergeRequestWithSuccess:(nullable TYSuccessList)success
                            failure:(nullable TYFailureError)failure;

/**
 Send multiple api request.
 发送合并API请求
 
 @param getData Common params
 @param success Success block
 @param failure Failure block
 */
- (void)sendMergeRequestWithGetData:(nullable NSDictionary *)getData
                            success:(nullable TYSuccessList)success
                            failure:(nullable TYFailureError)failure;


/**
 Remove all multiple api request.
 清空合并API请求
 */
- (void)removeAllMergeRequest;

@end

@interface TuyaSmartRequest (Encryption)

/**
 Network request for Tuya server API with post data encrypt.
 调用服务端API
 
 @param apiName API name
 @param postData API params
 @param version API version
 @param success Success block
 @param failure Failure block
 */
- (void)requestPostDataEncryptWithApiName:(NSString *)apiName
                                 postData:(nullable NSDictionary *)postData
                                  version:(NSString *)version
                                  success:(nullable TYSuccessID)success
                                  failure:(nullable TYFailureError)failure;

@end

NS_ASSUME_NONNULL_END

#endif
