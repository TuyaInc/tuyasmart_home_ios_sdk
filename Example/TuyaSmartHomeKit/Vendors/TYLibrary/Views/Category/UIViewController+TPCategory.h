//
//  UIViewController+ATCategory.h
//  Airtake
//
//  Created by fisher on 14/11/10.
//  Copyright (c) 2014年 hanbolong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (TPCategory)

- (void)tp_dismissModalViewController;

- (BOOL)tp_isModal;

- (void)tp_dismissCurrentPresentedControllerAnimated:(BOOL)animated completion:(void (^)(void))completion;

- (UIViewController *)tp_currentPresentedController;

- (UIViewController *)tp_currentPresentingController;
@end
