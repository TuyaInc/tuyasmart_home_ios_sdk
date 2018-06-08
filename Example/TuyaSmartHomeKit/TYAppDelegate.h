//
//  TYAppDelegate.h
//  TuyaSmartHomeKit
//
//  Created by xuchengcheng on 06/07/2018.
//  Copyright (c) 2018 xuchengcheng. All rights reserved.
//

@import UIKit;

@interface TYAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

- (void)signOut;
- (void)resetRootViewController:(Class)rootController;

@end
