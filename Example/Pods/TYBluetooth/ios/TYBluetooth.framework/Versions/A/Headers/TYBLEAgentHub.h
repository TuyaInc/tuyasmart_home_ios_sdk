//
//  TYBLEAgentHub.h
//  Pods
//
//  Created by 黄凯 on 2019/6/5.
//

#import <Foundation/Foundation.h>

CB_EXTERN NSString * _Nonnull const TY_BLE_AGENT_SIGEL_BLE;
CB_EXTERN NSString * _Nonnull const TY_BLE_AGENT_BLE_MESH;
CB_EXTERN NSString * _Nonnull const TY_BLE_AGENT_SIG_MESH;

NS_ASSUME_NONNULL_BEGIN

@class TYBLEAgent;
@interface TYBLEAgentHub : NSObject

+ (TYBLEAgent *)getAgentWithAgentKey:(NSString *)AgentKey;

@end

NS_ASSUME_NONNULL_END
