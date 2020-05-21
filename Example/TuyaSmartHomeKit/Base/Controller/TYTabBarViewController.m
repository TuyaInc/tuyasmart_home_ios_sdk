//
//  TYTabBarViewController.m
//  TuyaSmart
//
//  Created by fengyu on 15/2/9.
//  Copyright (c) 2015年 Tuya. All rights reserved.
//

#import "TYTabBarViewController.h"
#import "TPNavigationController.h"
#import "TYDeviceListViewController.h"
#import "TYSmartSceneViewController.h"
#import "TYAddDeviceMenuViewController.h"
#import "TYUserInfoViewController.h"

@interface TYTabBarViewController()

@property (nonatomic, strong) TPNavigationController *deviceListNavigationController;
@property (nonatomic, strong) TPNavigationController *addDeviceNavigationController;
@property (nonatomic, strong) TPNavigationController *sceneNavigationController;
@property (nonatomic, strong) TPNavigationController *userNavigationController;

@property (nonatomic, strong) UIViewController       *addDeviceViewController;
@property (nonatomic, strong) TYDeviceListViewController *deviceViewController;
@property (nonatomic, strong) TYSmartSceneViewController *sceneViewController;
@property (nonatomic, strong) TYUserInfoViewController *userViewController;

@end

@implementation TYTabBarViewController

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
    self.viewControllers = @[
                             self.deviceListNavigationController,
                             self.addDeviceNavigationController,
                             self.sceneNavigationController,
                             self.userNavigationController
                             ];
}

- (void)customView {
    [self.tabBar setTintColor:TAB_BAR_TEXT_COLOR];
    self.tabBar.translucent = NO;
    UIView *view = [[UIView alloc] initWithFrame:self.tabBar.bounds];
    view.height = IPhoneX ? 83 : self.tabBar.height;
    view.backgroundColor = TAB_BAR_BACKGROUND_COLOR;
    [[UITabBar appearance] insertSubview:view atIndex:0];
}

- (TPNavigationController *)deviceListNavigationController {
    if (!_deviceListNavigationController) {
        _deviceListNavigationController = [[TPNavigationController alloc] initWithRootViewController:self.deviceViewController];
    }
    return _deviceListNavigationController;
}

- (TPNavigationController *)addDeviceNavigationController {
    if (!_addDeviceNavigationController) {
        _addDeviceNavigationController = [[TPNavigationController alloc] initWithRootViewController:self.addDeviceViewController];
    }
    return _addDeviceNavigationController;
}

- (TPNavigationController *)sceneNavigationController {
    if (!_sceneNavigationController) {
        _sceneNavigationController = [[TPNavigationController alloc] initWithRootViewController:self.sceneViewController];
    }
    return _sceneNavigationController;
}

- (TPNavigationController *)userNavigationController {
    if (!_userNavigationController) {
        _userNavigationController = [[TPNavigationController alloc] initWithRootViewController:self.userViewController];
    }
    return _userNavigationController;
}

- (TYDeviceListViewController *)deviceViewController {
    if (!_deviceViewController) {
        _deviceViewController = [TYDeviceListViewController new];
        [_deviceViewController setTitle:NSLocalizedString(@"Device", @"")];
        _deviceViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"Device", @"")
                                                                         image:[UIImage imageNamed:@"ty_mainbt_devicelist"]
                                                                 selectedImage:[UIImage imageNamed:@"ty_mainbt_devicelist_active"]];
    }
    return _deviceViewController;
}

- (UIViewController *)addDeviceViewController {
    if (!_addDeviceViewController) {
        _addDeviceViewController = [TYAddDeviceMenuViewController new];
        [_addDeviceViewController setTitle:NSLocalizedString(@"Activate", @"")];
        _addDeviceViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"Activate", @"")
                                                                            image:[UIImage imageNamed:@"ty_mainbt_add"]
                                                                    selectedImage:[UIImage imageNamed:@"ty_mainbt_add_active"]];
    }
    return _addDeviceViewController;
}

- (TYSmartSceneViewController *)sceneViewController {
    if (!_sceneViewController) {
        _sceneViewController = [[TYSmartSceneViewController alloc] init];
        _sceneViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"ty_smart_scene", @"")
                                                                        image:[UIImage imageNamed:@"ty_scene_gray"]
                                                                selectedImage:[UIImage imageNamed:@"ty_scene_active"]];
    }
    return _sceneViewController;
}

- (TYUserInfoViewController *)userViewController {
    if (!_userViewController) {
        _userViewController = [[TYUserInfoViewController alloc] init];
        _userViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"personal_center", @"")
                                                                        image:[UIImage imageNamed:@"ty_mainbt_about"]
                                                                selectedImage:[UIImage imageNamed:@"ty_mainbt_about_active"]];
    }
    return _userViewController;
}

@end
