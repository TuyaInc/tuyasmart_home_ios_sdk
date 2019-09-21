//
//  TYBLECentralManager.h
//  TuyaSmartPublic
//
//  Created by 冯晓 on 16/8/2.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface TYBLECentralManager : NSObject <CBCentralManagerDelegate>

/**
 *  蓝牙是否打开
 */
@property (nonatomic, assign, readonly) BOOL isPoweredOn;

/**
 *  CBCentralManager对象
 */
@property (nonatomic, strong, readonly) CBCentralManager *cbManager;

- (void)tyble_performSelector:(SEL)aSelector withObject:(id)anArgument afterDelay:(NSTimeInterval)delay;

- (void)tyble_cancelPreviousPerformRequestsWithTarget:(id)aTarget selector:(SEL)aSelector object:(nullable id)anArgument;

@end
