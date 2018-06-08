//
//  UITableView+TPCategory.m
//  TuyaSmartPublic
//
//  Created by 冯晓 on 2017/1/10.
//  Copyright © 2017年 Tuya. All rights reserved.
//

#import "UITableView+TPCategory.h"
#import "BlocksKit.h"
#import "MJRefresh.h"

@implementation UITableView (TPCategory)

- (void)tp_addPullToRefresh:(id)target refreshingAction:(SEL)action {
    
    
    __weak __typeof(&*target)weakTarget = target;
    
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [NSObject bk_performBlock:^{
            
            ((void (*)(id, SEL))[weakTarget methodForSelector:action])(weakTarget, action);
            
        } afterDelay:0.3];
        
        
    }];
    
//    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:target refreshingAction:action];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    header.automaticallyChangeAlpha = YES;
    
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    
    // 设置header
    self.mj_header = header;
    
}

@end
