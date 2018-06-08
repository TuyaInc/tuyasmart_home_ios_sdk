//
//  UITableView+TPCategory.h
//  TuyaSmartPublic
//
//  Created by 冯晓 on 2017/1/10.
//  Copyright © 2017年 Tuya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (TPCategory)

- (void)tp_addPullToRefresh:(id)target refreshingAction:(SEL)action;


@end
