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

@property (nonatomic, weak) id<TuyaSmartSocketChannelDelegate> delegate;

+ (instancetype)sharedInstance;

#pragma mark - TCP

// connect TCP
- (void)initTcpClientWithHost:(NSString *)host devInfo:(NSDictionary *)devInfo;

// register reader
- (void)registerTcpClientReaderWithDevId:(NSString *)devId tag:(long)tag;

// send TCP message
- (BOOL)sendTcpRequest:(TuyaSmartSocketWriteModel *)request;

// whether the TCP connection
- (BOOL)hasTcpClientWithDevId:(NSString *)devId;

// close Tcp connect
- (void)closeTcpClientWithDevId:(NSString *)devId;

// close all tcp connect
- (void)closeAllTcpClient;

#pragma mark - UDP

// init udp serve
- (void)initUdpServer;

// close udp serve
- (void)closeUdpServer;

@end

