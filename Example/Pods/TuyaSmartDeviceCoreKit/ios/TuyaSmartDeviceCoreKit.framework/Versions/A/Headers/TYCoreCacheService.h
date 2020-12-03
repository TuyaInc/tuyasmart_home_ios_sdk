//
//  TYCoreCacheService.h
//  TuyaSmartDeviceCoreKit
//
//  Created by huangkai on 2020/6/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol TYCoreCacheServiceDelegate <NSObject>

- (void)deviceWillRemove:(NSString *)devId;
- (void)groupWillRemove:(long long)groupId;


- (void)deviceWillAdd:(TuyaSmartDeviceModel *)deviceModel homeId:(long long)homeId;
- (void)groupWillAdd:(TuyaSmartGroupModel *)groupModel homeId:(long long)homeId;

- (void)deviceListWillAdd:(NSArray<TuyaSmartDeviceModel *> *)deviceList homeId:(long long)homeId;

@end

@interface TYCoreCacheService : NSObject

TYSDK_SINGLETON;

@property (nonatomic, weak) id<TYCoreCacheServiceDelegate> delegate;

/// 设备缓存
@property (nonatomic, strong, readonly) NSMutableDictionary<NSString *, TuyaSmartDeviceModel *> *deviceData;

/// 群组缓存
@property (nonatomic, strong, readonly) NSMutableDictionary<NSString *, TuyaSmartGroupModel *> *groupData;

/// 群组产品信息缓存
@property (nonatomic, strong, readonly) NSMutableDictionary<NSString *, NSDictionary *> *groupProductData;

/// 群组设备关系缓存
@property (nonatomic, strong, readonly) NSMutableDictionary *groupDeviceRelation;

/// mesh 信息
@property (nonatomic, strong, readonly) NSMutableDictionary<NSString *, TuyaSmartBleMeshModel *> *meshData;

/// mesh 群组信息
@property (nonatomic, strong, readonly) NSMutableDictionary *meshGroupAddData;


- (void)setCacheHandlerQueue:(dispatch_queue_t)queue;

- (void)reset;

- (TuyaSmartDeviceModel *)getDeviceInfoWithDevId:(NSString *)devId;

- (TuyaSmartGroupModel *)getGroupInfoWithGroupId:(long long)groupId;

- (NSDictionary *)getGroupProductWithProductId:(NSString *)productId;

- (NSArray <TuyaSmartDeviceModel *> *)getDeviceListWithGroupId:(long long)groupId;

- (void)updateGroupProductList:(NSArray <NSDictionary *> *)groupProductList;

- (void)updateDeviceGroupRelationWithDeviceList:(NSArray *)deviceList groupId:(long long)groupId;

- (void)updateDeviceGroupRelationWithDeviceList:(NSArray *)deviceList groupId:(long long)groupId shouldNotify:(BOOL)shouldNotify;

- (NSArray <TuyaSmartDeviceModel *> *)getAllDeviceList;
- (NSArray <TuyaSmartGroupModel *> *)getAllGroupList;

- (void)updateSharedDeviceList:(NSArray <TuyaSmartDeviceModel *> *)deviceList;

- (void)updateSharedGroupList:(NSArray <TuyaSmartGroupModel *> *)groupList;

- (NSArray <TuyaSmartDeviceModel *> *)getDeviceListWithHomeId:(long long)homeId;
// remove delegates

- (void)removeDeviceWithDevId:(NSString *)devId;
- (void)removeGroupWithGroupId:(long long)groupId;

// add delegate

- (void)addDeviceModel:(TuyaSmartDeviceModel *)deviceModel homeId:(long long)homeId;
- (void)addGroupModel:(TuyaSmartGroupModel *)groupModel homeId:(long long)homeId;

- (void)addDeviceModelList:(NSArray<TuyaSmartDeviceModel *> *)deviceModelList homeId:(long long)homeId;

// mesh
- (TuyaSmartBleMeshModel *)getMeshModelWithHomeId:(long long)homeId isSigMesh:(BOOL)isSigMesh;
- (TuyaSmartBleMeshModel *)getMeshModelWithMeshId:(NSString *)meshId;
- (void)updateMeshModel:(TuyaSmartBleMeshModel *)meshModel;
- (NSArray<TuyaSmartBleMeshModel *> *)getAllMeshList;

- (NSInteger)getMeshGroupAddressFromLocalWithMeshId:(NSString *)meshId;
- (NSInteger)getMeshGroupCountFromLocalWithMeshId:(NSString *)meshId;
- (void)removeMeshGroupWithAddress:(NSInteger)address meshId:(NSString *)meshId;

@end

NS_ASSUME_NONNULL_END
