//
//  TYAPPrepareViewController.m
//  TuyaSmartPublic
//
//  Created by 高森 on 16/5/7.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TYAPPrepareViewController.h"
#import "TYEZPrepareView.h"
#import "ViewControllerUtils.h"

@interface TYAPPrepareViewController () <TYEZPrepareViewDelegate>

@property (nonatomic, strong) TYEZPrepareView       *prepareView;

@end

@implementation TYAPPrepareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)initView {
    self.view.backgroundColor = MAIN_BACKGROUND_COLOR;
    [self initTopBarView];
    [self initEZPrepareView];
}

- (void)initTopBarView {
    self.topBarView.leftItem = self.isAPReset ? self.leftCancelItem : self.leftBackItem;
    self.centerTitleItem.title = NSLocalizedString(@"home_add_device", @"");
    self.topBarView.centerItem = self.centerTitleItem;
    [self.view addSubview:self.topBarView];
}

- (void)initEZPrepareView {
    _prepareView = [[TYEZPrepareView alloc] initWithFrame:CGRectMake(0, APP_TOP_BAR_HEIGHT, APP_SCREEN_WIDTH, APP_VISIBLE_HEIGHT) mode:TYActivatorModeAP];
    _prepareView.delegate = self;
    if (self.isAPReset) {
        [_prepareView setTipText:NSLocalizedString(@"ty_add_device_ez_failure_ap_tip", @"")];
    }
    [self.view addSubview:_prepareView];
}

- (void)CancelButtonTap {
    [super CancelButtonTap];
}

#pragma mark - TYEZPrepareViewDelegate

- (void)helpAction:(TYEZPrepareView *)prepareView {
    [ViewControllerUtils gotoWebViewController:NSLocalizedString(@"ty_ez_help", @"") url:@"https://images.tuyacn.com/smart/connect-scheme-v3/help/common_network_slow.html" from:self];
}

- (void)nextAction:(TYEZPrepareView *)prepareView {
    if (self.isAPReset) {
        WEAKSELF_AT
        [TPProgressUtils showMessag:NSLocalizedString(@"loading", @"") toView:nil];

        [[TuyaSmartActivator sharedInstance] getTokenWithHomeId:[TYHomeManager sharedInstance].home.homeModel.homeId success:^(NSString *token) {
            [TPProgressUtils hideHUDForView:nil animated:NO];
            [ViewControllerUtils gotoContectToAPViewController:weakSelf_AT ssid:_ssid password:_password token:token];
        } failure:^(NSError *error) {
            [TPProgressUtils hideHUDForView:nil animated:NO];
            [TPProgressUtils showError:error.localizedDescription];
        }];
    } else {
        [ViewControllerUtils gotoActivatorInputViewController:self mode:TYActivatorModeAP];
    }
}

@end
