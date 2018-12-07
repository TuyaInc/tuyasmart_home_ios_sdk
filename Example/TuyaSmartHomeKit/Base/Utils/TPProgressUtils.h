//
//  TPProgressUtils.h
//  TYLibraryExample
//
//  Created by 冯晓 on 16/2/17.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MBProgressHUD/MBProgressHUD.h>

@interface TPProgressUtils : NSObject

/**
 *
 error 支持 NSString、NSError类型
 */
+ (void)showError:(id)error;

+ (void)showSuccess:(NSString *)success toView:(UIView *)view;

+ (MBProgressHUD *)showMessag:(NSString *)message toView:(UIView *)view;

+ (MBProgressHUD *)showMessagBelowTopbarView:(NSString *)message toView:(UIView *)view;

+ (void)showSuccess:(NSString *)success toView:(UIView *)view block:(MBProgressHUDCompletionBlock)block;

+ (BOOL)hideHUDForView:(UIView *)view animated:(BOOL)animated;

+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view delay:(float)delay block:(MBProgressHUDCompletionBlock)block;

@end
