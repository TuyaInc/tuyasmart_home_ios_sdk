//
//  TYSwitchPanelViewController.m
//  TuyaSmartKitDemo
//
//  Created by 冯晓 on 16/8/30.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TYDemoSwitchPanelViewController.h"
#import "TPDemoProgressUtils.h"
#import "TPDemoUtils.h"

/*
 doc link
 
 en:https://tuyainc.github.io/tuyasmart_home_ios_sdk_doc/en/resource/Device.html#device-control
 zh-hans:https://tuyainc.github.io/tuyasmart_home_ios_sdk_doc/zh-hans/resource/Activator.html#%E8%AE%BE%E5%A4%87%E9%85%8D%E7%BD%91
 */

@interface TYDemoSwitchPanelViewController()

@property (nonatomic, strong) UIButton        *powerButton;
@property (nonatomic, assign) BOOL            isOn;

@end

@implementation TYDemoSwitchPanelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    [self reloadData];
}

- (void)initView {
    self.topBarView.centerItem = self.centerTitleItem;
    self.topBarView.leftItem = self.leftBackItem;
    self.rightTitleItem.title = NSLocalizedString(@"action_more", @"");
    self.topBarView.rightItem = self.rightTitleItem;
    self.topBarView.bottomLineHidden = YES;
    [self.view addSubview:self.topBarView];
    
    self.powerButton = [[UIButton alloc] initWithFrame:CGRectMake((APP_SCREEN_WIDTH - 280) / 2, (APP_SCREEN_HEIGHT - 280) / 2, 280, 280)];
    [self.powerButton addTarget:self action:@selector(powerButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.powerButton];
    
    self.view.backgroundColor = MAIN_BACKGROUND_COLOR;
}

- (void)reloadData {
    self.centerTitleItem.title = self.device.deviceModel.name;
    self.topBarView.centerItem = self.centerTitleItem;
    
    NSDictionary *dps = self.device.deviceModel.dps;
    _isOn = [[dps objectForKey:@"1"] boolValue];
    if (_isOn) {
        self.view.backgroundColor = HEXCOLOR(0x0D5FBA);
        [self.powerButton setImage:[UIImage imageNamed:@"power_on"] forState:UIControlStateNormal];
    } else {
        self.view.backgroundColor = HEXCOLOR(0x484848);
        [self.powerButton setImage:[UIImage imageNamed:@"power_off"] forState:UIControlStateNormal];
    }
}

- (void)powerButtonClicked {
    
    WEAKSELF_AT
    [TPDemoProgressUtils showMessag:NSLocalizedString(@"loading", @"") toView:self.view];
    
    NSDictionary *dps = @{@"1": _isOn ? @(NO): @(YES)};
    [self.device publishDps:dps success:^{
        [TPDemoProgressUtils hideHUDForView:weakSelf_AT.view animated:NO];
        [weakSelf_AT reloadData];
    } failure:^(NSError *error) {
        [TPDemoProgressUtils hideHUDForView:weakSelf_AT.view animated:NO];
        [TPDemoProgressUtils showError:error.localizedDescription];
    }];
}

#pragma mark - TuyaSmartDeviceDelegate

/// dp数据更新
- (void)device:(TuyaSmartDevice *)device dpsUpdate:(NSDictionary *)dps {
    [self reloadData];
}

/// 设备信息更新
- (void)deviceInfoUpdate:(TuyaSmartDevice *)device {
    
}

/// 设备被移除
- (void)deviceRemoved:(TuyaSmartDevice *)device {
    
}


@end
