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
 * 城市的Id。
 * city's Id.
 */
@property (nonatomic, assign) long long cityId;

/**
 * 城市的名字。
 * city's name.
 */
@property (nonatomic, strong) NSString *city;

/**
 * 城市信息，从地图上获取，临时存储。
 * city Info, achieved from map.
 */
@property (nonatomic, copy) NSString *cityNameFromMap;

@property (nonatomic, assign) CLLocationDegrees tempLatitude;

@property (nonatomic, assign) CLLocationDegrees tempLongitude;

/**
 * 所属区，如西湖区。
 * Area or city, like a county.
 */
@property (nonatomic, copy) NSString *area;

/**
 * 中文拼音。
 * chinese pinyin.
 */
@property (nonatomic, copy) NSString *pinyin;

/**
 * 省级区域名称，如浙江省。
 * province or state name.
 */
@property (nonatomic, copy) NSString *province;

@end
