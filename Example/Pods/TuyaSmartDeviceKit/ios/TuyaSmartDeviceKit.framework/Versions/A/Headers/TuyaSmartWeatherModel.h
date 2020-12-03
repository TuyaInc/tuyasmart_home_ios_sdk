//
//  TuyaSmartWeatherModel.h
//  Bolts
//
//  Created by 温明妍 on 2019/10/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TuyaSmartWeatherModel : NSObject

/// 天气参数图标
/// weahter icon
@property (nonatomic, copy) NSString *icon;

/// 天气参数名称
/// weather name
@property (nonatomic, copy) NSString *name;

/// 参数单位
/// weahter parameter unit
@property (nonatomic, copy) NSString *unit;

/// 参数id
/// parameter id
@property (nonatomic, assign) long long objId;

/// 是否显示，业务层未使用
/// is show . business layer has not use.
@property (nonatomic, assign) BOOL show;

/// 参数值
/// weahter parameter value
@property (nonatomic, copy) NSString *value;

@property (nonatomic, copy) NSString *metaValue;
@property (nonatomic, copy) NSString *fieldName;
@property (nonatomic, copy) NSString *roomName;

@end

NS_ASSUME_NONNULL_END
