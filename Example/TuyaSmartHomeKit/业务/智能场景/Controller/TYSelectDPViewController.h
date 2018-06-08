//
//  TYSelectDPViewController.h
//  TuyaSmartPublic
//
//  Created by XuChengcheng on 16/7/6.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TPBaseTableViewController.h"

@class TuyaSmartSceneDPModel;

@interface TYSelectDPViewController : TPBaseTableViewController

@property (nonatomic, strong) TuyaSmartSceneDPModel *model;
//-1 就是新增DP  >=0 就是选择了具体的item
@property (nonatomic, assign) NSInteger selectedItem;
@property (nonatomic, assign) NSInteger row;
@property (nonatomic, assign) BOOL isCondition;

@end
