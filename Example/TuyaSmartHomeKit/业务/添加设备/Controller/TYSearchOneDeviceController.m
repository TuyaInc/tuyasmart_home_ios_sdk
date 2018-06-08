//
//  TYSearchOneDeviceController.m
//  TuyaSmart
//
//  Created by 高森 on 16/1/27.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TYSearchOneDeviceController.h"
#import "TYSearchOneDeviceLayout.h"

#define Timeout 100

@interface TYSearchOneDeviceController () <TuyaSmartActivatorDelegate>

@property (nonatomic, strong) TYSearchOneDeviceLayout     *layout;

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSDate  *fireDate;


@end

@implementation TYSearchOneDeviceController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view = self.layout;
    
    _fireDate = [NSDate date];
    _timer = [NSTimer scheduledTimerWithTimeInterval:1/60.0 target:self selector:@selector(timerCallBack) userInfo:nil repeats:YES];
    
    [TuyaSmartActivator sharedInstance].delegate = self;
    [[TuyaSmartActivator sharedInstance] startConfigWiFi:_mode ssid:_ssid password:_password token:_token timeout:Timeout];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [_timer invalidate];
    
    [TuyaSmartActivator sharedInstance].delegate = nil;
    [[TuyaSmartActivator sharedInstance] stopConfigWiFi];
}

/// 只用于刷新进度条
- (void)timerCallBack {
    CGFloat progress = MIN(fabs([_fireDate timeIntervalSinceNow] / Timeout), 1.0);
    [self.layout setProgress:progress];
    if (progress >= 1) {
        [_timer invalidate];
    }
}

- (TYSearchOneDeviceLayout *)layout {
    if (!_layout) {
        _layout = [[TYSearchOneDeviceLayout alloc] initWithFrame:self.view.bounds];
    }
    return _layout;
}

#pragma mark - TuyaSmartActivatorDelegate

- (void)activator:(TuyaSmartActivator *)activator didReceiveDevice:(TuyaSmartDeviceModel *)deviceModel error:(NSError *)error {
    
    
    if (!error && deviceModel) {
        [_timer invalidate];
        [self.layout setProgress:1];
        
        [NSObject bk_performBlock:^{
            [ViewControllerUtils gotoActivatorSuccessViewController:self device:deviceModel];
        } afterDelay:2.0];
        
    }
    
    if (error) {
        
        [_timer invalidate];
        if (_mode == TYActivatorModeEZ) {
            [ViewControllerUtils gotoAPPrepareViewController:self isAPReset:YES ssid:_ssid password:_password];
        } else {
            [ViewControllerUtils gotoActivatorErrorViewController:self];
        }
    }
}

@end
