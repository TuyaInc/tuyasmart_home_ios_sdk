//
//  TYEZAddDeviceView.h
//  TuyaSmart
//
//  Created by 高森 on 16/1/27.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TYEZAddDeviceView : UIView

@property (nonatomic, strong) UIButton *nextButton;
@property (nonatomic, strong) UIView   *ssidView;

@property (nonatomic, strong) NSString *ssid;
@property (nonatomic, strong) NSString *password;

@end
