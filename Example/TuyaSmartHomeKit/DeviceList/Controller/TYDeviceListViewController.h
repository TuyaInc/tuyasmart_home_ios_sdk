//
//  TYDeviceListViewController.h
//  TuyaSmartHomeKit_Example
//
//  Created by 盖剑秋 on 2018/11/8.
//  Copyright © 2018 xuchengcheng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class TYDeviceListViewController;

@protocol TYDeviceListViewControllerDelegate <NSObject>

- (void)controllerDidAddTestDevice:(TYDeviceListViewController *)controller;

- (void)controllerNeedReloadData:(TYDeviceListViewController *)controller;

@end

@interface TYDeviceListViewController : TPBaseViewController

@property(nonatomic, weak) id<TYDeviceListViewControllerDelegate> vcDelegate;

- (void)leftButtonTap;
- (void)beginReload;
- (void)reloadData;

@end

NS_ASSUME_NONNULL_END
