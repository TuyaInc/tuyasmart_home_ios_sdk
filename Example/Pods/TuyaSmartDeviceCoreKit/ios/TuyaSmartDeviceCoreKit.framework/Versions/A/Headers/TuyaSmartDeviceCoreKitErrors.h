//
//  TuyaSmartDeviceCoreKitErrors.h
//  Pods
//
//  Created by huangkai on 2020/7/14.
//

#ifndef TuyaSmartDeviceCoreKitErrors_h
#define TuyaSmartDeviceCoreKitErrors_h

/*
 *  TYDeviceCoreKitError
 *
 *  Discussion:
 *    Error returned as code to NSError from TuyaSmartDeviceKit.
 */
extern NSString *const kTYDeviceCoreKitErrorDomain;

typedef NS_ENUM(NSInteger, TYDeviceCoreKitError) {
    kTYDeviceCoreKitErrorDeviceNotSupport                      = 3000, // 设备不支持某个能力(设备维度上报的能力)
    kTYDeviceCoreKitErrorSocketSendDataFailed                  = 3001, // 局域网下发数据失败
    kTYDeviceCoreKitErrorEmptyDpsData                          = 3002, // dps 命令为空
    kTYDeviceCoreKitErrorGroupDeviceListEmpty                  = 3003, // 群组设备为空
    kTYDeviceCoreKitErrorGroupIdLengthError                    = 3004, // 群组 id 长度错误
    kTYDeviceCoreKitErrorIllegalDpData                         = 3005, // 非法的 dps，查阅产品 dp 定义
    kTYDeviceCoreKitErrorDeviceIdLengthError                   = 3006, // 设备 id 长度错误
    kTYDeviceCoreKitErrorDeviceLocalKeyNotFound                = 3007, // 缺少 local key
    
};

#endif /* TuyaSmartDeviceCoreKitErrors_h */
