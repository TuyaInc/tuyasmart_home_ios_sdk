//
//  TYSwitchPanelViewController.m
//  TuyaSmartKitDemo
//
//  Created by 冯晓 on 16/8/30.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TYSwitchPanelViewController.h"

@interface TYSwitchPanelViewController()

@property (nonatomic, strong) UIButton        *powerButton;
@property (nonatomic, assign) BOOL            isOn;

@end

@implementation TYSwitchPanelViewController

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
//    self.topBarView.textColor = [UIColor whiteColor];
//    self.topBarView.backgroundColor = [UIColor clearColor];
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
    [TPProgressUtils showMessag:NSLocalizedString(@"loading", @"") toView:self.view];
    
    NSDictionary *dps = @{@"1": _isOn ? @(NO): @(YES)};
    [self.device publishDps:dps success:^{
        [TPProgressUtils hideHUDForView:weakSelf_AT.view animated:NO];
        [weakSelf_AT reloadData];
    } failure:^(NSError *error) {
        [TPProgressUtils hideHUDForView:weakSelf_AT.view animated:NO];
        [TPProgressUtils showError:error.localizedDescription];
    }];
}


#pragma mark - TuyaSmartDeviceDelegate

- (void)device:(TuyaSmartDevice *)device dpsUpdate:(NSDictionary *)dps {
    NSLog(@"deviceDpsUpdate: %@", dps);
    [self reloadData];
}



@end
