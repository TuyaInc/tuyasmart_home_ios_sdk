//
//  TuyaSmartMQTTConfigModel.h
//  Bolts
//
//  Created by XuChengcheng on 2019/3/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TuyaSmartMQTTConfigModel : NSObject

@property (nonatomic, strong) NSString *clientId;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *password;

@property (nonatomic, strong) NSString *mbHost;
@property (nonatomic, assign) int port;
@property (nonatomic, assign) BOOL useSSL;

@property (nonatomic, strong) NSString *quicHost;
@property (nonatomic, assign) int quicPort;
@property (nonatomic, assign) BOOL useQUIC;

@end

NS_ASSUME_NONNULL_END
