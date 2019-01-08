//
//  TuyaSmartBleMeshModel.h
//  TuyaSmartKit
//
//  Created by XuChengcheng on 2017/6/7.
//  Copyright © 2017年 Tuya. All rights reserved.
//

#ifndef TuyaSmart_TuyaSmartBleMeshModel
#define TuyaSmart_TuyaSmartBleMeshModel

#import <Foundation/Foundation.h>

@interface TuyaSmartBleMeshModel : NSObject

//mesh网络名称
@property (nonatomic, strong) NSString     *name;

//mesh网络云端标识
@property (nonatomic, strong) NSString     *meshId;

//localKey
@property (nonatomic, strong) NSString     *localKey;

//pv
@property (nonatomic, strong) NSString     *pv;

@property (nonatomic, strong) NSString     *code;

@property (nonatomic, strong) NSString     *password;

@property (nonatomic, assign) BOOL         share;

@property (nonatomic, assign) long long    homeId;

@end

#endif
