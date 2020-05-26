//
//  TYAppDelegate.m
//  TuyaSmartHomeKit
//
//  Created by xuchengcheng on 06/07/2018.
//  Copyright (c) 2018 xuchengcheng. All rights reserved.
//

#import "TYAppDelegate.h"
#import "TYTabBarViewController.h"
#import "TPNavigationController.h"
#import "TYLoginViewController.h"
#import <UserNotifications/UserNotifications.h>

/*
 doc link
 
 en:https://tuyainc.github.io/tuyasmart_home_ios_sdk_doc/en/
 zh-hans:https://tuyainc.github.io/tuyasmart_home_ios_sdk_doc/zh-hans/
 */

@interface TYAppDelegate() <UNUserNotificationCenterDelegate, CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation TYAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
#if DEBUG
    // 开启日志打印
    [[TuyaSmartSDK sharedInstance] setDebugMode:YES];
#endif

    // 初始化 SDK
    [[TuyaSmartSDK sharedInstance] startWithAppKey:<#your_app_key#> secretKey:<#your_secret_key#>];

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // 已经登录过了就不需要再次登录
    if ([TuyaSmartUser sharedInstance].isLogin) {
        [self resetRootViewController:[TYTabBarViewController class]];
    } else {
        [self resetRootViewController:[TYLoginViewController class]];
    }
    
    // notification
    [application registerForRemoteNotifications];
    [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
    
    if (@available(iOS 10.0, *)) {
        //Codes below is essential in iOS10 or above.
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        UNAuthorizationOptions types10 = UNAuthorizationOptionBadge|UNAuthorizationOptionAlert|UNAuthorizationOptionSound;
        [center requestAuthorizationWithOptions:types10 completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (granted) {
                //Allow
            } else {
                //Deny
            }
        }];
    }
    
    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    [TuyaSmartSDK sharedInstance].deviceToken = deviceToken;
}

- (void)resetRootViewController:(Class)rootController {
    if ([TuyaSmartUser sharedInstance].isLogin) {
        // 监听 session 失效
        [self loginDoAction];
    }
    [tp_topMostViewController().navigationController popToRootViewControllerAnimated:NO];
    
    TPNavigationController *navigationController = [[TPNavigationController alloc] initWithRootViewController:[rootController new]];
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
    navigationController.navigationBarHidden = YES;
}

- (void)signOut {
    [[TuyaSmartUser sharedInstance] loginOut:nil failure:nil];
    [self resetRootViewController:[TYLoginViewController class]];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:TuyaSmartUserNotificationUserSessionInvalid
                                                  object:nil];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kDefaultCurrentHomeId];
}

- (void)loginDoAction {

    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:TuyaSmartUserNotificationUserSessionInvalid
                                                  object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(sessionInvalid)
                                                 name:TuyaSmartUserNotificationUserSessionInvalid
                                               object:nil];
    // 请求定位，创建家庭，地理位置，获取系统连接的 ssid 需要定位信息
    [self startLocation];
}

- (void)sessionInvalid {
    if ([[TuyaSmartUser sharedInstance] isLogin]) {
        [self signOut];
        
        [TPProgressUtils showError:NSLocalizedString(@"login_session_expired", nil)];
    }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:TuyaSmartUserNotificationUserSessionInvalid object:nil];
}

- (CLLocationManager *)locationManager {
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
        _locationManager.distanceFilter = 200.f;
        _locationManager.delegate = self;
    }
    return _locationManager;
}

- (void)startLocation {
    if ([CLLocationManager locationServicesEnabled]) {
        [self.locationManager startUpdatingLocation];
        [self.locationManager requestWhenInUseAuthorization];
    }
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(nonnull NSArray<CLLocation *> *)locations {
    CLLocation *loc = [locations firstObject];
    [[TuyaSmartSDK sharedInstance] updateLatitude:loc.coordinate.latitude longitude:loc.coordinate.longitude];
}


@end
