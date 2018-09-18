//
//  TuyaSmartKitConstants.h
//  TuyaSmart
//
//  Created by 冯晓 on 16/2/17.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#ifndef TuyaSmartKitConstants_h
#define TuyaSmartKitConstants_h

#import <Foundation/Foundation.h>

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

#endif /* TuyaSmartKitConstants_h */

