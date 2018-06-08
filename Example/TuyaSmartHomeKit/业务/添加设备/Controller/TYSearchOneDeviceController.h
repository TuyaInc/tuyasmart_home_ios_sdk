//
//  TYSearchOneDeviceController.h
//  TuyaSmart
//
//  Created by 高森 on 16/1/27.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TPBaseViewController.h"
//#import "TuyaSmartActivator.h"

@interface TYSearchOneDeviceController : TPBaseViewController

@property (nonatomic, strong) NSString          *ssid;
@property (nonatomic, strong) NSString          *password;
@property (nonatomic, strong) NSString          *token;
@property (nonatomic, assign) TYActivatorMode   mode;

@end
