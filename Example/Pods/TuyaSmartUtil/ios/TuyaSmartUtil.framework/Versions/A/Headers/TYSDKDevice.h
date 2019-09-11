//
//  TYDevice.h
//  TuyaSmartBaseKit
//
//  Created by 高森 on 2018/6/11.
//

#import <Foundation/Foundation.h>

@interface TYSDKDevice : NSObject

+ (NSString *)tysdk_UUID __deprecated_msg("Use +[TuyaSmartSDK SharedInstance].uuid instead.");

+ (NSString *)tysdk_generateUUID;

+ (NSString *)tysdk_deviceNameString;

+ (NSString *)tysdk_model;

+ (NSString *)tysdk_systemName;

+ (NSString *)tysdk_systemVersion;

@end
