//
//  TYAppDelegate.m
//  TuyaSmartHomeKit
//
//  Created by xuchengcheng on 06/07/2018.
//  Copyright (c) 2018 xuchengcheng. All rights reserved.
//

#import "TYAppDelegate.h"
#import "TPSignInViewController.h"
#import "TabBarViewController.h"
#import "TYAppService.h"
#import "TPNavigationController.h"

@implementation TYAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
#if DEBUG
    [[TuyaSmartSDK sharedInstance] setDebugMode:YES];
#endif
    
    //TODO: 修改AppKey和SecretKey
    [[TuyaSmartSDK sharedInstance] startWithAppKey:<#your_app_key#> secretKey:<#your_secret_key#>];
    
    [[TYAppService sharedInstance] configApp:launchOptions];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    if ([TuyaSmartUser sharedInstance].isLogin) {
        [self resetRootViewController:[TabBarViewController class]];
    } else {
        [self resetRootViewController:[TPSignInViewController class]];
    }
    
    return YES;
}

- (void)resetRootViewController:(Class)rootController {
    if ([TuyaSmartUser sharedInstance].isLogin) {
        [[TYAppService sharedInstance] loginDoAction];
    }
    [tp_topMostViewController().navigationController popToRootViewControllerAnimated:NO];
    
    TPNavigationController *navigationController = [[TPNavigationController alloc] initWithRootViewController:[rootController new]];
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
    navigationController.navigationBarHidden = YES;
}

- (void)signOut {
    [[TYAppService sharedInstance] signOut];
    [self resetRootViewController:[TPSignInViewController class]];
}


@end
