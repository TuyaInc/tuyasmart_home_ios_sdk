//
//  TYDeviceProperty.h
//  TuyaSmart
//
//  Created by fengyu on 15/7/27.
//  Copyright (c) 2015年 Tuya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TYDeviceProperty : NSObject

@property(nonatomic,strong) NSString *name;
@property(nonatomic,strong) NSString *dpId;
@property(nonatomic,assign) NSInteger seledted;
@property(nonatomic,assign) NSInteger repeat;   // 0正常 1一次 2每天

@property(nonatomic,strong) NSArray *rangeKeys;
@property(nonatomic,strong) NSArray *rangeValues;

+(TYDeviceProperty *)propertyWithDict:(NSDictionary *)dict;

-(id)defaultKey;
-(id)keyAtIndex:(NSInteger)index;
-(NSInteger)indexOfKey:(id)key;

-(NSString *)valueAtIndex:(NSInteger)index;
-(NSString *)valueForKey:(id)key;

@end
