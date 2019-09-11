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

NS_ASSUME_NONNULL_BEGIN

@interface TuyaSmartSIGMeshDiscoverDeviceInfo : NSObject

@property (nonatomic, strong) TYBLEPeripheral *peripheral;

@property (nonatomic, assign) SIGMeshNodeProvisionType provisionType;

@property (nonatomic, copy) NSString *mac;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *productId;

// for ota
@property (nonatomic, copy) NSString *nodeId;

// for extend
@property (nonatomic, strong) NSDictionary *extendInfo;


@end

NS_ASSUME_NONNULL_END
