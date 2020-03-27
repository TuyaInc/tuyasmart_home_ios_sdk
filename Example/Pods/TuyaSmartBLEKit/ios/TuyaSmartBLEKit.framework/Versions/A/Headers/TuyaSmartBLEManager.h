//
//  TuyaSmartBLEManager.h
//  TuyaSmartBLEKit
//
//  Created by 黄凯 on 2018/12/22.
//

#import <Foundation/Foundation.h>
#import <TuyaSmartDeviceKit/TuyaSmartDeviceKit.h>
#import "TYBLEAdvModel.h"

typedef enum : NSUInteger {
    TuyaSmartBLEOTATypeFirmware = 0, //蓝牙固件 OTA
    TuyaSmartBLEOTATypeMCU, //MCU OTA
} TuyaSmartBLEOTAType;

NS_ASSUME_NONNULL_BEGIN

@protocol TuyaSmartBLEManagerDelegate <NSObject>

/**
 蓝牙状态变化通知
 
 @param isPoweredOn 蓝牙状态，开启或关闭
 */
- (void)bluetoothDidUpdateState:(BOOL)isPoweredOn;


/**
 扫描到未激活的设备
 
 @param uuid 未激活设备 uuid
 @param productKey 未激活设备产品 key
 */
- (void)didDiscoveryDeviceWithUUID:(NSString *)uuid productKey:(NSString *)productKey __deprecated_msg("This method is deprecated, Use -[TuyaSmartBLEManager -  didDiscoveryDeviceWithDeviceInfo:] instead");

/**
 扫描到未激活的设备
 
 @param deviceInfo 未激活设备信息 Model
 */
- (void)didDiscoveryDeviceWithDeviceInfo:(TYBLEAdvModel *)deviceInfo;

@end

@interface TuyaSmartBLEManager : NSObject

+ (instancetype)sharedInstance;

/**
 蓝牙是否打开可用
 */
@property (nonatomic, assign, readonly) BOOL isPoweredOn;

/**
 代理，用于扫描和蓝牙状态变更通知
 */
@property (nonatomic, weak) id<TuyaSmartBLEManagerDelegate> delegate;

// ----------------------------------------------------------------------

/**
 开始扫描
 
 如果扫描到未激活设备，结果会通过 `TuyaSmartBLEManagerDelegate` 中的 `- (void)didDiscoveryDeviceWithDeviceInfo:(TYBLEAdvModel *)deviceInfo` 返回;
 
 如果扫描到激活设备，会自动进行连接入网，不会返回扫描结果
 
 @param clearCache 是否清理已扫描到的设备
 */
- (void)startListening:(BOOL)clearCache;


/**
 停止扫描
 
 @param clearCache 是否清理已扫描到的设备
 */
- (void)stopListening:(BOOL)clearCache;

/**
 连接设备
 
 @param uuid 设备 uuid
 @param productKey 产品 key
 @param success 成功回调
 @param failure 失败回调
 */
- (void)connectBLEWithUUID:(NSString *)uuid
                productKey:(NSString *)productKey
                   success:(TYSuccessHandler)success
                   failure:(TYFailureHandler)failure;


/**
 查询设备名称
 
 @param uuid 设备 uuid
 @param productKey 产品 key
 @param success 成功回调
 @param failure 失败回调
 */
- (void)queryNameWithUUID:(NSString *)uuid
               productKey:(NSString *)productKey
                  success:(void(^)(NSString *name))success
                  failure:(TYFailureError)failure;


/**
 激活设备，设备 uuid 来源于搜索发现的设备
 激活过程会将设备信息注册到云端
 
 @param uuid 设备 uuid
 @param homeId 家庭 id
 @param productKey 产品 key
 @param success 成功回调
 @param failure 失败回调
 */
- (void)activeBLEWithUUID:(NSString *)uuid
                   homeId:(long long)homeId
               productKey:(NSString *)productKey
                  success:(void(^)(TuyaSmartDeviceModel *deviceModel))success
                  failure:(TYFailureHandler)failure __deprecated_msg("This method is deprecated, Use -[TuyaSmartBLEManager -  startActiveBLE:homeId:success:failure] instead");


/**
 激活设备，设备 uuid 来源于搜索发现的设备
 激活过程会将设备信息注册到云端
 
 @param deviceInfo 设备信息 Model
 @param homeId 家庭 id
 @param success 成功回调
 @param failure 失败回调
 */
- (void)activeBLE:(TYBLEAdvModel *)deviceInfo
           homeId:(long long)homeId
          success:(void(^)(TuyaSmartDeviceModel *deviceModel))success
          failure:(TYFailureHandler)failure;


/**
 发送OTA包，升级固件。升级前请务必保证设备已通过蓝牙连接
 
 @param uuid 设备 uuid
 @param otaData 升级固件的数据
 @param success 成功回调
 @param failure 失败回调
 */
- (void)sendOTAPack:(NSString *)uuid
            otaData:(NSData *)otaData
            success:(TYSuccessHandler)success
            failure:(TYFailureHandler)failure __deprecated_msg("This method is deprecated, Use -[TuyaSmartBLEManager -  sendOTAPack:pid:otaData:otaType:success:failure] instead");


/**
 发送OTA包，升级固件。升级前请务必保证设备已通过蓝牙连接
 
 @param uuid    设备 uuid
 @param pid     设备 pid
 @param otaData 升级固件的数据
 @param success 成功回调
 @param failure 失败回调
 */
- (void)sendOTAPack:(NSString *)uuid
                pid:(NSString *)pid
            otaData:(NSData *)otaData
            success:(TYSuccessHandler)success
            failure:(TYFailureHandler)failure __deprecated_msg("This method is deprecated, Use -[TuyaSmartBLEManager -  sendOTAPack:pid:otaData:otaType:otaVersion:success:failure] instead");


/**
 发送OTA包，升级固件。升级前请务必保证设备已通过蓝牙连接
 
 @param uuid        设备 uuid
 @param pid         设备 pid
 @param otaData     升级固件的数据
 @param otaType     升级类型
 @param otaVersion  升级版本
 @param success     成功回调
 @param failure     失败回调
 */
- (void)sendOTAPack:(NSString *)uuid
                pid:(NSString *)pid
            otaData:(NSData *)otaData
            otaType:(TuyaSmartBLEOTAType)otaType
         otaVersion:(NSString *)otaVersion
            success:(TYSuccessHandler)success
            failure:(TYFailureHandler)failure;


/**
 获取蓝牙外设的信号
 
 @param uuid 设备 uuid
 @return 设备信号，若为 0，则获取失败。
 */
- (NSInteger)getPeripheralRSSI:(NSString *)uuid;


/**
 根据 UUID 来判断设备是否已连接
 @param uuid 设备 uuid
 @return 该设备是否连接
*/
- (BOOL)deviceStatueWithUUID:(NSString *)uuid;

@end

NS_ASSUME_NONNULL_END
