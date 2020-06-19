//
//  TYDemoApplicationImpl.m
//  BlocksKit
//
//  Created by huangkai on 2020/6/3.
//

#import "TYDemoApplicationImpl.h"
#import <TuyaSmartBaseKit/TuyaSmartBaseKit.h>
#import <UserNotifications/UserNotifications.h>
#import <CoreLocation/CoreLocation.h>

#import "TYDemoTabBarViewController.h"
#import "TPDemoProgressUtils.h"

#import "TPDemoNavigationController.h"
#import "TPDemoUtils.h"

#import "TYDemoRouteManager.h"

@implementation TYDemoConfigModel

@end

@interface TYDemoApplicationImpl () <UNUserNotificationCenterDelegate, CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation TYDemoApplicationImpl

+ (instancetype)sharedInstance {
    static TYDemoApplicationImpl *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [TYDemoApplicationImpl new];
    });
    return instance;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(nullable NSDictionary *)launchOptions config:(TYDemoConfigModel *)config {
#if DEBUG
    // 开启日志打印
    [[TuyaSmartSDK sharedInstance] setDebugMode:YES];
#endif
    
    // 初始化 SDK
    [[TuyaSmartSDK sharedInstance] startWithAppKey:config.appKey secretKey:config.secretKey];
    
    //        self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // 已经登录过了就不需要再次登录
    if ([TuyaSmartUser sharedInstance].isLogin) {
        [self resetRootViewController:[TYDemoTabBarViewController class]];
    } else {
        [[TYDemoRouteManager sharedInstance] openRoute:kTYDemoPopLoginVC withParams:nil];
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

- (void)resetRootViewController:(Class)rootController {
    if ([TuyaSmartUser sharedInstance].isLogin) {
        // 监听 session 失效
        [self loginDoAction];
    }
    [tp_topMostViewController().navigationController popToRootViewControllerAnimated:NO];
    
    TPDemoNavigationController *navigationController = [[TPDemoNavigationController alloc] initWithRootViewController:[rootController new]];
    [[UIApplication sharedApplication] delegate].window.rootViewController = navigationController;
    [[[UIApplication sharedApplication] delegate].window makeKeyAndVisible];
    navigationController.navigationBarHidden = YES;
}


- (void)signOut {
    [[TuyaSmartUser sharedInstance] loginOut:nil failure:nil];
    
    [[TYDemoRouteManager sharedInstance] openRoute:kTYDemoPopLoginVC withParams:nil];
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
        
        [TPDemoProgressUtils showError:NSLocalizedString(@"login_session_expired", nil)];
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
