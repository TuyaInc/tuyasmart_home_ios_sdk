//
//  TYDemoDeviceListUtil.m
//  TuyaSmartDemo
//
//  Created by huangkai on 2020/10/21.
//

#import "TYDemoDeviceListUtil.h"

@implementation TYDemoDeviceListUtil

+ (NSBundle *)tysdkdemo_DeviceListBundle {
    static dispatch_once_t onceToken;
    static NSBundle *bundle;
    dispatch_once(&onceToken, ^{
        NSString *path = [[NSBundle bundleForClass:TYDemoDeviceListUtil.class] pathForResource:@"TuyaSmartDemoDeviceListBundle" ofType:@"bundle"];
        bundle = [NSBundle bundleWithPath:path];
    });
    return bundle;
}

@end


@implementation UIImage (TYSDKDemoDeviceListImage)

+ (UIImage *)tysdkdemo_DeviceListImageNamed:(NSString *)name {
    return [UIImage imageNamed:name inBundle:[TYDemoDeviceListUtil tysdkdemo_DeviceListBundle] compatibleWithTraitCollection:nil];
}

@end
