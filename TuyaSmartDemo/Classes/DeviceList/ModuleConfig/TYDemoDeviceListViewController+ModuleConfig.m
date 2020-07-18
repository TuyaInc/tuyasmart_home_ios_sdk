//
//  TYDeviceListViewController+ModuleConfig.m
//  Pods
//
//  Created by huangkai on 2020/6/3.
//

#import "TYDemoDeviceListViewController+ModuleConfig.h"
#import "TYDemoSmartHomeManager.h"

@implementation TYDemoDeviceListViewController (ModuleConfig)
@dynamic barTitle;
@dynamic barImage;
@dynamic barSelectedImage;
@dynamic needNavigation;
@dynamic isMain;

TY_EXPORT_TABBAR(self)

- (NSString *)barTitle {
    return NSLocalizedString(@"Device", @"");
}

- (UIImage *)barImage {
    return [UIImage imageNamed:@"ty_mainbt_devicelist"];
}

- (UIImage *)barSelectedImage {
    return [UIImage imageNamed:@"ty_mainbt_devicelist_active"];
}

- (BOOL)needNavigation {
    return YES;
}

- (BOOL)isMain {
    return YES;
}

@end


@implementation TYDemoDeviceListModule

+ (void)load {
    [[TYDemoConfiguration sharedInstance] registService:@protocol(TYDemoDeviceListModuleProtocol) withImpl:[self new]];
}

- (long long)currentHomeId {
    return [TYDemoSmartHomeManager sharedInstance].currentHomeModel.homeId;
}

@end
