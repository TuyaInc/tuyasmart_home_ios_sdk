//
//  TuyaSmartActivator+BleMesh.h
//  TuyaSmartBLEKit
//
//  Created by 高森 on 2018/9/20.
//

#import <TuyaSmartDeviceKit/TuyaSmartDeviceKit.h>

@interface TuyaSmartActivator (BleMesh)

/**
 *
 *  wifi连接器加入mesh
 *  获取配网Token（有效期10分钟）
 *
 *  @param meshId meshId
 *  @param nodeId 短地址
 *  @param productId 产品Id
 *  @param uuid   设备唯一值
 *  @param authKey 权限key
 *  @param success 操作成功回调，返回配网Token
 *  @param failure 操作失败回调
 */
- (void)getTokenWithMeshId:(NSString *)meshId
                    nodeId:(NSString *)nodeId
                 productId:(NSString *)productId
                      uuid:(NSString *)uuid
                   authKey:(NSString *)authKey
                   version:(NSString *)version
                   success:(TYSuccessString)success
                   failure:(TYFailureError)failure;

/**
 *  mesh 配网
 *
 *  @param ssid     路由器热点名称
 *  @param password 路由器热点密码
 *  @param token    配网Token
 *  @param timeout  超时时间, 默认为100秒
 */
- (void)startBleMeshConfigWiFiWithSsid:(NSString *)ssid
                              password:(NSString *)password
                                 token:(NSString *)token
                               timeout:(NSTimeInterval)timeout;


@end
