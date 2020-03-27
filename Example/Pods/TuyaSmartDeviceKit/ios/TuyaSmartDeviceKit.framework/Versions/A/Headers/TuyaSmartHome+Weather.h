//
//  TuyaSmartHome+Weather.h
//  TuyaSmartDeviceKit
//
//  Created by 温明妍 on 2019/10/23.
//

#import "TuyaSmartHome.h"

@class TuyaSmartWeatherModel;
@class TuyaSmartWeatherSketchModel;
@class TuyaSmartWeatherOptionModel;

@interface TuyaSmartHome (Weather)

/**
 *  home location
 *  家庭地理位置
 */
- (NSString *)geoName;

/**
 * get home weather simple summary parameters.
 * Sush as city name, state of weather(clear, cloudy, rainy, and so on),weather icon.
 * 获取家庭天气简要参数。该请求返回家庭所在城市的简要天气参数，如城市名称、当天的天气状况(晴、多云、雨等)、天气图片信息。
 * @param success request successful callback
 *               请求成功回调
 * @param failure request failed callback
 *               请求失败回调
 */
- (void)getHomeWeatherSketchWithSuccess:(void(^)(TuyaSmartWeatherSketchModel *))success
                                failure:(TYFailureError)failure;

/**
 * get home weather summary parameters.
 * Such as tempature, humidity, ultraviolet index, air quality.
 * 获取家庭天气详细参数,如温度、湿度、紫外线指数、空气质量等
 * @param optionModel weather details unit configuration
 *                   天气详情参数单位配置
 * @discussion <p>optionModel can be nil.If nil, request would made using last request which is successful callback.
 *             If optionModel using only one confiuration, the other two configuration would use last successful request.</p>
 *             <p>Different areas  are use different weather services.
 *             Particularly, if location of current home account is in China, server would not return wind speed and pressure.</p>
 *             <p>optionModel 可以为nil。若为nil，返回的参数会上一次请求成功的参数设置，若只改变一种单位设置进行请求，另外两种也依然会保留上一次请求成功的参数设置。</p>
 *             <p>由于天气服务在不同地区的使用的服务不同，不同地区返回的参数有可能不同。
 *             特别的，如果当前家庭账号位置在中国，那么不会返回风速和气压信息。</p>
 *
 * @param success request successful callback
 *               请求成功回调
 * @param failure request failed callback
 *               请求失败回调
 */
- (void)getHomeWeatherDetailWithOption:(TuyaSmartWeatherOptionModel *)optionModel
                         success:(void(^)(NSArray<TuyaSmartWeatherModel *> *))success
                         failure:(TYFailureError)failure;

@end
