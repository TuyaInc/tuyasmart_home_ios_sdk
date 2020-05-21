//
//  UIViewController+ATCategory.m
//  Airtake
//
//  Created by fisher on 14/11/10.
//  Copyright (c) 2014年 hanbolong. All rights reserved.
//

#import "UIViewController+TPCategory.h"
#import "TPViewConstants.h"

@implementation UIViewController (TPCategory)


- (void)tp_dismissModalViewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)tp_isModal {
    if ([self presentingViewController])
        return YES;
    if ([[[self navigationController] presentingViewController] presentedViewController] == [self navigationController])
        return YES;
    if ([[[self tabBarController] presentingViewController] isKindOfClass:[UITabBarController class]])
        return YES;
    
    return NO;
}



- (void)tp_dismissCurrentPresentedControllerAnimated:(BOOL)animated completion:(void (^)(void))completion {
    if (self.presentedViewController) {
        [self dismissViewControllerAnimated:animated completion:completion];
    } else {
        if (completion) {
            completion();
        }
    }
}

- (UIViewController *)tp_currentPresentedController {
    return self.presentedViewController;
}


- (UIViewController *)tp_currentPresentingController {
    return self.presentingViewController;
}


@end
