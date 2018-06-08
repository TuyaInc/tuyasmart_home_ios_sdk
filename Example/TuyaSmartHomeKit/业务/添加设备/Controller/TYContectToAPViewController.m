//
//  TYContectToAPViewController.m
//  TuyaSmart
//
//  Created by fengyu on 15/4/10.
//  Copyright (c) 2015年 Tuya. All rights reserved.
//

#import "TYContectToAPViewController.h"
#import "TYContectToAPView.h"
#import <Reachability/Reachability.h>

@interface TYContectToAPViewController() <TYConnectToAPViewDelegate>

@end

@implementation TYContectToAPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)initView {
    self.view.backgroundColor = MAIN_BACKGROUND_COLOR;
    
    [self initTopBarView];
    [self initActivatorPrepareView];
}

- (void)initTopBarView {
    self.topBarView.leftItem = self.leftBackItem;
    self.centerTitleItem.title = NSLocalizedString(@"ty_ez_connecting_device_title", @"");
    self.topBarView.centerItem = self.centerTitleItem;
    self.topBarView.rightItem = nil;
    
    [self.view addSubview:self.topBarView];
}

- (void)initActivatorPrepareView {
    TYContectToAPView *contectToAPView = [[TYContectToAPView alloc] initWithFrame:CGRectMake(0, APP_TOP_BAR_HEIGHT, APP_SCREEN_WIDTH, APP_VISIBLE_HEIGHT)];
    contectToAPView.delegate = self;
    [self.view addSubview:contectToAPView];
}

- (void)reachabilityChanged:(NSNotification *)notification {
    if ([UIApplication sharedApplication].applicationState != UIApplicationStateActive) {
        return;
    }
    
    /**
     *  设备ssid目前有4种情况: 1.TuyaSmart-xxxx 2.SmartLife-xxx 3.prefix-xxxx 4.prefix-TLinkAP-xxxx
     */
    NSString *ssid = [TuyaSmartActivator currentWifiSSID];
    if ([ssid hasPrefix:AP_SSID_PREFIX]
        || [ssid hasPrefix:@"SmartLife"]
        || [ssid hasPrefix:@"TuyaSmart"]
        || [ssid rangeOfString:@"TLinkAP" options:NSCaseInsensitiveSearch].length > 0) {
        [ViewControllerUtils gotoActivatorViewController:self ssid:_ssid password:_password token:_token mode:TYActivatorModeAP];
    }
}

- (void)backButtonTap {
    [super backButtonTap];
}

#pragma mark - TYConnectToAPViewDelegate

- (void)helpAction:(TYContectToAPView *)connectToAPView {
    [ViewControllerUtils gotoWebViewController:NSLocalizedString(@"ty_ez_help", @"") url:@"http://smart.tuya.com/reset" from:self];
}

- (void)nextAction:(TYContectToAPView *)connectToAPView {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=WIFI"]];
}

@end
