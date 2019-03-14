//
//  TuyaSmartRoomModel.h
//  TuyaSmartKit
//
//  Created by 冯晓 on 2017/12/18.
//  Copyright © 2017年 Tuya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TuyaSmartRoomModel : NSObject

// 房间Id
@property (nonatomic, assign) long long roomId;

// 房间名称
@property (nonatomic, strong) NSString *name;

// 排序
@property (nonatomic, assign) NSInteger displayOrder;


@end
