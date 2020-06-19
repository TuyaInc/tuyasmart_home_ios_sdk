//
//  TYAddZigBeeGatewayViewController.m
//  TuyaSmartHomeKit_Example
//
//  Created by 盖剑秋 on 2018/11/19.
//  Copyright © 2018 xuchengcheng. All rights reserved.
//

#import "TYDemoAddZigBeeViewController.h"
#import "TYDemoConfiguration.h"
#import "TYDemoAddDeviceUtils.h"
#import <TuyaSmartActivatorKit/TuyaSmartActivatorKit.h>
#import "TPDemoUtils.h"

/**
 This page shows you how to add ZigBee gateway and ZigBee subdevice. You should add ZigBee gateway first.
 
 doc link
 
 en:https://tuyainc.github.io/tuyasmart_home_ios_sdk_doc/en/resource/Activator.html#network-configuration
 zh-hans:https://tuyainc.github.io/tuyasmart_home_ios_sdk_doc/zh-hans/resource/Activator.html#%E8%AE%BE%E5%A4%87%E9%85%8D%E7%BD%91
 */

@interface TYDemoAddZigBeeViewController ()<TuyaSmartActivatorDelegate>

@property (nonatomic, strong) UITextView *console;

@end

@implementation TYDemoAddZigBeeViewController {
    NSInteger timeLeft;
    NSInteger timeout;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    timeLeft = 100;
    timeout = timeLeft;
    [self initView];
}

#pragma mark - Gateway config

- (void)addZigBeeGateway {
    
    //If already in progress, do nothing.
    if (timeout < timeLeft) {
        [self appendConsoleLog:@"Activitor is still in progress, please wait..."];
        return;
    }
    //Get token from server with current homeId before commit activit progress.
    __block NSString *info = [NSString stringWithFormat:@"%@: start add ZigBee gateway",NSStringFromSelector(_cmd)];
    [self appendConsoleLog:info];
    info = [NSString stringWithFormat:@"%@: start get token",NSStringFromSelector(_cmd)];
    [self appendConsoleLog:info];
    WEAKSELF_AT
    id<TYDemoDeviceListModuleProtocol> impl = [[TYDemoConfiguration sharedInstance] serviceOfProtocol:@protocol(TYDemoDeviceListModuleProtocol)];
    long long homeId = [impl currentHomeId];
    [[TuyaSmartActivator sharedInstance] getTokenWithHomeId:homeId success:^(NSString *token) {
        
        info = [NSString stringWithFormat:@"%@: token fetched, token is %@",NSStringFromSelector(_cmd),token];
        [weakSelf_AT appendConsoleLog:info];
        
        [weakSelf_AT commitActionWithToken:token];
    } failure:^(NSError *error) {
        
        info = [NSString stringWithFormat:@"%@: token fetch failed, error message is %@",NSStringFromSelector(_cmd),error.localizedDescription];
        [weakSelf_AT appendConsoleLog:info];
    }];
}

- (void)commitActionWithToken:(NSString *)token {
    [TuyaSmartActivator sharedInstance].delegate = self;
    
    if (self.forZigBeeSubdevice) {
        // add subDevice View
        id<TYDemoDeviceListModuleProtocol> impl = [[TYDemoConfiguration sharedInstance] serviceOfProtocol:@protocol(TYDemoDeviceListModuleProtocol)];
        long long homeId = [impl currentHomeId];
        TuyaSmartHome *home = [TuyaSmartHome homeWithHomeId:homeId];
        NSArray *devices = home.deviceList;
        TuyaSmartDeviceModel *gatewayDevice = nil;
        for (TuyaSmartDeviceModel *deviceModel in devices) {
            if (deviceModel.deviceType == TuyaSmartDeviceModelTypeZigbeeGateway && deviceModel.isOnline) {
                gatewayDevice = deviceModel;
                break;
            }
        }
        
        if (gatewayDevice) {
            [[TuyaSmartActivator sharedInstance] activeSubDeviceWithGwId:gatewayDevice.devId timeout:timeLeft];
        } else {
            //You should add a ZigBee gateway before you add ZigBee subdevices.
            [self appendConsoleLog:@"To add a ZigBee subdevice, you need a ZigBee gateway first. There's no any of ZigBee gateway."];
            
            return;
        }
    } else {
        //ZigBee gateway...
        [[TuyaSmartActivator sharedInstance] startConfigWiFiWithToken:token timeout:timeout];
    }

    [self countDown];
}

- (void)stopConfigWiFi {
    
    if (self.forZigBeeSubdevice) {
        id<TYDemoDeviceListModuleProtocol> impl = [[TYDemoConfiguration sharedInstance] serviceOfProtocol:@protocol(TYDemoDeviceListModuleProtocol)];
        long long homeId = [impl currentHomeId];
        TuyaSmartHome *home = [TuyaSmartHome homeWithHomeId:homeId];
        NSArray *devices = home.deviceList;
        TuyaSmartDeviceModel *gatewayDevice = nil;
        for (TuyaSmartDeviceModel *deviceModel in devices) {
            if (deviceModel.deviceType == TuyaSmartDeviceModelTypeZigbeeGateway && deviceModel.isOnline) {
                gatewayDevice = deviceModel;
                break;
            }
        }
        if (gatewayDevice) {
            [[TuyaSmartActivator sharedInstance] stopActiveSubDeviceWithGwId:gatewayDevice.devId];
        }
    } else {
        [[TuyaSmartActivator sharedInstance] stopConfigWiFi];
    }
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(countDown) object:nil];
    timeout = timeLeft;
    [self hideProgressView];
    [self appendConsoleLog:@"Activator action canceled"];
}

#pragma mark - TuyaSmartActivatorDelegate

- (void)activator:(TuyaSmartActivator *)activator didReceiveDevice:(TuyaSmartDeviceModel *)deviceModel error:(NSError *)error {
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(countDown) object:nil];
    timeout = timeLeft;
    [self hideProgressView];
    
    NSString *info = [NSString stringWithFormat:@"%@: Finished!",NSStringFromSelector(_cmd)];
    [self appendConsoleLog:info];
    if (error) {
        info = [NSString stringWithFormat:@"%@: Error-%@!",NSStringFromSelector(_cmd),error.localizedDescription];
        [self appendConsoleLog:info];
    } else {
        info = [NSString stringWithFormat:@"%@: Success-You've added device %@ successfully!",NSStringFromSelector(_cmd),deviceModel.name];
        [self appendConsoleLog:info];
    }
}

#pragma mark - private

- (void)appendConsoleLog:(NSString *)logString {
    
    if (!logString) {
        logString = [NSString stringWithFormat:@"%@ : param error",NSStringFromSelector(_cmd)];
    }
    NSString *result = self.console.text?:@"";
    result = [[result stringByAppendingString:logString] stringByAppendingString:@"\n"];
    self.console.text = result;
    [self.console scrollRangeToVisible:NSMakeRange(result.length, 1)];
}

- (void)countDown {
    timeout --;
    
    if (timeout) {
        [self performSelector:@selector(countDown) withObject:nil afterDelay:1];
        [self appendConsoleLog:[NSString stringWithFormat:@"%@: %@ seconds left before timeout.",NSStringFromSelector(_cmd),@(timeout)]];
    } else {
        timeout = timeLeft;
    }
}

#pragma mark - UI

- (void)initView {
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.topBarView.leftItem = self.leftBackItem;
    self.centerTitleItem.title = self.forZigBeeSubdevice ? @"ZigBee subdevice" : @"ZigBee gateway";
    self.topBarView.centerItem = self.centerTitleItem;
    
    CGFloat currentY = self.topBarView.height;
    currentY += 10;
    
    //first line.
    CGFloat labelWidth = 75;
    CGFloat labelHeight = 44;
    
    //third line.
    currentY += 10;
    UIButton *EZModeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    EZModeButton.layer.cornerRadius = 5;
    EZModeButton.frame = CGRectMake(10, currentY, APP_SCREEN_WIDTH - 20, labelHeight);
    NSString *btnTitle = self.forZigBeeSubdevice?@"Add ZigBee subdevice":@"Add ZigBee gateway";
    [EZModeButton setTitle:btnTitle forState:UIControlStateNormal];
    EZModeButton.backgroundColor = UIColor.orangeColor;
    [EZModeButton addTarget:self action:@selector(addZigBeeGateway) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:EZModeButton];
    currentY += labelHeight;

    //forth line.
    currentY += 10;
    UILabel *titleLabel = [sharedAddDeviceUtils() keyLabel];
    titleLabel.text = @"console:";
    titleLabel.frame = CGRectMake(10, currentY, labelWidth, labelHeight);
    [self.view addSubview:titleLabel];
    currentY += labelHeight;
    
    //fifth line.
    self.console = [UITextView new];
    self.console.frame = CGRectMake(10, currentY, APP_SCREEN_WIDTH - 20, 250);
    self.console.layer.borderColor = UIColor.blackColor.CGColor;
    self.console.layer.borderWidth = 1;
    [self.view addSubview:self.console];
    self.console.editable = NO;
    self.console.layoutManager.allowsNonContiguousLayout = NO;
    self.console.backgroundColor = HEXCOLOR(0xededed);
    currentY += self.console.height;
    
    //final line
    currentY += 10;
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.layer.cornerRadius = 5;
    cancelButton.frame = CGRectMake(10, currentY, APP_SCREEN_WIDTH - 20, labelHeight);
    [cancelButton setTitle:@"stop active" forState:UIControlStateNormal];
    cancelButton.backgroundColor = UIColor.orangeColor;
    [cancelButton addTarget:self action:@selector(stopConfigWiFi) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelButton];
    currentY += labelHeight;
}


@end
