//
//  TuyaSmartGroupModel.h
//  TuyaSmartPublic
//
//  Created by 高森 on 16/4/20.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#ifndef TuyaSmart_TuyaSmartGroupModel
#define TuyaSmart_TuyaSmartGroupModel

typedef enum : NSUInteger {
    TuyaSmartGroupTypeWifi = 0,
    TuyaSmartGroupTypeMesh,
    TuyaSmartGroupTypeZigbee,
} TuyaSmartGroupType;

#import <Foundation/Foundation.h>
#import "TuyaSmartDevice.h"

@interface TuyaSmartGroupModel : NSObject

//群组唯一标识符
@property (nonatomic, strong) NSString  *groupId;

//产品唯一标识符
@property (nonatomic, strong) NSString  *productId;

//群组创建时间
@property (nonatomic, assign) long long    time;

//群组名称
@property (nonatomic, strong) NSString  *name;

//群组iconUrl
@property (nonatomic, strong) NSString  *iconUrl;

// 群组类型
@property (nonatomic, assign) TuyaSmartGroupType  type;

@property (nonatomic, assign) BOOL      isShare;

// dps
@property (nonatomic, strong) NSDictionary *dps;

// localKey
@property (nonatomic, strong) NSString     *localKey;

// pv
@property (nonatomic, assign) float        pv;

// deviceNum
@property (nonatomic, assign) NSInteger    deviceNum;

// productInfo
@property (nonatomic, strong) NSDictionary *productInfo;

// homeId
@property (nonatomic, assign) long long    homeId;

// roomId
@property (nonatomic, assign) long long    roomId;

// 排序
@property (nonatomic, assign) NSInteger displayOrder;

// 设备列表
@property (nonatomic, strong) NSArray<TuyaSmartDeviceModel *> *deviceList;

//群组的本地短地址
@property (nonatomic, strong) NSString     *localId;

//大小类
@property (nonatomic, strong) NSString     *pcc;

// meshId 或者 gwId
@property (nonatomic, strong) NSString     *meshId;

@end

#endif
