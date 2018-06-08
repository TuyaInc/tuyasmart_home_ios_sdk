//
//  TPBaseUtils.m
//  TuyaSmartPublic
//
//  Created by 冯晓 on 16/4/9.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TPBaseUtils.h"

@implementation TPBaseUtils


+ (NSString *)getPrivateUrl {
    
    if (PRIVACY_URL.length > 0) {
        return PRIVACY_URL;
    } else {
        return [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"private_%@",[TPUtils isChinese] ? @"cn" : @"en"] ofType:@"html"];
    }
}

+ (NSString *)getFAQUrl {
    
    if (FAQ_URL.length > 0) {
        return FAQ_URL;
    } else {
        return [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"faq_%@",[TPUtils isChinese] ? @"cn" : @"en"] ofType:@"html"];
    }
}

@end
