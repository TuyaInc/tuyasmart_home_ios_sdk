//
//  TuyaSmartDeviceShareModel.h
//  TuyaSmartDeviceKit
//
//  Created by Hemin Won on 2020/7/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TuyaSmartDeviceShareRequestModel : NSObject

/// 家庭ID home id
@property (nonatomic, assign) long long homeID;

/// 国家码 country code
@property (nonatomic, copy) NSString *countryCode;

/// 账号 account
@property (nonatomic, copy) NSString *userAccount;

/// 设备ID列表 device id list
@property (nonatomic, copy) NSArray<NSString *> *devIds;

@end

NS_ASSUME_NONNULL_END
