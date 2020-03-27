//
//  TuyaSmartHTTPDNS.h
//  TuyaSmartBaseKit
//
//  Created by 黄凯 on 2019/9/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TuyaSmartHTTPDNS : NSObject

+ (instancetype)sharedInstance;

/**
 * 异步解析接口，首先查询缓存，若存在则返回结果，若不存在返回 nil 并且进行异步域名解析更新缓存
 *
 * @param host 域名(如www.tuya.com)
 * @return 域名对应的解析结果
 */
- (NSString *)getIpWithHost:(NSString *)host;

/**
设置域名是否进行降级

@param host 域名
@param enable 是否降级
*/
- (void)setDegradationWithHost:(NSString *)host enable:(BOOL)enable;

@end

NS_ASSUME_NONNULL_END
