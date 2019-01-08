//
//  TYHandlerWrapper.h
//  TYBluetooth
//
//  Created by 黄凯 on 2018/5/21.
//

#import <Foundation/Foundation.h>
#import "TYEvent.h"

@interface TYHandlerWrapper <__covariant ValueType> : NSObject <TYDisposable>

@property (nonatomic, weak) TYEvent *event;

@property (nonatomic, copy) TYEventHandler handler;

- (instancetype)initWithEvent:(TYEvent *)event
                      handler:(TYEventHandler)handler;


- (void)invoke:(ValueType)value;

@end
