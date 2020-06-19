//
//  TuyaSmartMessageRequestModel.h
//  TuyaSmartMessageKit
//
//  Created by Hemin Won on 2020/4/7.
//

#import <Foundation/Foundation.h>
#import "TuyaSmartMessageUtils.h"

NS_ASSUME_NONNULL_BEGIN

/// 消息中心消息列表请求模型
@interface TuyaSmartMessageListRequestModel : NSObject

/// 消息类型 message type
@property (nonatomic, assign) TYMessageType msgType;

/// 限制列表数 limit count
@property (nonatomic, assign) NSInteger limit;

/// 偏移 offset
@property (nonatomic, assign) NSInteger offset;

@end

/// 消息中心消息详情列表请求模型
@interface TuyaSmartMessageDetailListRequestModel : NSObject

/// 消息类型(目前仅支持TYMessageTypeAlarm类消息) message type( Currently only supported TYMessageTypeAlarm)
@property (nonatomic, assign) TYMessageType msgType;

/// 限制列表数 limit count
@property (nonatomic, assign) NSInteger limit;

/// 偏移 offset
@property (nonatomic, assign) NSInteger offset;

/// 消息来源设备ID message device ID
@property (nonatomic, copy) NSString *msgSrcId;

@end

@interface TuyaSmartMessageListDeleteRequestModel : NSObject
/// 消息类型 message type
@property (nonatomic, assign) TYMessageType msgType;

/// 消息ID message ID
@property (nonatomic, copy) NSArray<NSString *> *msgIds;

/// 消息来源设备ID message device ID
@property (nonatomic, copy) NSArray<NSString *> *msgSrcIds;

@end

@interface TuyaSmartMessageListReadRequestModel : NSObject

/// 消息类型(目前仅支持TYMessageTypeAlarm类消息) message type( Currently only supported TYMessageTypeAlarm)
@property (nonatomic, assign) TYMessageType msgType;

/// 消息ID message ID
@property (nonatomic, copy) NSArray<NSString *> *msgIds;

@end

NS_ASSUME_NONNULL_END
