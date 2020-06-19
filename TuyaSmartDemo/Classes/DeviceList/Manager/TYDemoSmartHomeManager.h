//
//  TYSmartHomeManager.h
//  TuyaSmartHomeKit_Example
//
//  Created by 盖剑秋 on 2018/11/8.
//  Copyright © 2018 xuchengcheng. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <TuyaSmartDeviceKit/TuyaSmartDeviceKit.h>

@interface TYDemoSmartHomeManager : NSObject

@property (nonatomic, strong) TuyaSmartHomeModel *currentHomeModel;

+ (TYDemoSmartHomeManager *)sharedInstance;

@end
