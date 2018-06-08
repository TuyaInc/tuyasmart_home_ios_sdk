//
//  AppendDeviceSettingViewController.m
//  TuyaSmart
//
//  Created by fengyu on 15/3/10.
//  Copyright (c) 2015年 Tuya. All rights reserved.
//

#import "AppendDeviceSettingViewController.h"

@interface AppendDeviceSettingViewController ()

@end

@implementation AppendDeviceSettingViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
}


- (NSString *)titleForCenterItem {
    return NSLocalizedString(@"ty_share_add_device_setting", @"");
}


- (void)initView {
    self.view.backgroundColor = MAIN_BACKGROUND_COLOR;
    
    UIView *appendDeviceView = [TPViewUtil viewWithFrame:CGRectMake(0, APP_TOP_BAR_HEIGHT + 26, APP_SCREEN_WIDTH, 60) color:[UIColor whiteColor]];
    [self.view addSubview:appendDeviceView];
    
    UILabel *title = [TPViewUtil labelWithFrame:CGRectMake(15, 0, APP_SCREEN_WIDTH, 60) fontSize:16 color:HEXCOLOR(0x303030)];
    title.text = NSLocalizedString(@"ty_share_add_newdevice", @"");
    [appendDeviceView addSubview:title];
    
    UISwitch *shareSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(APP_SCREEN_WIDTH - 66, 15, 51, 31)];
    [shareSwitch addTarget:self action:@selector(shareNewDevice:) forControlEvents:UIControlEventValueChanged];
    shareSwitch.on = self.isAutoShare;
    [appendDeviceView addSubview:shareSwitch];

    UILabel *desc = [TPViewUtil labelWithFrame:CGRectMake(15, appendDeviceView.bottom + 8, APP_SCREEN_WIDTH - 30, 100) fontSize:12 color:HEXCOLOR(0x9B9B9B)];
    desc.numberOfLines = 0;
    desc.text = NSLocalizedString(@"ty_share_add_shared", @"");
    [desc sizeToFit];
    [self.view addSubview:desc];
}

- (void)shareNewDevice:(UISwitch *)shareSwitch {
    [self.delegate didSettingSwitch:shareSwitch isOn:shareSwitch.isOn];
}

@end
