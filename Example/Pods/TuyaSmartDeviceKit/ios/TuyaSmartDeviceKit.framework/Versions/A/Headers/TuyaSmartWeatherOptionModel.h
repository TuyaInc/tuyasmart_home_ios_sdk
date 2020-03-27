//
//  TuyaSmartWeattherOptionModel.h
//  Bolts
//
//  Created by 温明妍 on 2019/10/23.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    TuyaSmartWeattherOptionPressureUnit_unknown = 0,
    TuyaSmartWeattherOptionPressureUnit_hPa = 1,
    TuyaSmartWeattherOptionPressureUnit_inHg = 2,
    TuyaSmartWeattherOptionPressureUnit_mmHg = 3,
    TuyaSmartWeattherOptionPressureUnit_mb = 4,
} TuyaSmartWeattherOptionPressureUnit;

typedef enum : NSUInteger {
    TuyaSmartWeattherOptionWindSpeedUnit_unknown = 0,
    TuyaSmartWeattherOptionWindSpeedUnit_mph = 1,
    TuyaSmartWeattherOptionWindSpeedUnit_m_s = 2,// m/s
    TuyaSmartWeattherOptionWindSpeedUnit_kph = 3,
    TuyaSmartWeattherOptionWindSpeedUnit_km_h = 4// km/h
} TuyaSmartWeattherOptionWindSpeedUnit;

typedef enum : NSUInteger {
    TuyaSmartWeattherOptionTemperatureUnit_unknown = 0,
    TuyaSmartWeattherOptionTemperatureUnit_Centigrade = 1,// ℃
    TuyaSmartWeattherOptionTemperatureUnit_Fahrenheit = 2,// ℉
} TuyaSmartWeattherOptionTemperatureUnit;

NS_ASSUME_NONNULL_BEGIN

/**
 * 获取家庭天气请求入参
 */
@interface TuyaSmartWeatherOptionModel : NSObject

/// 气压单位
@property (nonatomic, assign) TuyaSmartWeattherOptionPressureUnit pressureUnit;

/// 风速单位
@property (nonatomic, assign) TuyaSmartWeattherOptionWindSpeedUnit windspeedUnit;

/// 温度单位
@property (nonatomic, assign) TuyaSmartWeattherOptionTemperatureUnit temperatureUnit;

/// 请求多少个天气详情，若不配置，则默认全部返回
@property (nonatomic, assign) NSInteger limit;

@end

NS_ASSUME_NONNULL_END
