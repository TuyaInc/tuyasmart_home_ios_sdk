//
//  TYAppDelegate.m
//  TuyaSmartHomeKit
//
//  Created by xuchengcheng on 06/07/2018.
//  Copyright (c) 2018 xuchengcheng. All rights reserved.
//

#import "TYAppDelegate.h"
#import <TuyaSmartDemo/TYDemoApplicationImpl.h>
#import <TuyaSmartDemo/TYDemoConfiguration.h>

#define APP_KEY @"<#(nonnull NSString *)#>"
#define APP_SECRET_KEY @"<#(nonnull NSString *)#>"
/*
 doc link
 
 en:https://tuyainc.github.io/tuyasmart_home_ios_sdk_doc/en/
 zh-hans:https://tuyainc.github.io/tuyasmart_home_ios_sdk_doc/zh-hans/
 */

@interface TYAppDelegate()

@end

@implementation TYAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    TYDemoConfigModel *config = [[TYDemoConfigModel alloc] init];
    config.appKey = APP_KEY;
    config.secretKey = APP_SECRET_KEY;

    return [[TYDemoApplicationImpl sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions config:config];
}


@end
