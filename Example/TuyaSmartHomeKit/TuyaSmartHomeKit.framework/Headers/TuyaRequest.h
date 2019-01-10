//
//  TuyaRequest.h
//  TuyaSmart
//
//  Created by fengyu on 15/3/12.
//  Copyright (c) 2015年 Tuya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TuyaRequest : NSMutableURLRequest

@property (nonatomic, strong) NSMutableDictionary *postData;
@property (nonatomic, strong) NSMutableDictionary *getData;


+ (instancetype)requestWithApiName:(NSString *)apiName version:(NSString *)version;

- (void)addGetData:(id)data forKey:(NSString *)key;
- (void)addPostData:(id)data forKey:(NSString *)key;

- (void)build;

- (NSString *)cacheKey;

@end
