//
//  TuyaSmartUtil.h
//  TuyaSmartBaseKit
//
//  Created by 高森 on 2018/6/20.
//

#ifndef TuyaSmartUtil_h
#define TuyaSmartUtil_h

#import <Foundation/Foundation.h>

#import "NSDate+TYSDKOffset.h"
#import "NSError+TYSDKDomain.h"
#import "NSNumber+TYSDKRandom.h"
#import "NSObject+TYSDKHex.h"
#import "NSObject+TYSDKJSON.h"
#import "NSObject+TYSDKURL.h"
#import "NSObject+TYSDKEncrypt.h"
#import "NSObject+TYSDKCategory.h"
#import "NSBundle+TYSDKLanguage.h"
#import "NSMutableDictionary+TYSDKCategory.h"

#import "TYSDKUtil.h"
#import "TYSDKDevice.h"
#import "TYSDKUserDefault.h"
#import "TYSDKSafeMutableArray.h"
#import "TYSDKSafeMutableDictionary.h"
#import "TYSDKNotification.h"
#import "TYSDKLogUtils.h"
#import "TYSDKFile.h"

#define TYSDK_SINGLETON \
+ (instancetype)sharedInstance;

#define TYSDK_DEF_SINGLETON \
+ (instancetype)sharedInstance { \
    static id instance; \
    static dispatch_once_t once; \
    dispatch_once(&once, ^{ \
        instance = [[self alloc] init]; \
    }); \
    return instance; \
}

#define WEAKSELF_TYSDK __weak __typeof(&*self)weakSelf_TYSDK = self;

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
