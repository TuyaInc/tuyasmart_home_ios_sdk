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

@interface TuyaSmartRequest : NSObject


/**
 *  请求服务端接口
 *
 *  @param apiName	接口名称
 *  @param postData 业务入参
 *  @param version  接口版本号
 *  @param success  操作成功回调
 *  @param failure  操作失败回调
 */
- (void)requestWithApiName:(NSString *)apiName
                  postData:(NSDictionary *)postData
                   version:(NSString *)version
                   success:(TYSuccessID)success
                   failure:(TYFailureError)failure;



/**
 *  请求服务端接口
 *
 *  @param apiName  接口名称
 *  @param postData 业务入参
 *  @param getData  公共入参
 *  @param version  接口版本号
 *  @param success  操作成功回调
 *  @param failure  操作失败回调
 */
- (void)requestWithApiName:(NSString *)apiName
                  postData:(NSDictionary *)postData
                   getData:(NSDictionary *)getData
                   version:(NSString *)version
                   success:(TYSuccessID)success
                   failure:(TYFailureError)failure;


/// 取消网络请求
- (void)cancel;

@end

#endif
