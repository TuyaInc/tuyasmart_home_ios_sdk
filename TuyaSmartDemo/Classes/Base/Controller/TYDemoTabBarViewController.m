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

@end
