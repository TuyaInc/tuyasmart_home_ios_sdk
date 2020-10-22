//
//  TYDemoDeviceListUtil.h
//  TuyaSmartDemo
//
//  Created by huangkai on 2020/10/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TYDemoDeviceListUtil : NSObject

+ (NSBundle *)tysdkdemo_DeviceListBundle;

@end

@interface UIImage (TYSDKDemoDeviceListImage)

+ (UIImage *)tysdkdemo_DeviceListImageNamed:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
