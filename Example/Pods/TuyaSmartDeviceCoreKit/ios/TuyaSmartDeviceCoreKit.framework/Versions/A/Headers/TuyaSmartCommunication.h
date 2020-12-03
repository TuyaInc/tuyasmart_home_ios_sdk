//
//  TuyaSmartCommunication.h
//  CocoaAsyncSocket
//
//  Created by huangkai on 2020/7/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, TYCommunicationType) {
    TYCommunicationTypeLAN      = 0, // 局域网
    TYCommunicationTypeMQTT     = 1, // mqtt
    TYCommunicationTypeHTTP     = 2, // http
    TYCommunicationTypeBLE      = 3, // 单点蓝牙
    TYCommunicationTypeSIGMesh  = 4, // sig mesh
    TYCommunicationTypeBLEMesh  = 5, // 涂鸦私有 mesh
};

@interface TuyaSmartCommunicationMode : NSObject

/// 通讯协议版本
@property (nonatomic, assign) double pv;

/// 通讯协议类型
@property (nonatomic, assign) TYCommunicationType type;

@end

@interface TuyaSmartCommunication : NSObject

/// 通信顺序
@property (nonatomic, strong) NSArray<TuyaSmartCommunicationMode *> *communicationModes;

/// 通讯节点
@property (nonatomic, strong) NSString *communicationNode;

@end

NS_ASSUME_NONNULL_END
