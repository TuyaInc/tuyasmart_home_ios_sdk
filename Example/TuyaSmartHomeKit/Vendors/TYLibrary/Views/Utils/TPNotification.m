//
//  TPNotification.m
//  TYLibraryExample
//
//  Created by 冯晓 on 16/2/16.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TPNotification.h"
#import "TPUtils.h"

@implementation TPNotification

+ (void)addObserver:(nullable id)observer selector:(nonnull SEL)aSelector names:(nullable NSArray *)aNames object:(nullable id)anObject {
    at_dispatch_async_on_main_thread(^{
        for (NSString *name in aNames) {
            if (name.length > 0) {
                [[NSNotificationCenter defaultCenter] addObserver:observer selector:aSelector name:name object:anObject];
            }
        }
    });
}

+ (void)postNotificationName:(nonnull NSString *)aName {
    at_dispatch_async_on_main_thread(^{
        [[NSNotificationCenter defaultCenter] postNotificationName:aName object:nil];
    });
}

+ (void)postNotificationName:(nonnull NSString *)aName object:(nullable id)anObject {
    at_dispatch_async_on_main_thread(^{
        [[NSNotificationCenter defaultCenter] postNotificationName:aName object:anObject];
    });
}

+ (void)postNotificationName:(nonnull NSString *)aName object:(nullable id)anObject userInfo:(nullable NSDictionary *)aUserInfo {
    at_dispatch_async_on_main_thread(^{
        [[NSNotificationCenter defaultCenter] postNotificationName:aName object:anObject userInfo:aUserInfo];
    });
}


@end
