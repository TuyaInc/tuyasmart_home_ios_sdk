//
//  NSMutableDictionary+TPCategory.h
//  TYLibraryExample
//
//  Created by 冯晓 on 16/2/16.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (TPCategory)

- (void)tp_safeSetObject:(id)anObject forKey:(id<NSCopying>)aKey;


@end
