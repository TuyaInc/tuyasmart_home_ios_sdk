//
//  TPProgressUtils.m
//  TYLibraryExample
//
//  Created by 冯晓 on 16/2/17.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TPDemoProgressUtils.h"
#import "TPDemoTopBarView.h"
#import "TPDemoViewConstants.h"
#import "TPDemoUtils.h"



@implementation TPDemoProgressUtils

#pragma mark - Public Method
+ (void)showError:(id)error {
    if ([error isKindOfClass:[NSString class]]) {
        
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:error
                                                         message:nil
                                                        delegate:nil
                                               cancelButtonTitle:NSLocalizedString(@"ty_alert_confirm", nil)
                                               otherButtonTitles:nil];
        [alert show];
        
    } else if ([error isKindOfClass:[NSError class]]) {
        
        NSError *nsError = (NSError *)error;
        
        [TPDemoProgressUtils showError:nsError.localizedDescription];

        
        
    }
    
    
}

+ (void)showSuccess:(NSString *)success toView:(UIView *)view {
    [TPDemoProgressUtils show:success icon:@"TPViews.bundle/tp_progress_success" view:view delay:1.5 block:nil];
}

+ (void)showSuccess:(NSString *)success toView:(UIView *)view block:(MBProgressHUDCompletionBlock)block {
    [TPDemoProgressUtils show:success icon:@"TPViews.bundle/tp_progress_success" view:view delay:1.5 block:block];
}

+ (MBProgressHUD *)showMessag:(NSString *)message toView:(UIView *)view {
    [TPDemoProgressUtils hideHUDForView:view animated:NO];
    
    if (view == nil) view = [self getKeyWindow];
    
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    hud.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    hud.labelText = message;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
    hud.dimBackground = YES;
    [hud show:YES];
    hud.layer.zPosition = MAXFLOAT;
    return hud;
}

+ (MBProgressHUD *)showMessagBelowTopbarView:(NSString *)message toView:(UIView *)view {
    [TPDemoProgressUtils hideHUDForView:view animated:NO];
    if (view == nil) view = [self getKeyWindow];
    
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = message;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
    hud.dimBackground = YES;
    
    
    UIView *topbarView = [view viewWithTag:TPTopBarViewTag];
    if (topbarView) {
        [view bringSubviewToFront:topbarView];
    }
    
    return hud;
}

+ (BOOL)hideHUDForView:(UIView *)view animated:(BOOL)animated {
    if (view == nil) view = [self getKeyWindow];
    return [MBProgressHUD hideAllHUDsForView:view animated:animated];
}


#pragma mark - Private
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view delay:(float)delay block:(MBProgressHUDCompletionBlock)block
{
    [TPDemoProgressUtils hideHUDForView:nil animated:NO];
    
    if (view == nil) view = [TPDemoProgressUtils getKeyWindow];
    
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];

    float width = [text boundingRectWithSize:CGSizeMake(400, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : hud.labelFont} context:nil].size.width;
    
    if (width > 250) {
        hud.detailsLabelText = text;
    } else {
        hud.labelText = text;
    }
    
    //    hud.detailsLabelText = text;
    // 设置图片
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:icon]];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    //delay秒之后再消失
    [hud hide:YES afterDelay:delay];
    
    hud.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    hud.layer.zPosition = MAXFLOAT;
    
    if (block) {
        hud.completionBlock = block;
    }
}

+ (UIView *)getKeyWindow {
    UIWindow *mainWindow = [UIApplication sharedApplication].keyWindow;
    if (mainWindow == nil) {
        mainWindow = [[UIApplication sharedApplication].windows firstObject];
    }
    return mainWindow;
}




@end
