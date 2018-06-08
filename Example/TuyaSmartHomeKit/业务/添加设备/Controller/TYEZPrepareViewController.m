//
//  TYEZPrepareViewController.m
//  TuyaSmartPublic
//
//  Created by 高森 on 16/3/29.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TYEZPrepareViewController.h"
#import "TYEZPrepareView.h"
#import "ViewControllerUtils.h"

@interface TYEZPrepareViewController () <TYEZPrepareViewDelegate>

@property (nonatomic, strong) TYEZPrepareView       *prepareView;

@end

@implementation TYEZPrepareViewController

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
    self.topBarView.leftItem = self.leftCancelItem;
    self.centerTitleItem.title = NSLocalizedString(@"home_add_device", @"");
    self.topBarView.centerItem = self.centerTitleItem;
    self.rightTitleItem.title = NSLocalizedString(@"ap_mode", @"");
    self.topBarView.rightItem = self.rightTitleItem;
    [self.view addSubview:self.topBarView];
}

- (void)initEZPrepareView {
    _prepareView = [[TYEZPrepareView alloc] initWithFrame:CGRectMake(0, APP_TOP_BAR_HEIGHT, APP_SCREEN_WIDTH, APP_VISIBLE_HEIGHT) mode:TYActivatorModeEZ];
    _prepareView.delegate = self;
    [self.view addSubview:_prepareView];
}

- (void)CancelButtonTap {
    [super CancelButtonTap];
}

- (void)rightBtnAction {
    [ViewControllerUtils gotoAPPrepareViewController:self isAPReset:NO ssid:nil password:nil];
}

#pragma mark - TYEZPrepareViewDelegate

- (void)helpAction:(TYEZPrepareView *)prepareView {
    [ViewControllerUtils gotoWebViewController:NSLocalizedString(@"ty_ez_help", @"") url:@"https://images.tuyacn.com/smart/connect-scheme-v3/help/common_network_quick.html" from:self];
}

- (void)nextAction:(TYEZPrepareView *)prepareView {
    [ViewControllerUtils gotoActivatorInputViewController:self mode:TYActivatorModeEZ];
}

@end
