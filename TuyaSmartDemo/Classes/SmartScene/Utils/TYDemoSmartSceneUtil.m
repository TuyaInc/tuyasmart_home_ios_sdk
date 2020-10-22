//
//  TYDemoSmartSceneUtil.m
//  TuyaSmartDemo
//
//  Created by huangkai on 2020/10/21.
//

#import "TYDemoSmartSceneUtil.h"

@implementation TYDemoSmartSceneUtil

+ (NSBundle *)tysdkdemo_SmartSceneBundle {
    static dispatch_once_t onceToken;
    static NSBundle *bundle;
    dispatch_once(&onceToken, ^{
        NSString *path = [[NSBundle bundleForClass:TYDemoSmartSceneUtil.class] pathForResource:@"TuyaSmartDemoSceneBundle" ofType:@"bundle"];
        bundle = [NSBundle bundleWithPath:path];
    });
    return bundle;
}

@end


@implementation UIImage (TYSDKDemoSmartSceneImage)

+ (UIImage *)tysdkdemo_SmartSceneImageNamed:(NSString *)name {
    return [UIImage imageNamed:name inBundle:[TYDemoSmartSceneUtil tysdkdemo_SmartSceneBundle] compatibleWithTraitCollection:nil];
}

@end
