//
//  TuyaSmartRoomModel.h
//  TuyaSmartKit
//
//  Created by 冯晓 on 2017/12/18.
//  Copyright © 2017年 Tuya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TuyaSmartRoomModel : NSObject

// room Id
@property (nonatomic, assign) long long roomId;

// room name
@property (nonatomic, strong) NSString *name;

// order
@property (nonatomic, assign) NSInteger displayOrder;


@end
