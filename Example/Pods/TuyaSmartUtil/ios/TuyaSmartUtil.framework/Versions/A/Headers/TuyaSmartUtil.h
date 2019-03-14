//
//  TuyaSmartUtil.h
//  TuyaSmartBaseKit
//
//  Created by 高森 on 2018/6/20.
//

#ifndef TuyaSmartUtil_h
#define TuyaSmartUtil_h

#import <Foundation/Foundation.h>

#import "NSDate+TYOffset.h"
#import "NSError+TYDomain.h"
#import "NSNumber+TYRandom.h"
#import "NSObject+TYHex.h"
#import "NSObject+TYJSON.h"
#import "NSObject+TYURL.h"
#import "NSObject+TYEncrypt.h"
#import "NSObject+TYCategory.h"
#import "NSMutableArray+TYCategory.h"
#import "NSMutableDictionary+TYCategory.h"
#import "UIDevice+TYUUID.h"
#import "NSBundle+TYLanguage.h"

#import "TYUtil.h"

#define TY_SINGLETON \
+ (instancetype)sharedInstance;

#define TY_DEF_SINGLETON \
+ (instancetype)sharedInstance { \
    static id instance; \
    static dispatch_once_t once; \
    dispatch_once(&once, ^{ \
        instance = [[self alloc] init]; \
    }); \
    return instance; \
}

#define TY_APP_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define TY_APP_NAME    [[[NSBundle mainBundle] localizedInfoDictionary] objectForKey:@"CFBundleDisplayName"]

#define WEAKSELF_AT __weak __typeof(&*self)weakSelf_AT = self;

typedef void (^TYSuccessHandler)(void);
typedef void (^TYSuccessDict)(NSDictionary *dict);
typedef void (^TYSuccessString)(NSString *result);
typedef void (^TYSuccessList)(NSArray *list);
typedef void (^TYSuccessBOOL)(BOOL result);
typedef void (^TYSuccessID)(id result);
typedef void (^TYSuccessInt)(int result);
typedef void (^TYSuccessLongLong)(long long result);
typedef void (^TYSuccessData)(NSData *data);

typedef void (^TYFailureHandler)(void);
typedef void (^TYFailureError)(NSError *error);

#endif /* TuyaSmartUtil_h */
