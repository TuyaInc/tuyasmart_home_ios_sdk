//
//  TYLocationItem.m
//  TuyaSmart
//
//  Created by fengyu on 15/6/29.
//  Copyright (c) 2015年 Tuya. All rights reserved.
//

#import "TYLocationItem.h"
#import <CoreLocation/CLLocation.h>

#define kDefaultUserLocationKey @"kDefaultUserLocationKey"

@implementation TYLocationItem

+ (TYLocationItem *)modelWithDict:(NSDictionary *)dict {
    TYLocationItem *location = [[TYLocationItem alloc] init];
    location.latitude   = [dict objectForKey:@"latitude"];
    location.longitude  = [dict objectForKey:@"longitude"];
    location.city       = [dict objectForKey:@"city"];
    location.zipCode    = [dict objectForKey:@"zipCode"];
    return location;
}

+(TYLocationItem *)getLocationInfo {
    NSDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:kDefaultUserLocationKey];
    
    return [TYLocationItem modelWithDict:dict];
}

+ (void)setLocationInfo:(NSDictionary *)dict {
    [[NSUserDefaults standardUserDefaults] setObject:dict forKey:kDefaultUserLocationKey];
}

+ (void)clearLocationInfo {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kDefaultUserLocationKey];
}

+ (double)locationDistance:(TYLocationItem *)location1 location2:(TYLocationItem *)location2 {
    CLLocation *orig = [[CLLocation alloc] initWithLatitude:[location1.latitude doubleValue] longitude:[location1.longitude doubleValue]];
    CLLocation *dist = [[CLLocation alloc] initWithLatitude:[location2.latitude doubleValue] longitude:[location2.longitude doubleValue]];
    CLLocationDistance meters = [orig distanceFromLocation:dist];
    return meters;
}

@end
