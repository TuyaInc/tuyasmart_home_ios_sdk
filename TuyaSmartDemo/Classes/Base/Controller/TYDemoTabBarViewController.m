//
//  TYTabBarViewController.m
//  TuyaSmart
//
//  Created by fengyu on 15/2/9.
//  Copyright (c) 2015年 Tuya. All rights reserved.
//

#import "TYDemoTabBarViewController.h"
#import "TPDemoNavigationController.h"

#import "TYDemoConfiguration.h"

@interface TYDemoTabBarViewController()

@end

@implementation TYDemoTabBarViewController

- (id)init {
    self = [super init];
    if (self) {
        self.selectedIndex = 0;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    self.automaticallyAdjustsScrollViewInsets = NO;

    [self setupControllers];
}

- (void)setupControllers {
    [self customView];
    self.viewControllers = [TYDemoConfiguration sharedInstance].tabBars;
}

- (void)customView {
    [self.tabBar setTintColor:TAB_BAR_TEXT_COLOR];
    self.tabBar.translucent = NO;
    UIView *view = [[UIView alloc] initWithFrame:self.tabBar.bounds];
    view.height = IPhoneX ? 83 : self.tabBar.height;
    view.backgroundColor = TAB_BAR_BACKGROUND_COLOR;
    [[UITabBar appearance] insertSubview:view atIndex:0];
}

//- (TPNavigationController *)sceneNavigationController {
//    if (!_sceneNavigationController) {
//        _sceneNavigationController = [[TPNavigationController alloc] initWithRootViewController:self.sceneViewController];
//    }
//    return _sceneNavigationController;
//}
//
//- (TPNavigationController *)userNavigationController {
//    if (!_userNavigationController) {
//        _userNavigationController = [[TPNavigationController alloc] initWithRootViewController:self.userViewController];
//    }
//    return _userNavigationController;
//}
//
//

//
//- (TYUserInfoViewController *)userViewController {
//    if (!_userViewController) {
//        _userViewController = [[TYUserInfoViewController alloc] init];
//        _userViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"personal_center", @"")
//                                                                        image:[UIImage imageNamed:@"ty_mainbt_about"]
//                                                                selectedImage:[UIImage imageNamed:@"ty_mainbt_about_active"]];
//    }
//    return _userViewController;
//}

@end
