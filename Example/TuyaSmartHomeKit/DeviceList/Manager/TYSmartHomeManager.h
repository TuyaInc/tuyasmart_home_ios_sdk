//
//  TYSmartHomeManager.h
//  TuyaSmartHomeKit_Example
//
//  Created by 盖剑秋 on 2018/11/8.
//  Copyright © 2018 xuchengcheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TYSmartHomeManager : NSObject

@property (nonatomic, strong) TuyaSmartHome *currentHome;

+ (TYSmartHomeManager *)sharedInstance;

@end
