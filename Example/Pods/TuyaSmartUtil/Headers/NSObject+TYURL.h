//
//  NSObject+TYURL.h
//  TuyaSmartBaseKit
//
//  Created by 高森 on 2018/6/12.
//

#import <Foundation/Foundation.h>

@interface NSString (TYURL)

- (NSString *)ty_urlEncodeString;

- (NSString *)ty_urlDecodeString;

@end

@interface NSURL (TYQuery)

- (NSDictionary *)ty_queryDict;

@end
