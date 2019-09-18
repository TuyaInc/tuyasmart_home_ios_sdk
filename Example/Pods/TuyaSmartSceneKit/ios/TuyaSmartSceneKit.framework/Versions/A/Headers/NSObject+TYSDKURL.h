//
//  NSObject+TYURL.h
//  TuyaSmartBaseKit
//
//  Created by 高森 on 2018/6/12.
//

#import <Foundation/Foundation.h>

@interface NSString (TYSDKURL)

- (NSString *)tysdk_urlEncodeString;

- (NSString *)tysdk_urlDecodeString;

@end

@interface NSURL (TYSDKQuery)

- (NSDictionary *)tysdk_queryDict;

@end
