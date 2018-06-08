//
//  NSObject+TPCategory.h
//  TYLibraryExample
//
//  Created by 冯晓 on 16/2/16.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface NSObject (TPCategory)


- (NSInteger)tp_toInt;

- (NSUInteger)tp_toUInt;

- (NSString *)tp_toString;

- (CGFloat)tp_toFloat;

- (double)tp_toDouble;

- (BOOL)tp_toBool;

- (NSArray *)tp_toArray;

- (NSDictionary *)tp_toDictionary;

- (NSString *)tp_JSONString;



@end
