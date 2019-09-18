//
//  TuyaSmartHome+SIGMesh.h
//  TuyaSmartBLEMeshKit
//
//  Created by 黄凯 on 2019/3/8.
//

#import <TuyaSmartDeviceKit/TuyaSmartDeviceKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TuyaSmartHome (SIGMesh)

@property (nonatomic, strong, readonly) TuyaSmartBleMeshModel *sigMeshModel;

/**
 *  获取家庭下的 sig mesh 列表
 *
 *  @param success 操作成功回调
 *  @param failure 操作失败回调
 */
- (void)getSIGMeshListWithSuccess:(void(^)(NSArray <TuyaSmartBleMeshModel *> *list))success
                          failure:(TYFailureError)failure;

@end

NS_ASSUME_NONNULL_END
