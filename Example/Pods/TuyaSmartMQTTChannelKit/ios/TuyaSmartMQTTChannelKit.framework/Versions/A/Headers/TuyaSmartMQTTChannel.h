//
//  TuyaSmartMQTTChannel.h
//  TuyaSmart
//
//  Created by xucheng on 15/5/30.
//  Copyright (c) 2015年 Tuya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TuyaSmartMQTTConfigModel.h"

@interface TuyaSmartPublishMessageModel : NSObject

@property (nonatomic, strong) NSString          *devId;

@property (nonatomic, assign) NSTimeInterval    time; // time stamp
@property (nonatomic, assign) NSInteger         protocol; // protocol
@property (nonatomic, assign) double            pv; // version
@property (nonatomic, strong) NSDictionary      *body; // body
@property (nonatomic, strong) NSString          *localKey; // local key
@property (nonatomic, assign) NSInteger         publishS;// sequence
@property (nonatomic, assign) NSInteger         publishR;// publish Id

@end

@interface TuyaSmartResponseMessageModel : NSObject

@property (nonatomic, strong) NSString          *devId;
@property (nonatomic, strong) id                message;  // mesh array
@property (nonatomic, assign) NSInteger         protocol; // protocol
@property (nonatomic, strong) NSString          *type;
@property (nonatomic, assign) NSInteger         responseS;// sequence
@property (nonatomic, assign) NSInteger         responseR;// response Id

@end

@class TuyaSmartMQTTChannel;

/**
 mqtt connect state
 */
typedef NS_ENUM (NSInteger, TuyaSmartMqttConnectState){
    TuyaSmartMqttConnectStateCreated,
    TuyaSmartMqttConnectStateConnecting,
    TuyaSmartMqttConnectStateConnected,
    TuyaSmartMqttConnectStateDisconnecting,
    TuyaSmartMqttConnectStateClose,
    TuyaSmartMqttConnectStateError,
};

@protocol TuyaSmartMQTTChannelDelegate <NSObject>

@optional

/**
 *  mqtt connection channel state changes
 *  mqtt 连接的状态改变回调
 */
- (void)mqttChannel:(TuyaSmartMQTTChannel *)mqttChannel connectState:(TuyaSmartMqttConnectState)connectState error:(NSError *)error;

/**
 *  Receive mqtt data
 *  收到mqtt消息上报
 */
- (void)mqttChannel:(TuyaSmartMQTTChannel *)mqttChannel didReceiveMessage:(TuyaSmartResponseMessageModel *)message topic:(NSString *)topic;

@end


@interface TuyaSmartMQTTChannel : NSObject

+ (instancetype)sharedInstance;

/**
 *  connect mqtt host
 *  建立 mqtt 连接
 *
 *  @param mqttConfig mqttConfig
 */
- (void)startConnectToHostWithMqttConfig:(TuyaSmartMQTTConfigModel *)mqttConfig;

/**
 *  close mqtt host
 *  关闭mqtt连接
 */
- (void)close;

/**
 *  mqtt connect state
 *  mqtt 连接状态
 */
- (TuyaSmartMqttConnectState)connectState;

/**
 *  subscribe topic
 *  订阅主题
 *
 *  @param topic   Topic
 *  @param success Success block
 *  @param failure Failure block
 */
- (void)subscribeToTopic:(NSString *)topic
                 devInfo:(NSDictionary *)devInfo
                 success:(TYSuccessHandler)success
                 failure:(TYFailureError)failure;

/**
 *  unsubscribe topic
 *  取消订阅主题
 *
 *  @param topic   Topic
 *  @param success Success block
 *  @param failure Failure block
 */
- (void)unsubscribeToTopic:(NSString *)topic
                   success:(TYSuccessHandler)success
                   failure:(TYFailureError)failure;

/**
 *  推送mqtt消息
 *  publish mqtt data
 *
 *  @param data    Data
 *  @param topic   Topic
 *  @param success Success block
 *  @param failure Failure block
 *  @return the Message Identifier of the publish message. Zero if qos 0. If qos 1 or 2, zero was publish faliure
 */
- (UInt16)publishMessage:(NSData *)data
                   topic:(NSString *)topic
                 success:(TYSuccessHandler)success
                 failure:(TYFailureError)failure;

/**
 *  推送mqtt消息
 *  publish mqtt data
 *
 *  @param messageModel MessageModel
 *  @param topic        Topic
 *  @param success      Success block
 *  @param failure      Failure block
 */
- (void)publishMessageWithMessageModel:(TuyaSmartPublishMessageModel *)messageModel
                                 topic:(NSString *)topic
                               success:(TYSuccessHandler)success
                               failure:(TYFailureError)failure;

/**
 *  add mqtt channel delegate
 *  添加mqtt长连接的代理
 *
 *  @param delegate Delegate
 */
- (void)addDelegate:(id<TuyaSmartMQTTChannelDelegate>)delegate;

/**
 *  remove mqtt channel delegate
 *  删除mqtt长连接的代理
 *
 *  @param delegate Delegate
 */
- (void)removeDelegate:(id<TuyaSmartMQTTChannelDelegate>)delegate;

@end
