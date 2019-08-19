//
//  NSObject+TPCategory.h
//  TYLibraryExample
//
//  Created by 冯晓 on 16/2/16.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (TYSDKCategory)

- (NSInteger)tysdk_toInt;

- (NSUInteger)tysdk_toUInt;

- (NSString *)tysdk_toString;

- (float)tysdk_toFloat;

- (double)tysdk_toDouble;

- (BOOL)tysdk_toBool;

+ (BOOL)tysdk_swizzleInstanceMethod:(SEL)originalSel with:(SEL)newSel;

+ (BOOL)tysdk_swizzleClassMethod:(SEL)originalSel with:(SEL)newSel;

@end
