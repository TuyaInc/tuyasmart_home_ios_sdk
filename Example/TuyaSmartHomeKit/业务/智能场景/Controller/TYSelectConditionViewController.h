//
//  TYSelectConditionViewController.h
//  TuyaSmartPublic
//
//  Created by 冯晓 on 2016/11/2.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TPBaseTableViewController.h"

@class TuyaSmartSceneConditionModel;

@interface TYSelectConditionViewController : TPBaseTableViewController

@property (nonatomic, strong) NSArray *selectDevList;
@property (nonatomic, strong) TuyaSmartSceneConditionModel *model;

@end
