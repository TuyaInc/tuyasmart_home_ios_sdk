//
//  TYSmartSceneViewController+ModuleConfig.m
//  BlocksKit
//
//  Created by huangkai on 2020/6/3.
//

#import "TYDemoSmartSceneViewController+ModuleConfig.h"

@implementation TYDemoSmartSceneViewController (ModuleConfig)
@dynamic barTitle;
@dynamic barImage;
@dynamic barSelectedImage;
@dynamic needNavigation;
@dynamic isMain;

TY_EXPORT_TABBAR(self)

- (NSString *)barTitle {
    return NSLocalizedString(@"ty_smart_scene", @"");
}

- (UIImage *)barImage {
    return [UIImage imageNamed:@"ty_scene_gray"];
}

- (UIImage *)barSelectedImage {
    return [UIImage imageNamed:@"ty_scene_active"];
}

- (BOOL)needNavigation {
    return YES;
}

- (BOOL)isMain {
    return NO;
}

@end
