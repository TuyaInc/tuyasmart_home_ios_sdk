//
//  TYAppService.h
//  TuyaSmart
//
//  Created by fengyu on 15/7/3.
//  Copyright (c) 2015年 Tuya. All rights reserved.
//

#import "TPUtils.h"

@interface TYAppService : NSObject

TP_SINGLETON(TYAppService)

/**
 *  登录以后执行的操作
 */
- (void)loginDoAction;

/**
 *  APP启动以后执行的操作
 *
 *  @param launchOptions
 */
- (void)configApp:(NSDictionary *)launchOptions;

/**
 *  退出以后执行的操作
 */
- (void)signOut;

@end
