//
//  NSObject+TYJSON.h
//  TuyaSmartBaseKit
//
//  Created by 高森 on 2018/6/12.
//

#import <Foundation/Foundation.h>

@interface NSString (TYSDKJSON)
- (id)tysdk_objectFromJSONString;
- (id)tysdk_objectFromJSONString:(NSJSONReadingOptions)serializeOptions error:(NSError **)error;
@end

@interface NSArray (TYSDKJSON)
- (NSString *)tysdk_JSONString;
- (NSString *)tysdk_JSONStringWithOptions:(NSJSONWritingOptions)serializeOptions error:(NSError **)error;
@end

@interface NSDictionary (TYSDKJSON)
- (NSString *)tysdk_JSONString;
- (NSString *)tysdk_JSONStringWithOptions:(NSJSONWritingOptions)serializeOptions error:(NSError **)error;
@end
