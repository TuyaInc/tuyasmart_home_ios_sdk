//
//  TuyaSmartSIGMeshManager+Config.h
//  BlocksKit
//
//  Created by 温明妍 on 2019/12/17.
//

#import <TuyaSmartBLEMeshKit/TuyaSmartBLEMeshKit.h>
NS_ASSUME_NONNULL_BEGIN

@class TuyaSmartDeviceModel;

@interface TuyaSmartSIGMeshManager (Config)

/**
 重置节点
 
 @param deviceModel 节点地址
 @param success 成功回调（- 目前通过代理回调，block 暂未实现）
 @param failure 失败回调（- 目前通过代理回调，block 暂未实现）
 */
- (void)sendNodeResetWithDeviceModel:(TuyaSmartDeviceModel *)deviceModel
                             success:(nullable TYSuccessHandler)success
                             failure:(nullable TYFailureError)failure;

/**
 开关命令
 
 @param nodeId 节点地址
 @param state 开关状态
 @param useUnacknowledged 是否需要回复，建议群组使用 no，单设备控制 yes
 @param success 成功回调（- 目前通过代理回调，block 暂未实现）
 @param failure 失败回调（- 目前通过代理回调，block 暂未实现）
 */
- (void)sendOnoffWithNodeId:(NSString *)nodeId
                      state:(BOOL)state
          useUnacknowledged:(BOOL)useUnacknowledged
                    success:(nullable TYSuccessHandler)success
                    failure:(nullable TYFailureError)failure;


/**
 亮度命令
 
 @param nodeId 节点地址
 @param brightValue 亮度值，0 -- 65535
 @param useUnacknowledged 是否需要回复，建议群组使用 no，单设备控制 yes
 @param success 成功回调（- 目前通过代理回调，block 暂未实现）
 @param failure 失败回调（- 目前通过代理回调，block 暂未实现）
 */
- (void)sendLightBrightWithNodeId:(NSString *)nodeId
                      brightValue:(int)brightValue
                useUnacknowledged:(BOOL)useUnacknowledged
                          success:(nullable TYSuccessHandler)success
                          failure:(nullable TYFailureError)failure;

/**
 冷暖控制
 
 @param nodeId 节点地址
 @param tempValue 冷暖值 300 - 20000
 @param useUnacknowledged 是否需要回复，建议群组使用 no，单设备控制 yes
 @param success 成功回调（- 目前通过代理回调，block 暂未实现）
 @param failure 失败回调（- 目前通过代理回调，block 暂未实现）
 */
- (void)sendLightCTLTempeValueWithNodeId:(NSString *)nodeId
                               tempValue:(int)tempValue
                       useUnacknowledged:(BOOL)useUnacknowledged
                                 success:(nullable TYSuccessHandler)success
                                 failure:(nullable TYFailureError)failure;


/**
 HSL 颜色控制
 
 @param nodeId 节点地址
 @param aHue 色调 0 - 65535
 @param aSaturation 饱和度 0 - 65535
 @param aLightness 亮度 l or v，0 - 65535
 @param useUnacknowledged 是否需要回复，建议群组使用 no，单设备控制 yes
 @param success 成功回调（- 目前通过代理回调，block 暂未实现）
 @param failure 失败回调（- 目前通过代理回调，block 暂未实现）
 */
- (void)sendLightHSLWithNodeId:(NSString *)nodeId
                           hue:(int)aHue
                 andSaturation:(int)aSaturation
                     lightness:(int)aLightness
             useUnacknowledged:(BOOL)useUnacknowledged
                       success:(nullable TYSuccessHandler)success
                       failure:(nullable TYFailureError)failure;


/**
 设置模式
 
 @param nodeId nodeId 节点地址
 @param alightModel 0: 白光模式。 1: 彩光模式
 @param useUnacknowledged 是否需要回复，建议群组使用 no，单设备控制 yes
 @param success 成功回调（- 目前通过代理回调，block 暂未实现）
 @param failure 失败回调（- 目前通过代理回调，block 暂未实现）
 */
- (void)sendLightModelWithNodeId:(NSString *)nodeId
                      lightModel:(int)alightModel
               useUnacknowledged:(BOOL)useUnacknowledged
                         success:(nullable TYSuccessHandler)success
                         failure:(nullable TYFailureError)failure;


/**
 通用 vendor 协议
 
 @param nodeId 节点地址
 @param vendorData 数据内容
 @param isisQuery 是否为查询指令
 @param useUnacknowledged 是否需要回复，建议群组使用 no，单设备控制 yes
 @param success 成功回调（- 目前通过代理回调，block 暂未实现）
 @param failure 失败回调（- 目前通过代理回调，block 暂未实现）
 */
- (void)sendVendorDataWithNodeId:(NSString *)nodeId
                      vendorData:(NSData *)vendorData
                         isQuery:(BOOL)isisQuery
               useUnacknowledged:(BOOL)useUnacknowledged
                         success:(TYSuccessHandler)success
                         failure:(TYFailureError)failure;

/**
 单设备下发消息
 
 @param nodeId 节点地址
 @param schemaArray dps 信息
 @param dps 下发 dp
 @param pcc 产品大小类标示
 @param useUnacknowledged 是否需要消息回复
 @param success 成功回调
 @param failure 失败回调
 */
- (void)publishDpsWithNodeId:(NSString *)nodeId
                 schemaArray:(NSArray<TuyaSmartSchemaModel *> *)schemaArray
                         dps:(NSDictionary *)dps
                         pcc:(NSString *)pcc
           useUnacknowledged:(BOOL)useUnacknowledged
                     success:(nullable TYSuccessHandler)success
                     failure:(nullable TYFailureError)failure;


/**
 获取某个设备的状态
 
 @param deviceModel 设备 model
 */
- (void)getDeviceStatusWithDeviceModel:(TuyaSmartDeviceModel *)deviceModel;


/**
 查询设备的 dps

 @param deviceModel 查询的设备
 @param dpIds 要查询的 dp id 组
 */
- (void)queryDpsWithDeviceModel:(TuyaSmartDeviceModel *)deviceModel dpIds:(NSArray<NSString *> *)dpIds;

@end
NS_ASSUME_NONNULL_END
