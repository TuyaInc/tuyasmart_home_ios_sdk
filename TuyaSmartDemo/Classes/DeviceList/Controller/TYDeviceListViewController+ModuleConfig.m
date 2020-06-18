//
//  TYDeviceListViewController+ModuleConfig.m
//  Pods
//
//  Created by huangkai on 2020/6/3.
//

#import "TYDeviceListViewController+ModuleConfig.h"
#import "TYSmartHomeManager.h"

@implementation TYDeviceListViewController (ModuleConfig)
@dynamic barTitle;
@dynamic barImage;
@dynamic barSelectedImage;
@dynamic needNavigation;

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

@end


@implementation TYDemoDeviceListModule

+ (void)load {
    [[TYDemoConfiguration sharedInstance] registService:@protocol(TYDemoDeviceListModuleProtocol) withImpl:[self new]];
}

- (long long)currentHomeId {
    return [TYSmartHomeManager sharedInstance].currentHomeModel.homeId;
}

@end
