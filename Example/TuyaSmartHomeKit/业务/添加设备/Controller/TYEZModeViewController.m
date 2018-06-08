//
//  TYEZModeViewController.m
//  TuyaSmart
//
//  Created by fengyu on 15/3/2.
//  Copyright (c) 2015年 Tuya. All rights reserved.
//

#import "TYEZModeViewController.h"
#import "TYEZAddDeviceView.h"
#import <Reachability/Reachability.h>

@interface TYEZModeViewController ()

@property(nonatomic,strong) TYEZAddDeviceView *addDeviceView;

@end

@implementation TYEZModeViewController

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initView];
    [self initDefaultNetworkSetting];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

- (void)initView {
    self.view.backgroundColor = MAIN_BACKGROUND_COLOR;
    
    [self initTopBarView];
    [self initAddDeviceView];
}

- (void)initTopBarView {
    self.topBarView.leftItem = self.leftBackItem;
    
    self.centerTitleItem.title = NSLocalizedString(@"ty_ez_wifi_title", @"");
    self.topBarView.centerItem = self.centerTitleItem;
    
    self.topBarView.rightItem = nil;
    
    [self.view addSubview:self.topBarView];
}

- (void)initAddDeviceView {
    _addDeviceView = [[TYEZAddDeviceView alloc] initWithFrame:CGRectMake(0, APP_TOP_BAR_HEIGHT, APP_SCREEN_WIDTH, APP_VISIBLE_HEIGHT)];
    [_addDeviceView.ssidView addGestureRecognizer:[TPViewUtil singleFingerClickRecognizer:self sel:@selector(gotoSystemSetting)]];
    [_addDeviceView.nextButton addTarget:self action:@selector(nextButtonTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_addDeviceView];
}

- (void)gotoSystemSetting {
    NSURL *url = [NSURL URLWithString:@"App-Prefs:root=WIFI"];
    if (TP_SYSTEM_VERSION < 10.0) {
        [[UIApplication sharedApplication] openURL:url];
    } else {
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL success) {
            ;
        }];
    }
}

- (void)initDefaultNetworkSetting {
    _addDeviceView.ssid = [TuyaSmartActivator currentWifiSSID];
}

- (void)nextButtonTap:(UIButton *)button {
    NSString *ssid     = [TuyaSmartActivator currentWifiSSID];
    
    if (ssid.length == 0) {
        [TPProgressUtils showError:NSLocalizedString(@"connect_phone_to_network", nil)];
        return;
    }
    
    if (![TPUtils IsEnableInternet]) {
        [TPProgressUtils showError:NSLocalizedString(@"network_time_out", nil)];
        return;
    }
    
    if (_mode == TYActivatorModeEZ && [ssid hasSuffix:@"5G"]) {
        WEAKSELF_AT
        [UIAlertView bk_showAlertViewWithTitle:nil
                                       message:NSLocalizedString(@"ez_notSupport_5G_tip", nil)
                             cancelButtonTitle:NSLocalizedString(@"ez_notSupport_5G_continue", nil)
                             otherButtonTitles:@[NSLocalizedString(@"ez_notSupport_5G_change", nil)]
                                       handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
                                 
                                         if (buttonIndex == 0) {
                                             [weakSelf_AT gotoActivatorViewController];
                                         } else {
                                             [weakSelf_AT gotoSystemSetting];
                                         }
                             }];
        
    } else {
         [self gotoActivatorViewController];
    }
    
}

- (void)gotoActivatorViewController {
    
    WEAKSELF_AT
    [TPProgressUtils showMessag:NSLocalizedString(@"loading", @"") toView:nil];
    [[TuyaSmartActivator sharedInstance] getTokenWithHomeId:[TYHomeManager sharedInstance].home.homeModel.homeId success:^(NSString *token) {
        [TPProgressUtils hideHUDForView:nil animated:NO];
        
        NSString *ssid = [TuyaSmartActivator currentWifiSSID];
        NSString *password = weakSelf_AT.addDeviceView.password;
        
        if (weakSelf_AT.mode == TYActivatorModeEZ) {
            [ViewControllerUtils gotoActivatorViewController:weakSelf_AT ssid:ssid password:password token:token mode:weakSelf_AT.mode];
        } else {
            [ViewControllerUtils gotoContectToAPViewController:weakSelf_AT ssid:ssid password:password token:token];
        }
    } failure:^(NSError *error) {
        [TPProgressUtils hideHUDForView:nil animated:NO];
        [TPProgressUtils showError:error.localizedDescription];
    }];
}

- (void)reachabilityChanged:(NSNotification *)notification {
    [self initDefaultNetworkSetting];
}

@end
