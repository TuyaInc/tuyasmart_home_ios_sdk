//
//  TuyaSmartShareMemberDetailModel.h
//  TuyaSmartKitExample
//
//  Created by 冯晓 on 2017/7/15.
//  Copyright © 2017年 tuya. All rights reserved.
//

@class TuyaSmartShareDeviceModel;

@interface TuyaSmartShareMemberDetailModel : NSObject

/**
 deviceModel list
 */
@property (nonatomic, strong) NSArray <TuyaSmartShareDeviceModel *> *devices;

/**
 mobile
 */
@property (nonatomic, strong) NSString *mobile;

/**
 name
 */
@property (nonatomic, strong) NSString *name;

/**
 remark name
 */
@property (nonatomic, strong) NSString *remarkName;

/**
 auto sharing
 */
@property (nonatomic, assign) BOOL autoSharing;


@end
