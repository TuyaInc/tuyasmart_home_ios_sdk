//
//  TuyaSmartMemberLinkDeviceListModel.h
//  TuyaSmartDeviceKit
//
//  Created by 吴戈 on 2018/10/12.
//

#import <Foundation/Foundation.h>

@interface TuyaSmartMemberLinkDeviceModel : NSObject

// 设备Id
@property (nonatomic, strong) NSString *devId;

// 设备名称
@property (nonatomic, strong) NSString *deviceName;

// 所在房间名
@property (nonatomic, strong) NSString *room;

// 是否关联
@property (nonatomic, assign) BOOL relation;

// 设备图片
@property (nonatomic, strong) NSString *icon;

@end

@interface TuyaSmartMemberLinkDeviceListModel : NSObject

// 产品大类
@property (nonatomic, strong) NSString *productType;

// 设备列表
@property (nonatomic, strong) NSArray<TuyaSmartMemberLinkDeviceModel *> * deviceList;

@end
