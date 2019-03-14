//
//  TuyaSmartCityModel.h
//  TuyaSmartKit
//
//  Created by xuyongbo on 2017/9/6.
//  Copyright © 2017年 Tuya. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

@interface TuyaSmartCityModel : NSObject


/**
 city Id
 */
@property (nonatomic, assign) long long cityId;

/**
 city name
 */
@property (nonatomic, strong) NSString *city;

/**
 city Info, achieved from map.
 */
@property (nonatomic, copy) NSString *cityNameFromMap;

@property (nonatomic, assign) CLLocationDegrees tempLatitude;

@property (nonatomic, assign) CLLocationDegrees tempLongitude;

/**
 area or city
 */
@property (nonatomic, copy) NSString *area;

/**
 chinese pinyin
 */
@property (nonatomic, copy) NSString *pinyin;

/**
 province
 */
@property (nonatomic, copy) NSString *province;

@end
