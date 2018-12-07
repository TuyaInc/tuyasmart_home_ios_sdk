//
//  TYSmartHomeManager.m
//  TuyaSmartHomeKit_Example
//
//  Created by 盖剑秋 on 2018/11/8.
//  Copyright © 2018 xuchengcheng. All rights reserved.
//

#import "TYSmartHomeManager.h"

@implementation TYSmartHomeManager

@synthesize currentHome = _currentHome;

/**
 Singleton constructor.
 
 @return An singleton instance of this class.
 */
+ (TYSmartHomeManager *)sharedInstance {

    static TYSmartHomeManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!sharedInstance) {
            sharedInstance = [TYSmartHomeManager new];
        }
    });
    return sharedInstance;
}

@end
