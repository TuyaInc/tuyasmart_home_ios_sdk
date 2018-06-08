//
//  TPNavigationController.m
//  TYLibraryExample
//
//  Created by 冯晓 on 16/2/18.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TPNavigationController.h"
#import "UIViewController+TPCategory.h"

@interface TPNavigationController() <UINavigationControllerDelegate>

@property (nonatomic, assign) BOOL isDisable;

@end

@implementation TPNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.childViewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    
    if (!_isDisable) {
        // 自定义返回按钮时候需要处理
        if (viewController == self.viewControllers[0]) {
            self.interactivePopGestureRecognizer.delegate = nil;
            // 不失效的话有问题
            self.interactivePopGestureRecognizer.enabled = NO;
            
        } else {
            self.interactivePopGestureRecognizer.delegate = (id)self;
            self.interactivePopGestureRecognizer.enabled = YES;
        }
    } else {
        self.interactivePopGestureRecognizer.delegate = nil;
        // 不失效的话有问题
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    
    
}

- (void)enablePopGesture {
    _isDisable = NO;
    self.interactivePopGestureRecognizer.delegate = (id)self;
    self.interactivePopGestureRecognizer.enabled = YES;
}

- (void)disablePopGesture {
    _isDisable = YES;
    self.interactivePopGestureRecognizer.delegate = nil;
    self.interactivePopGestureRecognizer.enabled = NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return [self.topViewController preferredStatusBarStyle];
}

@end
