//
//  TYTabBarViewController.m
//  TuyaSmart
//
//  Created by fengyu on 15/2/9.
//  Copyright (c) 2015年 Tuya. All rights reserved.
//

#import "TYTabBarViewController.h"
#import "TPNavigationController.h"
#import "TYLoginViewController.h"
#import "TYDeviceListViewController.h"
#import "TYSmartSceneViewController.h"
#import "TYAddDeviceMenuViewController.h"
#import "TYSmartHomeManager.h"

@interface TYTabBarViewController() <UITabBarControllerDelegate>

@property (nonatomic, strong) TPNavigationController *deviceListNavigationController;
@property (nonatomic, strong) TPNavigationController *addDeviceNavigationController;
@property (nonatomic, strong) TPNavigationController *loginNavigationController;
@property (nonatomic, strong) TPNavigationController *sceneNavigationController;

@property (nonatomic, strong) UIViewController       *addDeviceViewController;
@property (nonatomic, strong) TYDeviceListViewController *deviceViewController;
@property (nonatomic, strong) TYSmartSceneViewController *sceneViewController;

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
    
    self.delegate = self;
    
    self.automaticallyAdjustsScrollViewInsets = NO;

    [self setupControllers];
}

- (void)setupControllers {
    [self customView];
    self.viewControllers = @[
                             self.loginNavigationController,
                             self.deviceListNavigationController,
                             self.addDeviceNavigationController,
                             self.sceneNavigationController
                             ];
}


- (void)customView {
    [self.tabBar setTintColor:TAB_BAR_TEXT_COLOR];
    self.tabBar.translucent  = NO;
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

- (TPNavigationController *)loginNavigationController {
    if (!_loginNavigationController) {
        TYLoginViewController *loginViewController = [TYLoginViewController new];
        
        [loginViewController setTitle:@"Login"];
        loginViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Login"
                                                                     image:[UIImage imageNamed:@"ty_mainbt_about"]
                                                             selectedImage:[UIImage imageNamed:@"ty_mainbt_about_active"]];
        _loginNavigationController = [[TPNavigationController alloc] initWithRootViewController:loginViewController];
    }
    return _loginNavigationController;
}


- (TYDeviceListViewController *)deviceViewController {
    if (!_deviceViewController) {
        _deviceViewController = [TYDeviceListViewController new];
        [_deviceViewController setTitle:@"Device"];
        _deviceViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Device"
                                                                         image:[UIImage imageNamed:@"ty_mainbt_devicelist"]
                                                                 selectedImage:[UIImage imageNamed:@"ty_mainbt_devicelist_active"]];
    }
    return _deviceViewController;
}

- (TPNavigationController *)sceneNavigationController {
    if (!_sceneNavigationController) {
        _sceneNavigationController = [[TPNavigationController alloc] initWithRootViewController:self.sceneViewController];
    }
    return _sceneNavigationController;
}

- (UIViewController *)addDeviceViewController {
    if (!_addDeviceViewController) {
        _addDeviceViewController = [TYAddDeviceMenuViewController new];
        [_addDeviceViewController setTitle:@"Activate"];
        _addDeviceViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Activate"
                                                                            image:[UIImage imageNamed:@"ty_mainbt_add"]
                                                                    selectedImage:[UIImage imageNamed:@"ty_mainbt_add_active"]];
    }
    return _addDeviceViewController;
}

- (TYSmartSceneViewController *)sceneViewController {
    if (!_sceneViewController) {
        _sceneViewController = [[TYSmartSceneViewController alloc] init];
        _sceneViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Scene"
                                                                        image:[UIImage imageNamed:@"ty_scene_gray"]
                                                                selectedImage:[UIImage imageNamed:@"ty_scene_active"]];
    }
    return _sceneViewController;
}

#pragma mark - UITabBarControllerDelegate

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    
    if (![TuyaSmartUser sharedInstance].isLogin &&
        viewController != self.loginNavigationController &&
        ![TYSmartHomeManager sharedInstance].currentHome) {
        
        UIAlertView *alert = [UIAlertView bk_alertViewWithTitle:@"Attention" message:@"Login to visity this page." ];
        [alert bk_setCancelButtonWithTitle:@"OK" handler:NULL];
        [alert show];
        
        return NO;
    }
    
    return YES;
}
@end
