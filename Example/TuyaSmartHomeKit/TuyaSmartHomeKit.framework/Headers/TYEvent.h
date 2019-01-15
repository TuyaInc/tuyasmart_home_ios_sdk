//
//  TYEvent.h
//  Pods
//
//  Created by 黄凯 on 2018/4/14.
//

#import <Foundation/Foundation.h>

@protocol TYDisposable <NSObject>

- (void)dispose;

@end

@class HandlerWrapper;
@interface TYEvent <__covariant T> : NSObject <TYDisposable>

typedef void(^TYEventHandler)(T);
@property (nonatomic, strong) NSMutableArray<HandlerWrapper *> *handlers;

- (id<TYDisposable>)subscription:(TYEventHandler)handler;

- (void)raise:(T)data;

@end

@interface HandlerWrapper <__covariant T> : NSObject <TYDisposable>

@property (nonatomic, weak) TYEvent *event;

@property (nonatomic, copy) TYEventHandler handler;

- (instancetype)initWithEvent:(TYEvent *)event
                      handler:(TYEventHandler)handler;

- (void)invoke:(T)data;

@end
