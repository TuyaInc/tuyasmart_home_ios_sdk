//
//  TYBLECentral.h
//  TuyaSmartPublic
//
//  Created by 冯晓 on 16/8/2.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface TYBLECentral : NSObject

@property(nonatomic, strong, readonly) CBCentral *central;

- (id)initWithCBCentral:(CBCentral*)central;

@end
