//
//  TuyaSmartMQTTMessageModel.h
//  TuyaSmartDeviceKit
//
//  Created by 高森 on 2019/1/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TuyaSmartMQTTMessageModel : NSObject

@property (nonatomic, assign) NSInteger    protocol;
@property (nonatomic, strong) NSString     *type;
@property (nonatomic, strong) id           data;
@property (nonatomic, strong) NSString     *devId;

@end

NS_ASSUME_NONNULL_END
