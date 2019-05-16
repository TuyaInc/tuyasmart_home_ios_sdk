//
//  TYDarwinNotificationCenter.h
//  TuyaSmartUtil
//
//  Created by 高森 on 2019/1/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TYDarwinNotificationCenter : NSObject

@property (class, readonly, strong) TYDarwinNotificationCenter *defaultCenter;

- (void)addObserver:(id)observer selector:(SEL)aSelector name:(nullable NSNotificationName)aName;

- (void)postNotificationName:(NSNotificationName)aName;

- (void)removeObserver:(id)observer;
- (void)removeObserver:(id)observer name:(nullable NSNotificationName)aName;

@end

NS_ASSUME_NONNULL_END
