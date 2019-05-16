//
//  TuyaSmartShareMemberDetailModel.h
//  TuyaSmartKitExample
//
//  Created by 冯晓 on 2017/7/15.
//  Copyright © 2017年 tuya. All rights reserved.
//

@class TuyaSmartShareDeviceModel;

@interface TuyaSmartShareMemberDetailModel : NSObject

@property (nonatomic, strong) NSArray <TuyaSmartShareDeviceModel *> *devices;

@property (nonatomic, strong) NSString *mobile;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *remarkName;

@property (nonatomic, assign) BOOL autoSharing;


@end
