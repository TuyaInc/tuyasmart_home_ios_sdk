//
//  NSObject+TYHex.h
//  TuyaSmartBaseKit
//
//  Created by 高森 on 2018/6/14.
//

#import <Foundation/Foundation.h>

@interface NSString (TYSDKHex)

+ (instancetype)tysdk_stringFromHexString:(NSString *)hexString;

- (NSString *)tysdk_hexString;

@end

@interface NSData (TYSDKHex)

+ (instancetype)tysdk_dataFromHexString:(NSString *)hexString;

- (NSString *)tysdk_hexString;

@end
