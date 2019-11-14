//
//  TYTimerDetailViewController.h
//  TuyaSmartHomeKit_Example
//
//  Created by Sakata Gintoki on 2019/11/12.
//  Copyright © 2019 xuchengcheng. All rights reserved.
//

#import "TPBaseViewController.h"
#import <TuyaSmartTimerKit/TuyaSmartTimerKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TYTimerDetailViewController : TPBaseViewController

- (instancetype)initWithDevId:( NSString * _Nonnull)devId category:(NSString * _Nonnull)category propertyDic:(NSDictionary * _Nonnull)propertyDic timerModel:(nullable TYTimerModel *)timerModel;
@end

NS_ASSUME_NONNULL_END
