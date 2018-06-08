//
//  ViewControllerUtils.m
//  TuyaSmart
//
//  Created by fengyu on 15/4/10.
//  Copyright (c) 2015年 Tuya. All rights reserved.
//

#import "ViewControllerUtils.h"
#import "TYEZPrepareViewController.h"
#import "TYEZModeViewController.h"
#import "TYSearchOneDeviceController.h"
#import "TYActivatorFinishViewController.h"
#import "TYContectToAPViewController.h"
#import "TPWebViewController.h"
#import "TPNavigationController.h"
#import "TYAPPrepareViewController.h"

@implementation ViewControllerUtils

+ (void)gotoEZPrepareViewController:(UIViewController *)fromController {
    [self presentViewController:[TYEZPrepareViewController new] from:fromController];
}

+ (void)gotoAPPrepareViewController:(UIViewController *)fromController isAPReset:(BOOL)isAPReset ssid:(NSString *)ssid password:(NSString *)password {
    TYAPPrepareViewController *vc = [TYAPPrepareViewController new];
    vc.isAPReset = isAPReset;
    vc.ssid = ssid;
    vc.password = password;
    [self pushViewController:vc from:fromController];
}

+ (void)gotoActivatorInputViewController:(UIViewController *)fromController mode:(TYActivatorMode)mode {
    TYEZModeViewController *vc = [TYEZModeViewController new];
    vc.mode = mode;
    [self pushViewController:vc from:fromController];
}

+ (void)gotoActivatorViewController:(UIViewController *)fromController ssid:(NSString *)ssid password:(NSString *)password token:(NSString *)token mode:(TYActivatorMode)mode {
    TYSearchOneDeviceController *toController = [TYSearchOneDeviceController new];
    toController.ssid = ssid;
    toController.password = password;
    toController.token = token;
    toController.mode = mode;
    [self pushViewController:toController from:fromController];
}

+ (void)gotoContectToAPViewController:(UIViewController *)fromController ssid:(NSString *)ssid password:(NSString *)password token:(NSString *)token {
    TYContectToAPViewController *vc = [TYContectToAPViewController new];
    vc.ssid = ssid;
    vc.password = password;
    vc.token = token;
    [self pushViewController:vc from:fromController];
}

+ (void)gotoActivatorSuccessViewController:(UIViewController *)fromController device:(TuyaSmartDeviceModel *)deviceModel {
    TYActivatorFinishViewController *vc = [TYActivatorFinishViewController new];
    vc.isSuccess = YES;
    vc.deviceModel = deviceModel;
    [self pushViewController:vc from:fromController];
}

+ (void)gotoActivatorErrorViewController:(UIViewController *)fromController {
    TYActivatorFinishViewController *vc = [TYActivatorFinishViewController new];
    vc.isSuccess = NO;
    [self pushViewController:vc from:fromController];
}

+ (void)gotoWebViewController:(NSString *)title url:(NSString *)url from:(UIViewController *)from {
    TPWebViewController *webViewController = [[TPWebViewController alloc] initWithUrlString:url];
    webViewController.title = title;
    [self pushViewController:webViewController from:from];
}

+ (void)presentViewController:(UIViewController *)toController from:(UIViewController *)fromController {
    if (fromController == nil) {
        fromController = tp_topMostViewController();
    }
    
    TPNavigationController *navigationController = [[TPNavigationController alloc] initWithRootViewController:toController];
    [fromController presentViewController:navigationController animated:YES completion:nil];
}


+ (void)pushViewController:(UIViewController *)toController from:(UIViewController *)fromController {
    if (fromController == nil) {
        fromController = tp_topMostViewController();
    }
    
    [fromController.navigationController pushViewController:toController animated:YES];
}

@end
