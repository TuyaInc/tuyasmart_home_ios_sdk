//
//  TuyaSmartSIGMeshManager+OTA.h
//  BlocksKit
//
//  Created by 温明妍 on 2019/12/17.
//

#import <TuyaSmartBLEMeshKit/TuyaSmartBLEMeshKit.h>

@interface TuyaSmartSIGMeshManager (OTA)

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
