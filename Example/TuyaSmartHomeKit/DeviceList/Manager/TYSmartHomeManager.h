//
//  TYSmartHomeManager.h
//  TuyaSmartHomeKit_Example
//
//  Created by 盖剑秋 on 2018/11/8.
//  Copyright © 2018 xuchengcheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TYSmartHomeManager : NSObject

@property (nonatomic, strong) TuyaSmartHome *currentHome;

/**
 Singleton constructor.

 @return An singleton instance of this class.
 */
+ (TYSmartHomeManager *)sharedInstance;

@end

NS_ASSUME_NONNULL_END
