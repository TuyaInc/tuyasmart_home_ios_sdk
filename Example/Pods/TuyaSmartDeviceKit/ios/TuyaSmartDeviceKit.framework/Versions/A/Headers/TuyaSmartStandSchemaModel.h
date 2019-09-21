//
//  TuyaSmartStandSchemaModel.h
//  TuyaSmartDeviceKit-iOS
//
//  Created by 黄凯 on 2019/8/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TuyaSmartStatusSchemaModel : NSObject

@property (nonatomic, strong) NSString     *strategyValue;
@property (nonatomic, strong) NSString     *strategyCode;
@property (nonatomic, strong) NSString     *dpCode;
@property (nonatomic, strong) NSString     *standardType;


@end

@interface TuyaSmartFunctionSchemaModel : NSObject

@property (nonatomic, strong) NSString     *strategyCode;
@property (nonatomic, strong) NSString     *strategyValue;
@property (nonatomic, strong) NSString     *standardCode;
@property (nonatomic, strong) NSString     *standardType;

@end


@interface TuyaSmartStandSchemaModel : NSObject

@property (nonatomic, assign) BOOL isProductCompatibled;

@property (nonatomic, strong) NSArray<TuyaSmartStatusSchemaModel *> *statusSchemaList;

@property (nonatomic, strong) NSArray<TuyaSmartFunctionSchemaModel *> *functionSchemaList;

@end

NS_ASSUME_NONNULL_END
