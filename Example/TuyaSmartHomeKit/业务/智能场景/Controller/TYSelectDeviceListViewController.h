//
//  TYSelectDeviceListViewController.h
//  TuyaSmartPublic
//
//  Created by XuChengcheng on 16/7/6.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TPBaseTableViewController.h"

@interface TYSelectDeviceListViewController : TPBaseTableViewController

@property (nonatomic, assign) BOOL isCondition;
@property (nonnull, strong) NSArray *selectDevList;

@end
