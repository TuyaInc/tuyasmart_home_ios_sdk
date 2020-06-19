//
//  TYDemoConfiguration.h
//  Pods
//
//  Created by huangkai on 2020/6/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol TYDemoDeviceListModuleProtocol <NSObject>

- (long long)currentHomeId;

@end

@class TuyaSmartDeviceModel;
@class TuyaSmartGroupModel;
@protocol TYDemoPanelControlProtocol <NSObject>

- (void)gotoPanelControlDevice:(TuyaSmartDeviceModel * _Nullable )device group:(TuyaSmartGroupModel * _Nullable)group;

@end


@protocol TYTabBarVCProtocol <NSObject>

// bar 标题
@property (nonatomic, strong) NSString *barTitle;

// bar 未选中时图片
@property (nonatomic, strong) UIImage *barImage;

// bar 选中时图片
@property (nonatomic, strong) UIImage *barSelectedImage;

// 是否需要包一个 nav，yes 的话，会包一个 base 中的 TPNav
@property (nonatomic, assign) BOOL needNavigation;

@end

#define TY_EXTERN extern __attribute__((visibility("default")))

#define TY_EXPORT_TABBAR(class_name) \
TY_EXTERN void TYRegisterTabBar(Class); \
+ (void)load { TYRegisterTabBar(self); }

@interface TYDemoConfiguration : NSObject

+ (instancetype)sharedInstance;

- (NSArray<__kindof UIViewController *> *)tabBars;


- (BOOL)registService:(Protocol *)protocol withImpl:(id)impl;
- (void)unregistServiceOfProtocol:(Protocol *)protocol;
- (nullable id)serviceOfProtocol:(Protocol *)protocol;

@end

NS_ASSUME_NONNULL_END
