//
//  TYLocationItem.h
//  TuyaSmart
//
//  Created by fengyu on 15/6/29.
//  Copyright (c) 2015年 Tuya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TYLocationItem : NSObject

@property (nonatomic, strong) NSString *latitude;  //纬度
@property (nonatomic, strong) NSString *longitude; //经度
@property (nonatomic, strong) NSString *city;      //城市
@property (nonatomic, strong) NSString *zipCode;   //zipCode

+ (TYLocationItem *)modelWithDict:(NSDictionary *)dict;

+ (TYLocationItem *)getLocationInfo;
+ (void)setLocationInfo:(NSDictionary *)dict;
+ (void)clearLocationInfo;
+ (double)locationDistance:(TYLocationItem *)location1 location2:(TYLocationItem *)location2;

@end
