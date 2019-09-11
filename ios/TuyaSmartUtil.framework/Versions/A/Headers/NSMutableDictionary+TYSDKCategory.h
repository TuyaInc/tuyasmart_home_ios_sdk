//
//  NSMutableDictionary+TYSDKCategory.h
//  Bolts
//
//  Created by XuChengcheng on 2019/5/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableDictionary (TYSDKCategory)

- (void)tysdk_safeSetObject:(id)anObject forKey:(id<NSCopying>)aKey;

@end

NS_ASSUME_NONNULL_END
