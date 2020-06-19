//
//  TYDeviceListViewController+ModuleConfig.h
//  Pods
//
//  Created by huangkai on 2020/6/3.
//

#import <Foundation/Foundation.h>
#import "TYDemoDeviceListViewController.h"
#import "TYDemoConfiguration.h"
#import "TYDemoRouteManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface TYDemoDeviceListViewController (ModuleConfig) <TYTabBarVCProtocol>

@end

@interface TYDemoDeviceListModule : NSObject <TYDemoDeviceListModuleProtocol>

@end

NS_ASSUME_NONNULL_END
