

#if TARGET_OS_IOS
#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>


/** 
 * Create NS_ENUM macro if it does not exist on the targeted version of iOS or OS X.
 *
 * @see http://nshipster.com/ns_enum-ns_options/
 **/
#ifndef NS_ENUM
#define NS_ENUM(_type, _name) enum _name : _type _name; enum _name : _type
#endif

extern NSString *const kTuyaSmartReachabilityChangedNotification;

typedef NS_ENUM(NSInteger, TYSDKNetworkStatus) {
    // Apple NetworkStatus Compatible Names.
    TYSDKNotReachable = 0,
    TYSDKReachableViaWiFi = 2,
    TYSDKReachableViaWWAN = 1
};

@class TuyaSmartReachability;

typedef void (^TuyaSmartNetworkReachable)(TuyaSmartReachability * reachability);
typedef void (^TuyaSmartNetworkUnreachable)(TuyaSmartReachability * reachability);


@interface TuyaSmartReachability : NSObject

@property (nonatomic, copy) TuyaSmartNetworkReachable    reachableBlock;
@property (nonatomic, copy) TuyaSmartNetworkUnreachable  unreachableBlock;

@property (nonatomic, assign) BOOL reachableOnWWAN;


+(TuyaSmartReachability*)reachabilityWithHostname:(NSString*)hostname;
// This is identical to the function above, but is here to maintain
//compatibility with Apples original code. (see .m)
+(TuyaSmartReachability*)reachabilityWithHostName:(NSString*)hostname;
+(TuyaSmartReachability*)reachabilityForInternetConnection;
+(TuyaSmartReachability*)reachabilityWithAddress:(void *)hostAddress;
+(TuyaSmartReachability*)reachabilityForLocalWiFi;

-(TuyaSmartReachability *)initWithReachabilityRef:(SCNetworkReachabilityRef)ref;

-(BOOL)startNotifier;
-(void)stopNotifier;

-(BOOL)isReachable;
-(BOOL)isReachableViaWWAN;
-(BOOL)isReachableViaWiFi;

// WWAN may be available, but not active until a connection has been established.
// WiFi may require a connection for VPN on Demand.
-(BOOL)isConnectionRequired; // Identical DDG variant.
-(BOOL)connectionRequired; // Apple's routine.
// Dynamic, on demand connection?
-(BOOL)isConnectionOnDemand;
// Is user intervention required?
-(BOOL)isInterventionRequired;

-(TYSDKNetworkStatus)currentReachabilityStatus;
-(SCNetworkReachabilityFlags)reachabilityFlags;
-(NSString*)currentReachabilityString;
-(NSString*)currentReachabilityFlags;

@end

#endif
