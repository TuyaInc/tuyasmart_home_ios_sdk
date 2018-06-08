//
//  TabBarViewController.h
//  TuyaSmart
//
//  Created by fengyu on 15/2/9.
//  Copyright (c) 2015年 Tuya. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DeviceViewController,UserViewController,TYDeviceListController;

@interface TabBarViewController : UITabBarController

- (id)initWithSelectedIndex:(NSInteger)index;

@end
