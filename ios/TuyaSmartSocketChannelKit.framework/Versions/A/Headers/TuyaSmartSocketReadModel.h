//
//  TuyaSmartSocketReadModel.h
//  Bolts
//
//  Created by XuChengcheng on 2019/3/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TuyaSmartSocketReadModel : NSObject

@property (nonatomic, assign) int               index; // sequence number
@property (nonatomic, assign) int               type; // protocol
@property (nonatomic, assign) int               code; // success code
@property (nonatomic, strong) NSDictionary      *body; // message
@property (nonatomic, strong) NSString          *error; // error reason

// TCP data decrypt
+ (NSArray <TuyaSmartSocketReadModel *> *)tcpResponseWithData:(NSData *)data gwId:(NSString *)gwId lpv:(NSString *)lpv localKey:(NSString *)localKey;

// UDP data decrypt
+ (NSArray <TuyaSmartSocketReadModel *> *)udpResponseWithData:(NSData *)data;

@end

NS_ASSUME_NONNULL_END
