//
//  TYAPResetViewController.m
//  TuyaSmartPublic
//
//  Created by 高森 on 16/3/29.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TYAPResetViewController.h"
#import "TYAPResetView.h"

@interface TYAPResetViewController () <TYAPResetViewDelegate>

@property (nonatomic, strong) TYAPResetView *resetView;

@end

@implementation TYAPResetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [(TPNavigationController *)self.navigationController disablePopGesture];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [(TPNavigationController *)self.navigationController enablePopGesture];
}

- (void)initView {
    self.view.backgroundColor = MAIN_BACKGROUND_COLOR;
    [self initTopBarView];
    
    _resetView = [[TYAPResetView alloc] initWithFrame:CGRectMake(0, APP_TOP_BAR_HEIGHT, APP_CONTENT_WIDTH, APP_VISIBLE_HEIGHT)];
    _resetView.delegate = self;
    [self.view addSubview:_resetView];
}

- (void)initTopBarView {
    self.topBarView.leftItem = self.leftCancelItem;
    self.centerTitleItem.title = NSLocalizedString(@"ty_ez_init_title", @"");
    self.topBarView.centerItem = self.centerTitleItem;
    self.topBarView.rightItem = nil;
    [self.view addSubview:self.topBarView];
}

- (void)CancelButtonTap {
    [super CancelButtonTap];
}

#pragma mark - TYAPResetViewDelegate

- (void)helpAction:(TYAPResetView *)resetView {
    [ViewControllerUtils gotoWebViewController:NSLocalizedString(@"ty_ez_help", @"") url:@"http://smart.tuya.com/reset" from:self];
}

- (void)nextAction:(TYAPResetView *)resetView {
    [ViewControllerUtils gotoContectToAPViewController:self ssid:_ssid password:_password token:_token];
}

@end
