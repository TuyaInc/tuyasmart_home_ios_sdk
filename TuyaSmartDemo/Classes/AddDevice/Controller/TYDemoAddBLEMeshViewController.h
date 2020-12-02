//
//  TYAddBLEMeshViewController.h
//  TuyaSmartHomeKit_Example
//
//  Created by milong on 2020/7/21.
//  Copyright © 2020 xuchengcheng. All rights reserved.
//

#import "TPDemoBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^TYMessageHandlerBlock)(void);

@interface TYAlertMessgeView : UIView

- (void)showTtile:(NSString *)title Message:(NSString *)message
       completeBlock:(TYMessageHandlerBlock)completeBlock
         cancelBlock:(TYMessageHandlerBlock)cancelBlock;

- (void)updateMessage:(NSString *)message ;

@end

@interface TYDemoAddBLEMeshViewController : TPDemoBaseViewController

@end

NS_ASSUME_NONNULL_END
