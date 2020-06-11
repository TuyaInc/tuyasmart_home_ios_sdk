//
//  TuyaSmartHomeModel.h
//  TuyaSmartKit
//
//  Created by 冯晓 on 2017/12/18.
//  Copyright © 2017年 Tuya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TuyaSmartHomeModelUtils.h"

@interface TuyaSmartHomeModel : NSObject

// home Id
@property (nonatomic, assign) long long homeId;

// home name
@property (nonatomic, strong) NSString *name;

// home geographic location
@property (nonatomic, strong) NSString *geoName;

// latitude
@property (nonatomic, assign) double latitude;

// longitude
@property (nonatomic, assign) double longitude;

// home Background Pictures
@property (nonatomic, strong) NSString *backgroundUrl;

// order
@property (nonatomic, assign) NSInteger displayOrder;

// role type
@property (nonatomic, assign) TYHomeRoleType role;

// state of deal
@property (nonatomic, assign) TYHomeStatus dealStatus;

// inviter's name
@property (nonatomic, strong) NSString *nickName;

#pragma mark - deprecated
// admin or not
@property (nonatomic, assign) BOOL admin __deprecated_msg("This property is deprecated, Use role property");

@end

