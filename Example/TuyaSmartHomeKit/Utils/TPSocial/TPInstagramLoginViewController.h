//
//  TPInstagramLoginViewController.h
//  TuyaSmartPublic
//
//  Created by 冯晓 on 16/3/10.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TPSocialGlobal.h"

@class TPInstagramLoginViewController;

@protocol TPInstagramLoginViewControllerDelegate <NSObject>


@optional
- (void)didSuccessLogin:(TPInstagramLoginViewController *)vc accessToken:(NSString *)accessToken;

- (void)didFailLogin;

@end

@interface TPInstagramLoginViewController : UIViewController



@property (nonatomic, weak) id <TPInstagramLoginViewControllerDelegate> delegate;


@end
