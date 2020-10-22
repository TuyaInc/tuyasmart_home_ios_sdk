//
//  TYUserInfoViewController+ModuleConfig.m
//  BlocksKit
//
//  Created by huangkai on 2020/6/10.
//

#import "TYDemoUserInfoViewController+ModuleConfig.h"

@implementation TYDemoUserInfoViewController (ModuleConfig)
@dynamic barTitle;
@dynamic barImage;
@dynamic barSelectedImage;
@dynamic needNavigation;
@dynamic isMain;

TY_EXPORT_TABBAR(self)

- (NSString *)barTitle {
    return TYSDKDemoLocalizedString(@"personal_center", @"");
}

- (UIImage *)barImage {
    return [UIImage tysdkdemo_imageNamed:@"ty_mainbt_about"];
}

- (UIImage *)barSelectedImage {
    return [UIImage tysdkdemo_imageNamed:@"ty_mainbt_about_active"];
}

- (BOOL)needNavigation {
    return YES;
}

- (BOOL)isMain {
    return NO;
}

@end
