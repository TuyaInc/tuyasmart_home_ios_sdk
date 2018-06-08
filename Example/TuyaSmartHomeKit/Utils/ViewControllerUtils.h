//
//  ViewControllerUtils.h
//  TuyaSmart
//
//  Created by fengyu on 15/4/10.
//  Copyright (c) 2015年 Tuya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ViewControllerUtils : NSObject

+ (void)gotoEZPrepareViewController:(UIViewController *)fromController;
+ (void)gotoAPPrepareViewController:(UIViewController *)fromController isAPReset:(BOOL)isAPReset ssid:(NSString *)ssid password:(NSString *)password;
+ (void)gotoActivatorInputViewController:(UIViewController *)fromController mode:(TYActivatorMode)mode;
+ (void)gotoActivatorViewController:(UIViewController *)fromController ssid:(NSString *)ssid password:(NSString *)password token:(NSString *)token mode:(TYActivatorMode)mode;

+ (void)gotoContectToAPViewController:(UIViewController *)fromController ssid:(NSString *)ssid password:(NSString *)password token:(NSString *)token;

+ (void)gotoActivatorSuccessViewController:(UIViewController *)fromController device:(TuyaSmartDeviceModel *)deviceModel;
+ (void)gotoActivatorErrorViewController:(UIViewController *)fromController;

+ (void)gotoWebViewController:(NSString *)title url:(NSString *)url from:(UIViewController *)from;
+ (void)presentViewController:(UIViewController *)toController from:(UIViewController *)fromController;
+ (void)pushViewController:(UIViewController *)toController from:(UIViewController *)fromController;


@end
