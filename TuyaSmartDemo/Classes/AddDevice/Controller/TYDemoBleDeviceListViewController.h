//
//  TYBleDeviceListViewController.h
//  TuyaSmartHomeKit_Example
//
//  Created by milong on 2020/8/5.
//  Copyright © 2020 xuchengcheng. All rights reserved.
//

#import "TPDemoBaseViewController.h"
#import <TuyaSmartBLEMeshKit/TuyaSmartBLEMeshKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef  void (^TYSelectedDeviceHandlerBlock)(NSMutableArray<TuyaSmartSIGMeshDiscoverDeviceInfo *> *selectedDevices);

@interface TYDemoBleDeviceListViewController : TPDemoBaseViewController
@property (nonatomic, strong) NSArray<TuyaSmartSIGMeshDiscoverDeviceInfo *> *meshModelArray;
@property (nonatomic, copy) TYSelectedDeviceHandlerBlock selectedDeviceBlock;
@end

NS_ASSUME_NONNULL_END
