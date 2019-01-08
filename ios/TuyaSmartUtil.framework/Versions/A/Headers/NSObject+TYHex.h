//
//  NSObject+TYHex.h
//  TuyaSmartBaseKit
//
//  Created by 高森 on 2018/6/14.
//

#import <Foundation/Foundation.h>

@interface NSString (TYHex)

+ (instancetype)ty_stringFromHexString:(NSString *)hexString;

- (NSString *)ty_hexString;

@end

@interface NSData (TYHex)

+ (instancetype)ty_dataFromHexString:(NSString *)hexString;

- (NSString *)ty_hexString;

@end
