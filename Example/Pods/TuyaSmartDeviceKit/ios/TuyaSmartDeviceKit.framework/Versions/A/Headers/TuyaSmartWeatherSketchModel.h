//
//  TuyaSmartWeatherSketchModel.h
//  Bolts
//
//  Created by 温明妍 on 2019/10/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TuyaSmartWeatherSketchModel : NSObject

/// 天气情况，比如晴，阴，雨等
/// weather description. Sunny,cloudy and so on.
@property (nonatomic, strong) NSString *condition;

/// 天气图标，默认使用该图标
/// weather icon, default use iconUrl
@property (nonatomic, strong) NSString *iconUrl;

/// 天气图标 ，iconUrl高亮显示
///weather icon, hightlight
@property (nonatomic, strong) NSString *inIconUrl;

/// 兼容旧版本参数。业务层未使用
/// Compatible with older version parameters.business layer has not use yet.
@property (nonatomic, strong) NSString *city;

/// 天气情况，比如晴，阴，雨等属性值，如晴为”Sunny“，阴为”Cloudy“。业务层暂未使用。
/// weather description attribute. business layer has not use yet
@property (nonatomic, strong) NSString *mark;

/// 温度
/// temperature
@property (nonatomic, strong) NSString *temp;

@end

NS_ASSUME_NONNULL_END
