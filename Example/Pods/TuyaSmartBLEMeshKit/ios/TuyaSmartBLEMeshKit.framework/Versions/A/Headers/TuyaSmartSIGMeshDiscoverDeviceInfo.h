//
//  TuyaSmartSIGMeshDiscoverDeviceInfo.h
//  TuyaSmartSIGMesh
//
//  Created by 黄凯 on 2019/2/26.
//

#import <Foundation/Foundation.h>
#import <TYBluetooth/TYBLEAgent.h>

typedef NS_ENUM(NSUInteger, SIGMeshNodeProvisionType) {
    SIGMeshNodeUnknow,
    SIGMeshNodeUnprovision, // new device
    SIGMeshNodeProvisioned, // provisiond device
    SIGMeshNodeProxyed, // Already proxy, only need connect and control
};

typedef enum : NSUInteger {
    TYSIGMeshNodeActivatorTypeStandard = 0,// 标准配网
    TYSIGMeshNodeActivatorTypeQuick = 1 << 0,// 快速配网
} TYSIGMeshNodeActivatorType;

NS_ASSUME_NONNULL_BEGIN

#define kQuickVersion @"kQuickVersion"

@interface TuyaSmartSIGMeshDiscoverDeviceInfo : NSObject

@property (nonatomic, strong) TYBLEPeripheral *peripheral;

@property (nonatomic, assign) SIGMeshNodeProvisionType provisionType;

@property (nonatomic, assign) TYSIGMeshNodeActivatorType activatorType;/// < 配网类型

@property (nonatomic, copy) NSString *mac;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *productId;

// for ota
@property (nonatomic, copy) NSString *nodeId;
// quickSuccess: YES | NO
// for extend
@property (nonatomic, strong) NSDictionary *extendInfo;


@end

NS_ASSUME_NONNULL_END
