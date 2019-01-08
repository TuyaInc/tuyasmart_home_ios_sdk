//
//  TYGroupDevList.h
//  TuyaSmart
//
//  Created by 冯晓 on 15/12/15.
//  Copyright © 2015年 Tuya. All rights reserved.
//

#ifndef TuyaSmart_TuyaSmartGroupDevListModel
#define TuyaSmart_TuyaSmartGroupDevListModel

#import "TYModel.h"

@interface TuyaSmartGroupDevListModel : TYModel


/// 设备Id
@property(nonatomic,strong) NSString    *devId;

/// 设备Id
@property(nonatomic,strong) NSString    *gwId;

/// 设备是否在线
@property(nonatomic,assign) BOOL        online;

/// 设备图标url
@property(nonatomic,strong) NSString    *iconUrl;

/// 产品Id
@property(nonatomic,strong) NSString    *productId;

/// 设备是否选中
@property(nonatomic,assign) BOOL        checked;

/// 设备名字
@property(nonatomic,strong) NSString    *name;

@end

#endif

