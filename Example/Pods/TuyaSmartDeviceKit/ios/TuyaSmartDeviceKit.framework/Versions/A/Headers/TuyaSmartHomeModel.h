//
//  TuyaSmartHomeModel.h
//  TuyaSmartKit
//
//  Created by 冯晓 on 2017/12/18.
//  Copyright © 2017年 Tuya. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, TYHomeStatus) {
    TYHomeStatusPending = 1,
    TYHomeStatusAccept,
    TYHomeStatusReject
};

@interface TuyaSmartHomeModel : NSObject

// 家庭Id
@property (nonatomic, assign) long long homeId;

// 家庭名称
@property (nonatomic, strong) NSString *name;

// 家庭地理位置
@property (nonatomic, strong) NSString *geoName;

// 纬度
@property (nonatomic, assign) double latitude;

// 经度
@property (nonatomic, assign) double longitude;

// 家庭背景图
@property (nonatomic, strong) NSString *backgroundUrl;

// 排序
@property (nonatomic, assign) NSInteger displayOrder;

// 是否是家庭管理员
@property (nonatomic, assign) BOOL admin;

// 处理状态
@property (nonatomic, assign) TYHomeStatus dealStatus;

// 邀请人名称
@property (nonatomic, strong) NSString *nickName;

@end

