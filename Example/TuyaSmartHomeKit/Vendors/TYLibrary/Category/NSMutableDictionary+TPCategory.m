//
//  NSMutableDictionary+TPCategory.m
//  TYLibraryExample
//
//  Created by 冯晓 on 16/2/16.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "NSMutableDictionary+TPCategory.h"

@implementation NSMutableDictionary (TPCategory)

- (void)tp_safeSetObject:(id)anObject forKey:(id<NSCopying>)aKey {
    if (!aKey || !anObject) return;
    [self setObject:anObject forKey:aKey];
}
@end
