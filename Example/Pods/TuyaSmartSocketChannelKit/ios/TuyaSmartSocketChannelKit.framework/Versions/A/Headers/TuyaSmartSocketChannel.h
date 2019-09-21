//
//  TuyaSmartSocketChannel.h
//
//
//  Created by xcc on 19/3/13.
//
//

#import <Foundation/Foundation.h>
#import "TuyaSmartSocketReadModel.h"
#import "TuyaSmartSocketWriteModel.h"

// 协议
#define SOCKET_TYPE_BROADCAST             0x00
#define SOCKET_TYPE_BROADCAST_V4          0x13
#define SOCKET_TYPE_AP_ERROR              0x15
#define SOCKET_TYPE_AP_CONFIG             0x01
#define SOCKET_TYPE_AP_ACTIVATE           0x02
#define SOCKET_TYPE_DP_PUBLISH            0x07
#define SOCKET_TYPE_DP_REPORT             0x08
#define SOCKET_TYPE_HEARTBEAT             0x09
#define SOCKET_TYPE_QUERY_DEV_INFO        0x0a
#define SOCKET_TYPE_QUERY_SSID_LIST       0x0b
#define SOCKET_TYPE_DP_CAD_PUBLISH        0x0d
#define SOCKET_TYPE_LOCL_SCENE_EXE        0x11
#define SOCKET_TYPE_ENABLE_LOG            0x20
#define SOCKET_TYPE_BIND_TOKEN            0x0c
#define SOCKET_TYPE_ACTIVE_SUBDEV         0x0e
#define SOCKET_TYPE_QUERY_CAD_DEV_INFO    0x10
#define SOCKET_TYPE_INITIATIVE_QUERY_DPS  0x12
#define SOCKET_TYPE_AP_CONFIG             0x01
#define SOCKET_TYPE_AP_CONFIG_NEW         0x14

@class TuyaSmartSocketChannel;

@protocol TuyaSmartSocketChannelDelegate <NSObject>

@optional

#pragma mark - TCP Delegate

// TCP Connection Successful
- (void)socketDidTcpConnected:(TuyaSmartSocketChannel *)socket devId:(NSString *)devId;

// Receive TCP message
- (void)socket:(TuyaSmartSocketChannel *)socket didReceiveTcpData:(TuyaSmartSocketReadModel *)tcpData tag:(long)tag devId:(NSString *)devId;

// TCP disconnection
- (void)socketDidTcpDisconnect:(TuyaSmartSocketChannel *)socket devId:(NSString *)devId error:(NSError *)error;


#pragma mark - UDP Delegate

// Receive UDP message
- (void)socket:(TuyaSmartSocketChannel *)socket didReceiveUdpData:(TuyaSmartSocketReadModel *)udpData;

// Close UDP connection
- (void)socketDidUdpClose:(TuyaSmartSocketChannel *)socket error:(NSError *)error;

@end

@interface TuyaSmartSocketChannel : NSObject

+ (instancetype)sharedInstance;

/**
 *  未激活的设备列表
 */
@property (nonatomic, strong) TYSDKSafeMutableDictionary   *inactiveDevices;

#pragma mark - TCP

// connect TCP
- (void)initTcpClientWithHost:(NSString *)host devInfo:(NSDictionary *)devInfo;

// send TCP message
- (void)sendTcpRequest:(TuyaSmartSocketWriteModel *)request success:(TYSuccessDict)success failure:(TYFailureHandler)failure;

- (void)removeInactiveDevice:(NSString *)gwId;

- (void)removeAllInactiveDevice;

// whether the TCP connection
- (BOOL)hasTcpClientWithDevId:(NSString *)devId;

// close TCP connect
- (void)closeTcpClientWithDevId:(NSString *)devId;

// close all TCP connect
- (void)closeAllTcpClient;

#pragma mark - UDP

// init UDP serve
- (void)initUdpServerWithPort:(NSInteger)port;

// send UDP message
- (void)sendUdpRequestWithHost:(NSString *)host port:(NSInteger)port type:(int)type body:(NSDictionary *)body success:(TYSuccessHandler)success failure:(TYFailureHandler)failure;

// close UDP serve
- (void)closeUdpServerWithPort:(uint16_t)port;

#pragma mark - Delegate

// add socket channel delegate
- (void)addDelegate:(id<TuyaSmartSocketChannelDelegate>)delegate;

// remove socket channel delegate
- (void)removeDelegate:(id<TuyaSmartSocketChannelDelegate>)delegate;

@end

