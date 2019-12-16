//
//  TYAppDelegate.m
//  TuyaSmartHomeKit
//
//  Created by xuchengcheng on 06/07/2018.
//  Copyright (c) 2018 xuchengcheng. All rights reserved.
//

#import "TYAppDelegate.h"
#import "TYTabBarViewController.h"
#import "TPNavigationController.h"
#import <UserNotifications/UserNotifications.h>

/*
 doc link
 
 en:https://tuyainc.github.io/tuyasmart_home_ios_sdk_doc/en/
 zh-hans:https://tuyainc.github.io/tuyasmart_home_ios_sdk_doc/zh-hans/
 */

@interface TYAppDelegate() <UNUserNotificationCenterDelegate>

@end

@implementation TYAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
#if DEBUG
    [[TuyaSmartSDK sharedInstance] setDebugMode:YES];
#endif
    
//    [TuyaSmartSDK sharedInstance].appGroupId = APP_GROUP_NAME;
    [[TuyaSmartSDK sharedInstance] startWithAppKey:SDK_APPKEY secretKey:SDK_APPSECRET];

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    TPNavigationController *navigationController = [[TPNavigationController alloc] initWithRootViewController:[TYTabBarViewController new]];
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
    navigationController.navigationBarHidden = YES;
    
    // notification
    [application registerForRemoteNotifications];
    [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
    
    if (@available(iOS 10.0, *)) {
        //Codes below is essential in iOS10 or above.
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        UNAuthorizationOptions types10 = UNAuthorizationOptionBadge|UNAuthorizationOptionAlert|UNAuthorizationOptionSound;
        [center requestAuthorizationWithOptions:types10 completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (granted) {
                //Allow
            } else {
                //Deny
            }
        }];
    }
    
    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    [TuyaSmartSDK sharedInstance].deviceToken = deviceToken;
}

@end
