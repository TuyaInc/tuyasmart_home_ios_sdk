//
//  TYBLEServiceFactory.h
//  TuyaSmartPublic
//
//  Created by 冯晓 on 16/8/2.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@class  TYBLEService;

@interface TYBLEServiceFactory : NSObject

+ (TYBLEService *)serviceWithUUID:(NSString *)aUUID Characteristics:(NSArray *)aCharacteristics;

@end