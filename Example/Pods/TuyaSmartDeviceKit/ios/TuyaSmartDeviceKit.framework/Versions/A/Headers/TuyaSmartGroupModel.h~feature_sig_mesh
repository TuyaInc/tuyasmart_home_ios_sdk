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
    TuyaSmartGroupTypeSIGMesh,
} TuyaSmartGroupType;

#import <Foundation/Foundation.h>
#import "TuyaSmartDevice.h"

@interface TuyaSmartGroupModel : NSObject

// group Id
@property (nonatomic, strong) NSString  *groupId;

// product Id
@property (nonatomic, strong) NSString  *productId;

// group creation time
@property (nonatomic, assign) long long    time;

// name of group
@property (nonatomic, strong) NSString  *name;

// iconUrl
@property (nonatomic, strong) NSString  *iconUrl;

// type of group
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

// customize DP name
@property (nonatomic, copy)   NSDictionary *dpName;

// order
@property (nonatomic, assign) NSInteger displayOrder;

// home all group order
@property (nonatomic, assign) NSInteger homeDisplayOrder;

// device list
@property (nonatomic, strong) NSArray<TuyaSmartDeviceModel *> *deviceList;

// local Short Address of Groups
@property (nonatomic, strong) NSString     *localId;

// subclass
@property (nonatomic, strong) NSString     *pcc;

// meshId or gwId
@property (nonatomic, strong) NSString     *meshId;

// schema array
@property (nonatomic, strong) NSArray      *schemaArray;

@end

#endif
