//
//  TabBarViewController.m
//  TuyaSmart
//
//  Created by fengyu on 15/2/9.
//  Copyright (c) 2015年 Tuya. All rights reserved.
//

#import "TabBarViewController.h"
#import "UserViewController.h"
#import "TYDeviceListController.h"
#import "TPNavigationController.h"

@interface TabBarViewController() <UITabBarControllerDelegate>

@property (nonatomic, strong) TPNavigationController *deviceListNavigationController;
@property (nonatomic, strong) TPNavigationController *addDeviceNavigationController;
@property (nonatomic, strong) TPNavigationController *profileNavigationController;


@property (nonatomic, strong) UIViewController       *addDeviceViewController;
@property (nonatomic, strong) TYDeviceListController *deviceViewController;
@property (nonatomic, strong) UserViewController     *myViewController;

@end

@implementation TabBarViewController

- (id)init {
    self = [super init];
    if (self) {
        self.selectedIndex = 0;
    }
    return self;
}

- (id)initWithSelectedIndex:(NSInteger)index {
    if (self = [super init]) {
        self.selectedIndex = index;
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
                             self.deviceListNavigationController,
                             self.addDeviceNavigationController,
                             self.profileNavigationController
                             ];
}


- (void)customView {
    [self.tabBar setTintColor:TAB_BAR_TEXT_COLOR];
    self.tabBar.translucent  = NO;
    UIView *view = [[UIView alloc] initWithFrame:self.tabBar.bounds];
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

- (TPNavigationController *)profileNavigationController {
    if (!_profileNavigationController) {
        _profileNavigationController = [[TPNavigationController alloc] initWithRootViewController:self.myViewController];
    }
    return _profileNavigationController;
}


- (TYDeviceListController *) deviceViewController {
    if (!_deviceViewController) {
        _deviceViewController = [TYDeviceListController new];
        [_deviceViewController setTitle:NSLocalizedString(@"my_smart_home", @"")];
        _deviceViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"my_smart_home", @"")
                                                                         image:[UIImage imageNamed:@"ty_mainbt_devicelist.png"]
                                                                 selectedImage:[UIImage imageNamed:@"ty_mainbt_devicelist_active.png"]];
    }
    return _deviceViewController;
}


- (UIViewController *)addDeviceViewController {
    if (!_addDeviceViewController) {
        _addDeviceViewController = [UIViewController new];
        [_addDeviceViewController setTitle:NSLocalizedString(@"home_add_device", @"")];
        _addDeviceViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"home_add_device", @"")
                                                                            image:[UIImage imageNamed:@"ty_mainbt_add.png"]
                                                                    selectedImage:[UIImage imageNamed:@"ty_mainbt_add_active.png"]];
    }
    return _addDeviceViewController;
}

- (UserViewController *)myViewController {
    if (!_myViewController) {
        _myViewController = [UserViewController new];
        [_myViewController setTitle:NSLocalizedString(@"personal_center", @"")];
        _myViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"personal_center", @"")
                                                                     image:[UIImage imageNamed:@"ty_mainbt_about.png"]
                                                             selectedImage:[UIImage imageNamed:@"ty_mainbt_about_active"]];
    }
    return _myViewController;
}

#pragma mark -
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    if (viewController == self.addDeviceNavigationController) {
        [ViewControllerUtils gotoEZPrepareViewController:self];
        return NO;
    } else {
        return YES;
    }
}
@end
