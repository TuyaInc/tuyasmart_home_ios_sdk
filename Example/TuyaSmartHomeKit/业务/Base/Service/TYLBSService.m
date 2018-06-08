//
//  TYLBSService.m
//  TuyaSmart
//
//  Created by fengyu on 15/7/3.
//  Copyright (c) 2015年 Tuya. All rights reserved.
//

#import "TYLBSService.h"
#import "TYLocationItem.h"

@interface TYLBSService()

@end

@implementation TYLBSService

TP_DEF_SINGLETON(TYLBSService)

- (void)updateLocation:(CLLocation *)location {
    if (location.coordinate.latitude && location.coordinate.longitude) {
        NSString *latitude = [NSString stringWithFormat:@"%f", location.coordinate.latitude];
        NSString *longitude = [NSString stringWithFormat:@"%f", location.coordinate.longitude];
        
        [[TuyaSmartSDK sharedInstance] setValue:latitude forKey:@"latitude"];
        [[TuyaSmartSDK sharedInstance] setValue:longitude forKey:@"longitude"];
        
        [TYLocationItem setLocationInfo:@{
                                          @"latitude":[NSString stringWithFormat:@"%f", location.coordinate.latitude ? : 0.f],
                                          @"longitude":[NSString stringWithFormat:@"%f", location.coordinate.longitude ? : 0.f],
                                          }];
    }

    [self updateCountryCode:location];
}

- (void)updateCountryCode:(CLLocation *)location {
    NSString *ISOcountryCode = [TYUserDefault getUserDefault:kDefaultISOcountryCode];
    if (location && ISOcountryCode.length == 0) {
        // 获取当前所在的城市名
        CLGeocoder *geocoder = [[CLGeocoder alloc] init];
        [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *array, NSError *error) {
             if (array.count > 0) {
                 CLPlacemark *placemark = [array objectAtIndex:0];
                 [TYUserDefault setUserDefault:placemark.ISOcountryCode forKey:kDefaultISOcountryCode];
             }
         }];
    }
}


@end
