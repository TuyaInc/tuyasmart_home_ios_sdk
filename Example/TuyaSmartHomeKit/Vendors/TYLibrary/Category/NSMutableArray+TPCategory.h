//
//  NSMutableArray+TPCategory.h
//  TYLibraryExample
//
//  Created by 冯晓 on 16/2/16.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (TPCategory)

- (void)tp_safeAddObject:(id)anObject;

- (void)tp_removeObjectAtRow:(int)row andColumn:(int)col;

@end
