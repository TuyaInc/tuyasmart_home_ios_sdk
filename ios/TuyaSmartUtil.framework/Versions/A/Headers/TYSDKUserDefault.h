//
//  TYUserDefault.h
//  TuyaSmart
//
//  Created by fengyu on 15/4/7.
//  Copyright (c) 2015年 Tuya. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TYSDKUserDefault : NSObject

+ (void)tysdk_setUserDefault:(id)object forKey:(NSString *)aKey;
+ (id)tysdk_getUserDefault:(NSString *)aKey;
+ (void)tysdk_removeUserDefault:(NSString *)aKey;

@end

NS_ASSUME_NONNULL_END
