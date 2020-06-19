//
//  TYLoginViewController+Route.m
//  BlocksKit
//
//  Created by huangkai on 2020/6/3.
//

#import "TYDemoLoginViewController+Route.h"
#import "TYDemoApplicationImpl.h"

@implementation TYDemoLoginViewController (Route)

+ (void)load {
    [[TYDemoRouteManager sharedInstance] registRoute:kTYDemoPopLoginVC forModule:self];
}

+ (BOOL)handleRouteWithScheme:(NSString *)scheme host:(NSString *)host path:(NSString *)path params:(NSDictionary *)params {
    
    if ([host isEqualToString:kTYDemoPopLoginVC]) {
        [[TYDemoApplicationImpl sharedInstance] resetRootViewController:self];
        return YES;
    }
    
    return NO;
}


@end
