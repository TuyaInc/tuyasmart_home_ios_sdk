//
//  TuyaSmartHome+BleMesh.h
//  TuyaSmartBLEKit
//
//  Created by 高森 on 2018/9/4.
//

#import <TuyaSmartDeviceKit/TuyaSmartDeviceKit.h>

@interface TuyaSmartHome (BleMesh)

@property (nonatomic, strong, readonly) TuyaSmartBleMeshModel *meshModel;

/**
 *  获取家庭下的mesh列表
 *
 *  @param success     操作成功回调
 *  @param failure     操作失败回调
 */
- (void)getMeshListWithSuccess:(void(^)(NSArray <TuyaSmartBleMeshModel *> *list))success
                       failure:(TYFailureError)failure;


@end
