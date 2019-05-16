//
//  TYDevice.h
//  TuyaSmartBaseKit
//
//  Created by 高森 on 2018/6/11.
//

#import <Foundation/Foundation.h>

@interface TYDevice : NSObject

+ (NSString *)UUID;

+ (NSString *)generateUUID;

+ (NSString *)deviceNameString;

+ (NSString *)model;

+ (NSString *)systemName;

+ (NSString *)systemVersion;

@end
