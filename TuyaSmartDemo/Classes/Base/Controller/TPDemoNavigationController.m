//
//  TPNavigationController.m
//  TYLibraryExample
//
//  Created by 冯晓 on 16/2/18.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TPDemoNavigationController.h"

@interface TPDemoNavigationController() <UINavigationControllerDelegate>

@end

@implementation TPDemoNavigationController

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
    
    if (viewController == self.viewControllers[0]) {
        self.interactivePopGestureRecognizer.delegate = nil;
        // 不失效的话有问题
        self.interactivePopGestureRecognizer.enabled = NO;
        
    } else {
        self.interactivePopGestureRecognizer.delegate = (id)self;
        self.interactivePopGestureRecognizer.enabled = YES;
    }
    
    
}

@end
