//
//  TYUserDefault.h
//  TuyaSmart
//
//  Created by fengyu on 15/4/7.
//  Copyright (c) 2015年 Tuya. All rights reserved.
//

#import <Foundation/Foundation.h>


#define kDefaultUserLocationKey     @"kDefaultUserLocationKey"
#define kDefaultISOcountryCode      @"kDefaultISOcountryCode"
#define kDefaultSetting             @"kDefaultSetting"
#define kDefaultAESSsidDict         @"kDefaultAESSsidDict"
#define kDefaultEnvSelect           @"kDefaultEnvSelect"
#define kDefaultLangSelect          @"kDefaultLangSelect"
#define kDefaultRNUrl               @"kDefaultRNUrl"
#define kDefaultRNIP                @"kDefaultRNIP"
#define kDefaultRNSwitch            @"kDefaultRNSwitch"
#define kSettingSoundSwitch         @"kSettingSoundSwitch"
#define kSettingshakeSwitch         @"kSettingshakeSwitch"
#define kSettingArriveRemind        @"kSettingArriveRemind"
#define kSettingLeaveRemind         @"kSettingLeaveRemind"
#define kDefaultGesturePasswd       @"kDefaultGesturePasswd"
#define kDefaultEnableGesturePasswd @"kDefaultEnableGesturePasswd"
#define kDefaultPushId              @"kDefaultPushId"
#define kDefaultI18nTimestamp       @"kDefaultI18nTimestamp"
#define kDefaultProfileTips         @"kDefaultProfileTips"
#define kDefaultMessageTips         @"kDefaultMessageTips"
#define kDefaultMessageTimes        @"kDefaultMessageTimes"
#define kDefaultLogEnable           @"kDefaultLogEnable"
#define kDefaultSpeedGuide          @"kDefaultSpeedGuide"



@interface TYUserDefault : NSObject

+ (NSUserDefaults *)userDefault;

+ (void)setUserDefault:(id)object forKey:(NSString *)aKey;
+ (id)getUserDefault:(NSString *)aKey;
+ (void)removeUserDefault:(NSString *)aKey;

+ (id)getPreUserDefault:(NSString *)key;
+ (void)setPreUserDefault:(id)object forKey:(NSString *)key;
+ (void)removePreUserDefault:(NSString *)aKey;

@end
