//
//  TYSDKLocalNetworkManager.h
//  TuyaSmartUtil
//
//  Created by 高森 on 2020/9/8.
//  Copyright © 2020 tuya. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(int, TYSDKLocalNetworkStatus) {
    // 本地网络没有连接（无线网卡无法获取IP地址）
    // Local network not connected (Wi-Fi adapter can't get IP address)
    kTYSDKLocalNetworkStatusNotConnected,
    
    // 用户已经禁止此应用使用“本地网络”权限，或者还没有作出选择
    // User has explicitly denied authorization for this application, or not yet made a choice
    kTYSDKLocalNetworkStatusNotDeterminedOrDenied,
    
    // 用户已经允许此应用使用“本地网络”权限
    // User has granted authorization to use their local network only while they are using your app.
    kTYSDKLocalNetworkStatusStatusAuthorized,
};

API_AVAILABLE(ios(14.0))
@interface TYSDKLocalNetworkManager : NSObject

+ (instancetype)manager;

/**
    获取“本地网络”的 IP 地址（beta）
    Get "Local Network" IP address (beta)
 */
- (NSString *)localIPAddress;

/**
    申请“本地网络”授权（beta）
 
    在 Wi-Fi 已连接的前提下，调用此方法会触发“本地网络”的授权弹窗。弹窗只会出现一次，直到 App 卸载重装。
    目前没有办法获取此次触发的状态变更回调。
 
    Request "Local Network" authorization (beta)
 
    When Wi-Fi is connected, calling this method will start the process of requesting "Local Network" authorization from the user. The authorization prompt will only appear once until App uninstalled.
    Currently we can't get authorization change callback for this request.
 */
- (void)requestAuthorization;


/**
    获取“本地网络”的授权状态（beta）
    Returns the current authorization status of the calling application (beta).
 */
- (void)authorizationStatus:(void (^)(TYSDKLocalNetworkStatus status))callback;

@end
