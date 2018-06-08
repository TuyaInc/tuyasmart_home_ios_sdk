//
//  NSMutableArray+TPCategory.m
//  TYLibraryExample
//
//  Created by 冯晓 on 16/2/16.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "NSMutableArray+TPCategory.h"

@implementation NSMutableArray (TPCategory)


- (void)tp_safeAddObject:(id)anObject {
    if (!anObject) return;
    [self addObject:anObject];
}

- (void)tp_removeObjectAtRow:(int)row andColumn:(int)col {
    NSMutableArray *subArray = [self objectAtIndex:row];
    [subArray removeObjectAtIndex:col];
}

@end
