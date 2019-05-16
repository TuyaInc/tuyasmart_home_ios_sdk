//
//  TYEvent.h
//  TYBluetooth
//
//  Created by 黄凯 on 2018/5/21.
//

#import <Foundation/Foundation.h>
#import "TYDisposable.h"

@class TYHandlerWrapper;
@interface TYEvent <__covariant ValueType> : NSObject <TYDisposable>

typedef void(^TYEventHandler)(ValueType);
@property (nonatomic, strong, readonly, nonnull) NSMutableArray<TYHandlerWrapper *> *handlers;

/**
 添加监听，当事件发出时，可以执行监听者对应的响应事件

 @param handler 事件发生时响应事件
 @return 事件本身
 */
- (TYEvent *)subscription:(TYEventHandler)handler;

/**
 抛出事件，需要向外部所有监听者发送事件时调用

 @param value 数据类型
 */
- (void)raise:(ValueType)value;

@end
