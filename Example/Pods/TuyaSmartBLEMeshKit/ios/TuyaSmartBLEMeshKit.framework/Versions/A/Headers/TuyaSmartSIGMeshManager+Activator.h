//
//  TuyaSmartSIGMeshManager+Activator.h
//  BlocksKit
//
//  Created by 温明妍 on 2019/12/17.
//

#import <TuyaSmartBLEMeshKit/TuyaSmartBLEMeshKit.h>

@interface TuyaSmartSIGMeshManager (Activator)

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


@end

