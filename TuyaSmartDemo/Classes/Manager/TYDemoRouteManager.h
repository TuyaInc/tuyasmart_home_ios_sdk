//
//  TYDemoRouteManager.h
//  BlocksKit
//
//  Created by huangkai on 2020/6/2.
//

#import <Foundation/Foundation.h>

// 跳转到 login vc
static NSString * _Nonnull const kTYDemoPopLoginVC = @"kTYDemoPopLoginVC";




NS_ASSUME_NONNULL_BEGIN

@protocol TYDemoRouteManagerHandleProtocol <NSObject>

@optional
- (BOOL)handleRouteWithScheme:(NSString *)scheme host:(NSString *)host path:(NSString *)path params:(NSDictionary *)params;
+ (BOOL)handleRouteWithScheme:(NSString *)scheme host:(NSString *)host path:(NSString *)path params:(NSDictionary *)params;

@end

@interface TYDemoRouteManager : NSObject

+ (instancetype)sharedInstance;

/**
 scheme、path、query will be ignore
 */
- (void)registRoute:(NSString *)route forModule:(id)module;
- (void)unregistRoute:(NSString *)route;

- (nullable id)moduleOfRoute:(NSString *)route;


- (BOOL)canOpenRoute:(NSString *)route;

/**
 scheme、path、query will passthrough to the handle impl
 */
- (BOOL)openRoute:(NSString *)route withParams:(nullable NSDictionary *)params;


@end

NS_ASSUME_NONNULL_END
