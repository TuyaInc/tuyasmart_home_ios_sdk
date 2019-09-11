//
//  TYNotification.h
//  TYLibraryExample
//
//  Created by 冯晓 on 16/2/16.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TYSDKNotification : NSObject

+ (void)tysdk_postNotificationName:(nonnull NSString *)aName;

+ (void)tysdk_postNotificationName:(nonnull NSString *)aName object:(nullable id)anObject;

+ (void)tysdk_postNotificationName:(nonnull NSString *)aName object:(nullable id)anObject userInfo:(nullable NSDictionary *)aUserInfo;


@end
