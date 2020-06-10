//
//  TYSmartHomeManager.h
//  TuyaSmartHomeKit_Example
//
//  Created by Tuya.Inc on 2018/11/8.
//  Copyright © 2018 xuchengcheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TYSmartHomeManager : NSObject

@property (nonatomic, strong) TuyaSmartHomeModel *currentHomeModel;

+ (TYSmartHomeManager *)sharedInstance;

@end
