//
//  TYAddDeviceMenuViewController+ModuleConfig.m
//  BlocksKit
//
//  Created by huangkai on 2020/6/3.
//

#import "TYAddDeviceMenuViewController+ModuleConfig.h"

@implementation TYAddDeviceMenuViewController (ModuleConfig)
@dynamic barTitle;
@dynamic barImage;
@dynamic barSelectedImage;
@dynamic needNavigation;

TY_EXPORT_TABBAR(self)

- (NSString *)barTitle {
    return NSLocalizedString(@"Activate", @"");
}

- (UIImage *)barImage {
    return [UIImage imageNamed:@"ty_mainbt_add"];
}

- (UIImage *)barSelectedImage {
    return [UIImage imageNamed:@"ty_mainbt_add_active"];
}

- (BOOL)needNavigation {
    return YES;
}

@end
