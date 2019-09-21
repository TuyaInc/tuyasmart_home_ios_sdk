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

/**
 开始扫描设备
 
 @param scanType 扫描类型，目前分为未配网和已配网，已配网扫描到结果会自动入网
 @param meshModel mesh model 信息
 */
- (void)startScanWithScanType:(TuyaSmartSIGScanType)scanType meshModel:(TuyaSmartBleMeshModel *)meshModel;


/**
 开始激活设备
 
 @param devList 待激活设备列表
 @param meshModel mesh model 信息
 */
- (void)startActive:(NSArray<TuyaSmartSIGMeshDiscoverDeviceInfo *> *)devList meshModel:(TuyaSmartBleMeshModel *)meshModel;

/**
 停止激活设备
 */
- (void)stopActiveDevice;

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
 重置节点
 
 @param deviceModel 节点地址
 @param success 成功回调（- 目前通过代理回调，block 暂未实现）
 @param failure 失败回调（- 目前通过代理回调，block 暂未实现）
 */
- (void)sendNodeResetWithDeviceModel:(TuyaSmartDeviceModel *)deviceModel
                             success:(nullable TYSuccessHandler)success
                             failure:(nullable TYFailureError)failure;


/**
 把设备加入到群组
 
 @param devId 设备 id
 @param groupAddress 群组地址
 */
- (void)addDeviceToGroupWithDevId:(NSString *)devId
                     groupAddress:(uint32_t)groupAddress;



/**
 把设备从群组内移除
 
 @param devId 设备 id
 @param groupAddress 群组地址
 */
- (void)deleteDeviceToGroupWithDevId:(NSString *)devId
                        groupAddress:(uint32_t)groupAddress;


/**
 通过群组地址查询群组中的设备

 @param groupAddress 群组地址
 */
- (void)queryGroupMemberWithGroupAddress:(uint32_t)groupAddress;


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
 准备给目标设备升级
 
 @param targetNodeId 目标设备 nodeid
 */
- (void)prepareForOTAWithTargetNodeId:(NSString *)targetNodeId;

/**
 开始发送升级包
 */
- (void)startSendOTAPack:(NSData *)data
           targetVersion:(NSString *)targetVersion
                 success:(TYSuccessHandler)success
                 failure:(TYFailureHandler)failure;


@end

NS_ASSUME_NONNULL_END
