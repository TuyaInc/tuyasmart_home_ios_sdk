//
//  TPNotification.h
//  TYLibraryExample
//
//  Created by 冯晓 on 16/2/16.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TPNotification : NSObject


+ (void)addObserver:(nullable id)observer selector:(nonnull SEL)aSelector names:(nullable NSArray *)aNames object:(nullable id)anObject;

+ (void)postNotificationName:(nonnull NSString *)aName;

+ (void)postNotificationName:(nonnull NSString *)aName object:(nullable id)anObject;

+ (void)postNotificationName:(nonnull NSString *)aName object:(nullable id)anObject userInfo:(nullable NSDictionary *)aUserInfo;


@end
