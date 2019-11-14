//
//  TYDeviceProperty.m
//  TuyaSmart
//
//  Created by fengyu on 15/7/27.
//  Copyright (c) 2015年 Tuya. All rights reserved.
//

#import "TYDeviceProperty.h"

@interface TYDeviceProperty()


@end

@implementation TYDeviceProperty

+(TYDeviceProperty *)propertyWithDict:(NSDictionary *)dict {
    TYDeviceProperty *property = [[TYDeviceProperty alloc] init];
   
    
    property.name = [dict objectForKey:@"dpName"];
    property.dpId = [[dict objectForKey:@"dpId"] tysdk_toString];
    property.seledted = [[dict objectForKey:@"selected"] tysdk_toInt];
    property.rangeKeys = [dict objectForKey:@"rangeKeys"];
    property.rangeValues = [dict objectForKey:@"rangeValues"];
    if ([dict objectForKey:@"repeat"]) {
        property.repeat = [[dict objectForKey:@"repeat"] tysdk_toInt];
    } else {
        property.repeat = 0;
    }
    
    return property;
}

-(id)defaultKey {
    if (_seledted >= 0 && _seledted < _rangeKeys.count) {
        return [_rangeKeys objectAtIndex:_seledted];
    } else {
        return nil;
    }
}

-(id)keyAtIndex:(NSInteger)index {
    return [_rangeKeys objectAtIndex:index];
}

-(NSInteger)indexOfKey:(id)key {
    if ([_rangeKeys containsObject:key]) {
        return [_rangeKeys indexOfObject:key];
    } else {
        return -1;
    }
}

-(NSString *)valueAtIndex:(NSInteger)index {
    return [_rangeValues objectAtIndex:index];
}

-(NSString *)valueForKey:(id)key {
    if ([_rangeKeys containsObject:key]) {
        return [_rangeValues objectAtIndex:[_rangeKeys indexOfObject:key]];
    } else {
        return nil;
    }
}

@end
