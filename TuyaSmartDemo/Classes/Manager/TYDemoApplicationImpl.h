//
//  TYDemoApplicationImpl.h
//  BlocksKit
//
//  Created by huangkai on 2020/6/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TYDemoConfigModel : NSObject

@property (nonatomic, strong) NSString *appKey;
@property (nonatomic, strong) NSString *secretKey;

@property (nonatomic, strong) NSString *bundleId;

// {"key": vlaue}, will call sdk. setValue:(nullable id)value forKey:(NSString *)key
@property (nonatomic, strong) NSDictionary *extendDatas;

@end


@interface TYDemoApplicationImpl : NSObject

+ (instancetype)sharedInstance;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(nullable NSDictionary *)launchOptions config:(TYDemoConfigModel *)config;

- (void)resetRootViewController:(Class)rootController;
@end

NS_ASSUME_NONNULL_END
