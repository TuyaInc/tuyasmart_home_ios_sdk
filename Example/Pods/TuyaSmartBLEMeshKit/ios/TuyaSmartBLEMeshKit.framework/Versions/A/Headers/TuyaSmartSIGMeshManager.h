//
//  TuyaSmartSIGMeshManager.h
//  TuyaSmartBLEMeshKit
//
//  Created by 黄凯 on 2019/3/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, TuyaSmartSIGScanType) {
    ScanForUnprovision, // 扫描未配网设备
    //    ScanForProvision,
    ScanForProxyed, // 扫描已经配网的设备
};

@class TuyaSmartSIGMeshManager;
@class TuyaSmartSIGMeshDiscoverDeviceInfo;

@protocol TuyaSmartSIGMeshManagerDelegate <NSObject>

@optional;

/**
 激活子设备成功回调
 
 @param manager mesh manager
 @param device 设备
 @param devId 设备 Id
 @param error 激活中的错误，若发生错误，`name` 以及 `deviceId` 为空
 */
- (void)sigMeshManager:(TuyaSmartSIGMeshManager *)manager didActiveSubDevice:(TuyaSmartSIGMeshDiscoverDeviceInfo *)device devId:(NSString *)devId error:(NSError *)error;

/**
 激活设备失败回调
 
 @param manager mesh manager
 @param device 设备
 @param error 激活中的错误
 */
- (void)sigMeshManager:(TuyaSmartSIGMeshManager *)manager didFailToActiveDevice:(TuyaSmartSIGMeshDiscoverDeviceInfo *)device error:(NSError *)error;

/**
 激活完成回调
 */
- (void)didFinishToActiveDevList;

/**
 断开设备回调
 */
- (void)notifyCentralManagerDidDisconnectPeripheral;

/**
 扫描到待配网的设备
 
 @param manager mesh manager
 @param device 待配网设备信息
 */
- (void)sigMeshManager:(TuyaSmartSIGMeshManager *)manager didScanedDevice:(TuyaSmartSIGMeshDiscoverDeviceInfo *)device;


/**
 群组操作完成
 
 @param manager manager
 @param groupAddress 群组 mesh 地址， 16 进制
 @param nodeId 设备 mesh 节点地址，16 进制
 @param error 错误
 */
- (void)sigMeshManager:(TuyaSmartSIGMeshManager *)manager didHandleGroupWithGroupAddress:(NSString *)groupAddress deviceNodeId:(NSString *)nodeId error:(NSError *)error;

/**
 登录成功通知，升级所需
 */
- (void)notifySIGLoginSuccess;

- (void)sigMeshManager:(TuyaSmartSIGMeshManager *)manager queryDeviceModel:(TuyaSmartDeviceModel *)deviceModel groupAddress:(uint32_t)groupAddress;

@end

@interface TuyaSmartSIGMeshManager : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic, assign, readonly) BOOL isLogin;

@property (nonatomic, strong) TuyaSmartBleMesh *sigMesh;

@property (nonatomic, weak) id<TuyaSmartSIGMeshManagerDelegate> delegate;

@property (nonatomic, copy) NSString *otaTargetNodeId;/// < 升级的设备的nodeId

@end

NS_ASSUME_NONNULL_END
