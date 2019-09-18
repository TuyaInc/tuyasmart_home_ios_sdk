//
//  TuyaSmartReceiveMemberDetailModel.h
//  TuyaSmartKitExample
//
//  Created by 冯晓 on 2017/7/15.
//  Copyright © 2017年 tuya. All rights reserved.
//

@class TuyaSmartShareDeviceModel;

@interface TuyaSmartReceiveMemberDetailModel : NSObject


@property (nonatomic, strong) NSArray <TuyaSmartShareDeviceModel *> *devices;

//账号信息 邮箱或者手机号
@property (nonatomic, strong) NSString *mobile;

//用户昵称
@property (nonatomic, strong) NSString *name;

//备注
@property (nonatomic, strong) NSString *remarkName;


@end
