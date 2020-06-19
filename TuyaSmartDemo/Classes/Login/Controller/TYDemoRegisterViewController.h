//
//  TYRegisterViewController.h
//  TuyaSmartHomeKit_Example
//
//  Created by 盖剑秋 on 2018/11/6.
//  Copyright © 2018 xuchengcheng. All rights reserved.
//

#import "TPDemoBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface TYDemoRegisterViewController : TPDemoBaseViewController

@property (nonatomic, copy, nullable) void(^registerResultBlock)();

@end

NS_ASSUME_NONNULL_END
