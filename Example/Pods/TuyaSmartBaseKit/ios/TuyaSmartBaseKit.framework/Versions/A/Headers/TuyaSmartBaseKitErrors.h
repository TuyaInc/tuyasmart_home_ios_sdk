//
//  TuyaSmartBaseKitErrors.h
//  TuyaSmartBaseKit
//
//  Created by huangkai on 2020/6/29.
//

#ifndef TuyaSmartBaseKitErrors_h
#define TuyaSmartBaseKitErrors_h

/*
 *  TYBaseKitError
 *
 *  Discussion:
 *    Error returned as code to NSError from TuyaSmartBaseKit.
 */

extern NSString *const kTYBaseKitErrorDomain;

typedef NS_ENUM(NSInteger, TYBaseKitError) {
    kTYBaseKitErrorAPIRequestError                       = 2000, // 请求错误
    kTYBaseKitErrorAPIResponseDataTypeIllegal            = 2001, // 返回数据类型非法
    kTYBaseKitErrorAPIResponseDataSignInconsistent       = 2002, // 返回的数据 sign 不一致
    kTYBaseKitErrorAPIResponseDataDecodeError            = 2003, // 返回数据 decode 错误
    kTYBaseKitErrorNetworkError                          = 2004, // 网络错误
    
};

#endif /* TuyaSmartBaseKitErrors_h */
