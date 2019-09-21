//
//  TuyaSmartSDK+Log.h
//  TuyaSmartBaseKit
//
//  Created by 高森 on 2019/8/14.
//

#import "TuyaSmartSDK.h"

NS_ASSUME_NONNULL_BEGIN


void TYSDKLog(NSInteger level, NSString *module, const char *file, const char *function, NSUInteger line, NSString *format, ...);

#define TYLog(...) \
    TYSDKLog(1, @"TuyaSmartHomeKit", __FILE__, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#define TYSDKLogDebug(...) \
    TYSDKLog(0, @"TuyaSmartHomeKit", __FILE__, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#define TYSDKLogInfo(...) \
    TYSDKLog(1, @"TuyaSmartHomeKit", __FILE__, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#define TYSDKLogWarn(...) \
    TYSDKLog(2, @"TuyaSmartHomeKit", __FILE__, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#define TYSDKLogError(...) \
    TYSDKLog(3, @"TuyaSmartHomeKit", __FILE__, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)

@interface TuyaSmartSDK (Log)

/// Debug mode
/// 调试模式
@property (nonatomic, assign) BOOL debugMode;

@end

NS_ASSUME_NONNULL_END
