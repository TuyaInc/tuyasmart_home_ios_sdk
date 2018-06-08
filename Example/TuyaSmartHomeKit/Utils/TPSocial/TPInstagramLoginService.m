//
//  TPInstagramLoginService.m
//  TuyaSmartPublic
//
//  Created by 冯晓 on 16/3/10.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TPInstagramLoginService.h"
#import "TPInstagramLoginViewController.h"
#import "InstagramEngine.h"

@interface TPInstagramLoginService() <TPInstagramLoginViewControllerDelegate>


@end

@implementation TPInstagramLoginService

TP_DEF_SINGLETON(TPInstagramLoginService)


- (void)startLoginService:(TPSocialSuccess)success failure:(TPFailureError)failure {
    [super startLoginService:success failure:failure];
    
    
    [[InstagramEngine sharedEngine] logout];
    
    TPInstagramLoginViewController *vc = [[TPInstagramLoginViewController alloc] init];
    vc.delegate = self;
    [tp_topMostViewController() presentViewController:vc animated:YES completion:^{
        
    }];
}


- (void)didSuccessLogin:(TPInstagramLoginViewController *)vc accessToken:(NSString *)accessToken {
    [vc dismissViewControllerAnimated:YES completion:NULL];
    
    if (self.success) {
        NSDictionary *item = @{@"accessToken":accessToken,@"type":@(TPSocialInstagram)};
        self.success([TPSocialLoginModel modelWithJSON:item]);
    }
}


@end
