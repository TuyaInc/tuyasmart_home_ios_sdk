//
//  TPCountryCodeUtils.m
//  TYLibraryExample
//
//  Created by 冯晓 on 16/2/26.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TPCountryCodeUtils.h"

@implementation TPCountryCodeUtils

+ (NSArray *)getDefaultPhoneCodeJson {
//    NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"TPViews" ofType:@"bundle"]];
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *plistPath = [bundle pathForResource:@"phoneCodeList" ofType:@"plist"];
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    return [dict objectForKey:@"phoneCodeList"];
}

+ (NSString *)getCountryCode {
    return [[NSLocale currentLocale] objectForKey:NSLocaleCountryCode];
}

@end
