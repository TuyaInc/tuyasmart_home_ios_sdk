//
//  TuyaSmartLanMessageModel.h
//  CocoaAsyncSocket
//
//  Created by XuChengcheng on 2020/8/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TuyaSmartLanMessageModel : NSObject

/**
 protocol
 */
@property (nonatomic, assign) NSInteger    protocol;

/**
 devId
 */
@property (nonatomic, strong) NSString     *devId;


@property (nonatomic, strong) NSDictionary *body;


@property (nonatomic, strong) NSData       *data;


@end

NS_ASSUME_NONNULL_END
