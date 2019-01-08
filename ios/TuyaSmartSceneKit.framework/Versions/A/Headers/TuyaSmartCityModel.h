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
 城市id
 */
@property (nonatomic, assign) long long cityId;

/**
 城市名称
 */
@property (nonatomic, strong) NSString *city;

/**
 城市名称,客户端由地图取到
 */
@property (nonatomic, copy) NSString *cityNameFromMap;

@property (nonatomic, assign) CLLocationDegrees tempLatitude;

@property (nonatomic, assign) CLLocationDegrees tempLongitude;

@end
