//
//  TYLoginAndRegisterUtils.h
//  TuyaSmartHomeKit_Example
//
//  Created by Kennaki Kai on 2018/11/30.
//  Copyright © 2018 xuchengcheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TYDemoLoginAndRegisterUtils : NSObject

+ (BOOL)isValidateEmail:(NSString *)email;
+ (NSArray *)getDefaultPhoneCodeList;
+ (NSString *)getDefaultCountryCode;
@end

NS_ASSUME_NONNULL_END
