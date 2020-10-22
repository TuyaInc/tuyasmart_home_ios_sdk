//
//  TYDemoSmartSceneUtil.h
//  TuyaSmartDemo
//
//  Created by huangkai on 2020/10/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TYDemoSmartSceneUtil : NSObject

+ (NSBundle *)tysdkdemo_SmartSceneBundle;

@end

@interface UIImage (TYSDKDemoSmartSceneImage)

+ (UIImage *)tysdkdemo_SmartSceneImageNamed:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
