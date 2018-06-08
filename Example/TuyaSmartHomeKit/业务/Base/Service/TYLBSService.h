//
//  TYLBSService.h
//  TuyaSmart
//
//  Created by fengyu on 15/7/3.
//  Copyright (c) 2015年 Tuya. All rights reserved.
//
#import <CoreLocation/CoreLocation.h>

@interface TYLBSService : NSObject

TP_SINGLETON(TYLBSService)
- (void)updateLocation:(CLLocation *)location;

@end
