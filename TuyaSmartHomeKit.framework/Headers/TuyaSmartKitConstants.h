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

typedef void (^TYSuccessHandler)();
typedef void (^TYSuccessDict)(NSDictionary *dict);
typedef void (^TYSuccessString)(NSString *result);
typedef void (^TYSuccessList)(NSArray *list);
typedef void (^TYSuccessBOOL)(BOOL result);
typedef void (^TYSuccessID)(id result);
typedef void (^TYSuccessInt)(int result);
typedef void (^TYSuccessLongLong)(long long result);
typedef void (^TYSuccessData)(NSData *data);

typedef void (^TYFailureHandler)();
typedef void (^TYFailureError)(NSError *error);

/**
 *  
 * APP错误码枚举定义
 */
typedef NS_ENUM(NSInteger, TPErrorCode) {
    
    //接口请求网络错误 errorcode 不能变
    TUYA_NETWORK_ERROR = 1500,
    
    //一般的错误 1501
    TUYA_COMMON_ERROR,
    
    //面板解压失败 1502
    TUYA_PANEL_DECOMPRESS_ERROR,
    
    //面板大小校验失败 1503
    TUYA_PANEL_SIZE_ERROR,
    
    //本地时间校验失败 1504
    TUYA_TIME_VALIDATE_FAILED,
    
    //设备已离线 1505
    TUYA_GW_OFFLINE,
    
    //用户已注册 1506
    TUYA_USER_HAS_EXISTS,
    
    //非法的dp下发 1507
    TUYA_ILLEGAL_DP_DATA,
    
    //设备已经被重置 1508
    TUYA_DEVICE_HAS_RESET,
    
    //用户登录信息丢失 1509
    TUYA_USER_SESSION_LOSS,
    
    //用户登录信息失效 1510
    TUYA_USER_SESSION_INVALID,
    
    //二维码识别错误 1511
    TUYA_QR_PROTOCOL_NOT_RECOGNIZED,
    
    //超时错误 1512
    TUYA_TIMEOUT_ERROR,
    
    //无可用 node ID 1513
    TUYA_NO_AVAILABLE_NODE_ID,
    
    //手机号格式错误 1514
    TUYA_MOBILE_FORMAT_ERROR,
    
    //邮箱格式错误 1515
    TUYA_EMAIL_FORMAT_ERROR,
    
    //邮箱验证码错误 1516
    TUYA_EMAIL_CODE_ERROR,
    
    //用户不存在
    TUYA_USER_NOT_EXISTS
};

#endif /* TuyaSmartKitConstants_h */
