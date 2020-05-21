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
#import "TYLoginViewController.h"
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

    [[TuyaSmartSDK sharedInstance] startWithAppKey:<#your_app_key#> secretKey:<#your_secret_key#>];

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    if ([TuyaSmartUser sharedInstance].isLogin) {
        [self resetRootViewController:[TYTabBarViewController class]];
    } else {
        [self resetRootViewController:[TYLoginViewController class]];
    }
    
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

- (void)resetRootViewController:(Class)rootController {
    if ([TuyaSmartUser sharedInstance].isLogin) {
        [self loginDoAction];
    }
    [tp_topMostViewController().navigationController popToRootViewControllerAnimated:NO];
    
    TPNavigationController *navigationController = [[TPNavigationController alloc] initWithRootViewController:[rootController new]];
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
    navigationController.navigationBarHidden = YES;
}

- (void)signOut {
    [[TuyaSmartUser sharedInstance] loginOut:nil failure:nil];
    [self resetRootViewController:[TYLoginViewController class]];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:TuyaSmartUserNotificationUserSessionInvalid
                                                  object:nil];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kDefaultCurrentHomeId];
}

- (void)loginDoAction {

    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:TuyaSmartUserNotificationUserSessionInvalid
                                                  object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(sessionInvalid)
                                                 name:TuyaSmartUserNotificationUserSessionInvalid
                                               object:nil];
}

- (void)sessionInvalid {
    if ([[TuyaSmartUser sharedInstance] isLogin]) {
        [self signOut];
        
        [TPProgressUtils showError:NSLocalizedString(@"login_session_expired", nil)];
    }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:TuyaSmartUserNotificationUserSessionInvalid object:nil];
}


@end
