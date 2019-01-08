//
//  NSError+TYDomain.h
//  TuyaSmartBaseKit
//
//  Created by 高森 on 2018/6/11.
//

#import <Foundation/Foundation.h>

#define TYErrorDomain @"com.tuya.www"

/**
 *
 * APP错误码枚举定义
 */
typedef enum {
    
    //接口请求网络错误 errorcode 不能变
    TUYA_NETWORK_ERROR = 1500,
    
    //一般的错误
    TUYA_COMMON_ERROR,
    
    //面板解压失败
    TUYA_PANEL_DECOMPRESS_ERROR,
    
    //面板大小校验失败
    TUYA_PANEL_SIZE_ERROR,
    
    //本地时间校验失败
    TUYA_TIME_VALIDATE_FAILED,
    
    //设备已离线
    TUYA_GW_OFFLINE,
    
    //用户已注册
    TUYA_USER_HAS_EXISTS,
    
    //非法的dp下发
    TUYA_ILLEGAL_DP_DATA,
    
    //设备已经被重置
    TUYA_DEVICE_HAS_RESET,
    
    //用户登录信息丢失
    TUYA_USER_SESSION_LOSS,
    
    //用户登录信息失效
    TUYA_USER_SESSION_INVALID,
    
    //二维码识别错误
    TUYA_QR_PROTOCOL_NOT_RECOGNIZED,
    
    //超时错误
    TUYA_TIMEOUT_ERROR,
    
    //无可用 node ID
    TUYA_NO_AVAILABLE_NODE_ID,
    
    //手机号格式错误
    TUYA_MOBILE_FORMAT_ERROR,
    
    //手机号码输入错误
    TUYA_MOBILE_ILLEGAL,
    
    //手机验证码错误
    TUYA_MOBILE_CODE_ERROR,
    
    //邮箱格式错误
    TUYA_EMAIL_FORMAT_ERROR,
    
    //邮箱输入错误
    TUYA_EMAIL_ILLEGAL,
    
    //邮箱验证码错误
    TUYA_EMAIL_CODE_ERROR,
    
    //用户不存在
    TUYA_USER_NOT_EXISTS
    
} TYErrorCode;

//TYErrorCode ty_getErrorCode(NSString *codeString);

@interface NSError (TYDomain)

+ (instancetype)ty_errorWithErrorCode:(TYErrorCode)errorCode errorMsg:(NSString *)errorMsg;

+ (NSError *)ty_errorWithCodeString:(NSString *)codeString errorMsg:(NSString *)errorMsg;

@end
