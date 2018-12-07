//
//  TYRegisterViewController.h
//  TuyaSmartHomeKit_Example
//
//  Created by 盖剑秋 on 2018/11/6.
//  Copyright © 2018 xuchengcheng. All rights reserved.
//

#import "TPBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface TYRegisterViewController : TPBaseViewController

@property (nonatomic, copy, nullable) void(^registerResultBlock)(NSString *resultInfoStr);

@end

NS_ASSUME_NONNULL_END
