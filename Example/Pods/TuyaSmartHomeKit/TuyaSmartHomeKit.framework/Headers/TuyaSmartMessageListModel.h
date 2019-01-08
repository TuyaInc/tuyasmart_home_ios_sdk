//
//  TuyaSmartMessageListModel.h
//  TuyaSmartKit
//
//  Created by xuyongbo on 2017/9/11.
//  Copyright © 2017年 Tuya. All rights reserved.
//

/// 消息附件
@interface TuyaSmartMessageAttachModel : TYModel

/**
 附件是否是视频 (.mp4视为视频)
 */
@property (nonatomic, assign) BOOL isVideo;

/**
 附件url
 */
@property (nonatomic, strong) NSString *url;

/**
 缩略图url
 */
@property (nonatomic, strong) NSString *thumbUrl;

@end


///消息列表
@interface TuyaSmartMessageListModel : TYModel

/**
 消息id
 */
@property (nonatomic, strong) NSString *msgId;

/**
 消息图标
 */
@property (nonatomic, strong) NSString *icon;

/**
 消息内容
 */
@property (nonatomic, strong) NSString *msgContent;

/**
 附件列表
 */
@property (nonatomic, strong) NSArray<TuyaSmartMessageAttachModel *> *attachPicList;

/**
 设备id（注： 只有告警类型消息才会有该字段）
 */
@property (nonatomic, strong) NSString  *msgSrcId;

/**
 格式化的日期时间
 */
@property (nonatomic, strong) NSString *dateTime;

/**
 消息类型
 0: 系统消息
 1: 有新的设备
 2: 有新的好友
 4: 设备告警
 */
@property (nonatomic, assign) NSInteger msgType;

/**
 消息时间戳
 */
@property (nonatomic, assign) NSInteger time;

@end
