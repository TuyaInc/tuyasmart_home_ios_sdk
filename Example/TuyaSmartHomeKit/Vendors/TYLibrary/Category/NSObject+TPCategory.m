//
//  NSObject+TPCategory.m
//  TYLibraryExample
//
//  Created by 冯晓 on 16/2/16.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "NSObject+TPCategory.h"

@implementation NSObject (TPCategory)


- (NSInteger)tp_toInt {
    if ([self isKindOfClass:[NSNumber class]]) {
        return [(NSNumber *)self integerValue];
    }
    
    NSInteger result;
    @try {
        result = [[NSString stringWithFormat:@"%@", self] integerValue];
    }
    @catch (NSException *exception) {
        result = 0;
    }
    
    return result;
}

- (NSUInteger)tp_toUInt {
    if ([self isKindOfClass:[NSNumber class]]) {
        return [(NSNumber *)self unsignedIntegerValue];
    }
    
    NSUInteger result;
    @try {
        result = [[NSString stringWithFormat:@"%@", self] integerValue];
    }
    @catch (NSException *exception) {
        result = 0;
    }
    
    return result;
}

- (NSString *)tp_toString {
    if ([self isKindOfClass:[NSString class]]) {
        if ([(NSString *)self caseInsensitiveCompare:@"null"] == NSOrderedSame) {
            return @"";
        }
        else {
            return (NSString *)self;
        }
    }
    
    NSString *result;
    @try {
        if (self == nil || [self isKindOfClass:[NSNull class]]) {
            result = @"";
        }
        else {
            result = [NSString stringWithFormat:@"%@", self];
        }
    }
    @catch (NSException *exception) {
        result = @"";
    }
    
    return result;
}

- (CGFloat)tp_toFloat {
    if ([self isKindOfClass:[NSNumber class]]) {
        return [(NSNumber *)self floatValue];
    }
    
    CGFloat result;
    @try {
        result = [[NSString stringWithFormat:@"%@", self] floatValue];
    }
    @catch (NSException *exception) {
        result = 0.0f;
    }
    
    return result;
}

- (double)tp_toDouble {
    if ([self isKindOfClass:[NSNumber class]]) {
        return [(NSNumber *)self doubleValue];
    }
    
    double result;
    @try {
        result = [[NSString stringWithFormat:@"%@", self] doubleValue];
    }
    @catch (NSException *exception) {
        result = 0.0f;
    }
    
    return result;
}

- (BOOL)tp_toBool {
    if ([self isKindOfClass:[NSNumber class]]) {
        return [(NSNumber *)self boolValue];
    }
    
    if ([self isKindOfClass:[NSString class]]) {
        if ([(NSString *)self caseInsensitiveCompare:@"null"] == NSOrderedSame) {
            return NO;
        }
    }
    
    if ([self isKindOfClass:[NSNull class]]) {
        return NO;
    }
    
    return self ? YES : NO;
}

- (NSArray *)tp_toArray {
    return [self isKindOfClass:[NSArray class]] ? (NSArray *)self : nil;
}

- (NSDictionary *)tp_toDictionary {
    return [self isKindOfClass:[NSDictionary class]] ? (NSDictionary *)self : nil;
}

- (NSString *)tp_JSONString {
    NSString *JSONString;
    
    NSError *error;
    NSData *JSONData = [NSJSONSerialization dataWithJSONObject:self options:0 error:&error];
    if (error) {
//        TYLog(@"[NSObject JSONString] error: %@", [error localizedDescription]);
    }
    else {
        JSONString = [[NSString alloc] initWithBytes:JSONData.bytes length:JSONData.length encoding:NSUTF8StringEncoding];
    }
    
    return JSONString;
}


@end
