//
//  NSBundle+TYSDKLanguage.h
//  TuyaSmartBaseKit
//
//  Created by lan on 2018/9/4.
//  Copyright © 2018年 Tuya. All rights reserved.
//

#import <Foundation/Foundation.h>

#define TYSDKLocalizedString(key, comment) \
    [NSBundle tysdk_localizedStringForKey:(key) value:@"" table:nil]

@interface NSBundle (TYSDKLanguage)

+ (NSBundle *)tysdk_bundle;

+ (NSString *)tysdk_getAppleLanguages;

+ (NSString *)tysdk_localizedStringForKey:(NSString *)key value:(NSString *)value table:(NSString *)tableName;

@end
