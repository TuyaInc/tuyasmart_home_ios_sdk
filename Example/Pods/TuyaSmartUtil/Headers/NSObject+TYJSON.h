//
//  NSObject+TYJSON.h
//  TuyaSmartBaseKit
//
//  Created by 高森 on 2018/6/12.
//

#import <Foundation/Foundation.h>

@interface NSString (TYJSON)
- (id)ty_objectFromJSONString;
- (id)ty_objectFromJSONString:(NSJSONReadingOptions)serializeOptions error:(NSError **)error;
@end

@interface NSArray (TYJSON)
- (NSString *)ty_JSONString;
- (NSString *)ty_JSONStringWithOptions:(NSJSONWritingOptions)serializeOptions error:(NSError **)error;
@end

@interface NSDictionary (TYJSON)
- (NSString *)ty_JSONString;
- (NSString *)ty_JSONStringWithOptions:(NSJSONWritingOptions)serializeOptions error:(NSError **)error;
@end
