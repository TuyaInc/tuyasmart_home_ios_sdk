//
//  NSObject+TPCategory.h
//  TYLibraryExample
//
//  Created by 冯晓 on 16/2/16.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (TYCategory)

- (NSInteger)ty_toInt;

- (NSUInteger)ty_toUInt;

- (NSString *)ty_toString;

- (float)ty_toFloat;

- (double)ty_toDouble;

- (BOOL)ty_toBool;

+ (BOOL)ty_swizzleInstanceMethod:(SEL)originalSel with:(SEL)newSel;

+ (BOOL)ty_swizzleClassMethod:(SEL)originalSel with:(SEL)newSel;

@end
