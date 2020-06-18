//
//  TYDemoRouteManager.m
//  BlocksKit
//
//  Created by huangkai on 2020/6/2.
//

#import "TYDemoRouteManager.h"

#define TYModuleWarning(msg) NSLog(@"%@", [@"TYRouteModule_Warning ⚠️" stringByAppendingString:msg])

static NSString * const kTYModuleRouteFakeScheme = @"kTYModuleRouteFakeScheme";

@implementation NSString (TYRoute)

- (NSString *)ty_routeUrlEncode {
    NSMutableString *output = [NSMutableString string];
    const unsigned char *source = (const unsigned char *)[self UTF8String];
    unsigned long sourceLen = strlen((const char *)source);
    for (int i = 0; i < sourceLen; ++i) {
        const unsigned char thisChar = source[i];
        if (thisChar == '.' || thisChar == '-' || thisChar == '_' || thisChar == '~' ||
                   (thisChar >= 'a' && thisChar <= 'z') ||
                   (thisChar >= 'A' && thisChar <= 'Z') ||
                   (thisChar >= '0' && thisChar <= '9')) {
            [output appendFormat:@"%c", thisChar];
        } else {
            [output appendFormat:@"%%%02X", thisChar];
        }
    }
    return output;
}

@end

@implementation NSURL (TYRoute)

+ (NSURL *)ty_URLWithRoute:(NSString *)route {
    if (![route isKindOfClass:[NSString class]] || route.length == 0) {
        return nil;
    }

    NSRange queryRange = [route rangeOfString:@"?"];
    if (queryRange.location != NSNotFound && queryRange.length > 0) {
        // 对参数进行 url encode
        NSMutableString *str = [NSMutableString stringWithString:[route substringToIndex:queryRange.location]];
        NSDictionary<NSString *, NSString *> *query = [self _ty_dictionaryFromRouteQuery:[route substringFromIndex:queryRange.location + 1]];
        NSArray<NSString *> *keyArr = [query allKeys];
        for (NSInteger idx = 0; idx < keyArr.count; idx ++) {
            [str appendString:(idx == 0 ? @"?" : @"&")];
            NSString *key = keyArr[idx];
            NSString *value = [[query valueForKey:key] ty_routeUrlEncode];
            [str appendFormat:@"%@=%@", key, value];
        }
        route = str;
    }
    
    // 根据情况拼接fakeScheme，帮助url解析
    NSRange schemeRange = [route rangeOfString:@"://"];
    if (schemeRange.length == 0 || (queryRange.length > 0 && schemeRange.location > queryRange.location)) {
        route = [kTYModuleRouteFakeScheme stringByAppendingFormat:@"://%@", route];
    } else if (schemeRange.location == 0) {
        route = [kTYModuleRouteFakeScheme stringByAppendingString:route];
    }
    
    return [NSURL URLWithString:route];
}

+ (NSDictionary *)_ty_dictionaryFromRouteQuery:(NSString *)query {
    if (![query isKindOfClass:[NSString class]] || query.length == 0) {
        return nil;
    }
    NSCharacterSet *delimiterSet = [NSCharacterSet characterSetWithCharactersInString:@"&;"];
    NSMutableDictionary *pairs = [NSMutableDictionary dictionary];
    NSScanner *scanner = [[NSScanner alloc] initWithString:query];
    while (![scanner isAtEnd]) {
        NSString *pairString = nil;
        [scanner scanUpToCharactersFromSet:delimiterSet intoString:&pairString];
        [scanner scanCharactersFromSet:delimiterSet intoString:NULL];
        NSArray *kvPair = [pairString componentsSeparatedByString:@"="];
        if (kvPair.count == 2) {
            NSString *key = [[kvPair objectAtIndex:0]
                             stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSString *value = [[kvPair objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [pairs setObject:value forKey:key];
        }
    }
    
    return [pairs copy];
}

@end

@interface TYDemoRouteManager ()

// route-module映射   key: host   value: module
@property (nonatomic, strong) NSMapTable<NSString *, id> *routeMapping;

@end

@implementation TYDemoRouteManager

+ (instancetype)sharedInstance {
    static TYDemoRouteManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [TYDemoRouteManager new];
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _routeMapping = [NSMapTable strongToWeakObjectsMapTable];
    }
    return self;
}

- (void)registRoute:(NSString *)route forModule:(nonnull id)module {
    NSURL *url = [NSURL ty_URLWithRoute:route];
    NSString *host = [url.host lowercaseString];
    if (!module || !host) {
        return;
    }

    if ([_routeMapping objectForKey:host] != nil) {
        NSString *msg = [NSString stringWithFormat:@"route for (%@) already exist", route];
        TYModuleWarning(msg);
        return;
    } else {
        [_routeMapping setObject:module forKey:host];
    }
}

- (void)unregistRoute:(NSString *)route; {
    NSURL *url = [NSURL ty_URLWithRoute:route];
    if (!url) {
        return;
    }
    NSString *host = [url.host lowercaseString];
    [self.routeMapping removeObjectForKey:host];
}

- (id)moduleOfRoute:(NSString *)route {
    NSURL *url = [NSURL ty_URLWithRoute:route];
    return url ? [self.routeMapping objectForKey:[url.host lowercaseString]] : nil;
}

- (BOOL)canOpenRoute:(NSString *)route {
    return [self moduleOfRoute:route] != nil;
}

- (BOOL)openRoute:(NSString *)urlStr withParams:(nullable NSDictionary *)userInfo {
    if (!([urlStr isKindOfClass:[NSString class]] && urlStr.length > 0)) {
        return NO;
    }
    
    NSURL *targetUrl = [NSURL ty_URLWithRoute:urlStr];
    if (!targetUrl) {
        return NO;
    }
    NSString *scheme = [targetUrl.scheme stringByRemovingPercentEncoding];
    NSString *host = [targetUrl.host stringByRemovingPercentEncoding];
    NSString *path = [targetUrl.path stringByRemovingPercentEncoding];
    NSString *query = targetUrl.query;
    
    NSDictionary *dic = [TYDemoRouteManager dictionaryFromQuery:query];
    NSMutableDictionary *queryDic = [NSMutableDictionary new];
    if ([dic isKindOfClass:[NSDictionary class]] && dic.count > 0) {
        [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            NSString *value = [obj stringByRemovingPercentEncoding];
            [queryDic setValue:value forKey:key];
        }];
    }
    
    if ([[scheme lowercaseString] isEqualToString:@"https"] || [[scheme lowercaseString] isEqualToString:@"http"]) {
        NSMutableDictionary *params = userInfo ? userInfo.mutableCopy : @{}.mutableCopy;
        params[@"url"] = targetUrl.absoluteString;
        return [self openRoute:@"tuyaweb" withParams:params.copy];
    } else {
        return [self openRouteWithScheme:[[scheme lowercaseString] isEqualToString:[kTYModuleRouteFakeScheme lowercaseString]] ? nil : scheme host:host path:path queryParams:queryDic params:userInfo];
    }
}

- (BOOL)openRouteWithScheme:(NSString *)scheme host:(NSString *)host path:(NSString *)path queryParams:(NSDictionary *)queryDic params:(NSDictionary *)userInfo {
    id impl = [self moduleOfRoute:host];
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params setValuesForKeysWithDictionary:queryDic];
    [params setValuesForKeysWithDictionary:userInfo];
    if ([impl respondsToSelector:@selector(handleRouteWithScheme:host:path:params:)]) {
        return [impl handleRouteWithScheme:scheme host:host path:path params:params];
    } else {
        return NO;
    }
}

+ (NSDictionary *)dictionaryFromQuery:(NSString *)query {
    return [self dictionaryFromQuery:query usingEncoding:NSUTF8StringEncoding];
}

+ (NSDictionary *)dictionaryFromQuery:(NSString *)query usingEncoding:(NSStringEncoding)encoding {
    if (!([query isKindOfClass:[NSString class]] && query.length > 0)) {
        return nil;
    }
    NSCharacterSet *delimiterSet = [NSCharacterSet characterSetWithCharactersInString:@"&;"];
    NSMutableDictionary* pairs = [NSMutableDictionary dictionary];
    NSScanner* scanner = [[NSScanner alloc] initWithString:query];
    while (![scanner isAtEnd]) {
        NSString* pairString = nil;
        [scanner scanUpToCharactersFromSet:delimiterSet intoString:&pairString];
        [scanner scanCharactersFromSet:delimiterSet intoString:NULL];
        NSArray* kvPair = [pairString componentsSeparatedByString:@"="];
        if (kvPair.count == 2) {
            NSString* key = [[kvPair objectAtIndex:0]
                             stringByReplacingPercentEscapesUsingEncoding:encoding];
            NSString* value = [[kvPair objectAtIndex:1]
                               stringByReplacingPercentEscapesUsingEncoding:encoding];
            [pairs setObject:value forKey:key];
        }
    }
    
    return [NSDictionary dictionaryWithDictionary:pairs];
}


@end
