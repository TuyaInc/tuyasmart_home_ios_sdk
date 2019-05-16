//
//  TYUserDefault.h
//  TuyaSmart
//
//  Created by fengyu on 15/4/7.
//  Copyright (c) 2015年 Tuya. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TYUserDefault : NSObject


+ (void)setUserDefault:(id)object forKey:(NSString *)aKey;
+ (id)getUserDefault:(NSString *)aKey;
+ (void)removeUserDefault:(NSString *)aKey;

#pragma mark - Secure

+ (void)setSecureObject:(id)object forKey:(NSString *)key;
+ (nullable id)secureObject:(NSString *)key;
+ (void)removeSecureObject:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
