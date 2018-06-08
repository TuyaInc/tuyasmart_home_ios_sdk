//
//  TYAddSceneViewController.h
//  TuyaSmartPublic
//
//  Created by XuChengcheng on 16/7/5.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TPBaseTableViewController.h"

@class TuyaSmartSceneModel;

@interface TYAddSceneViewController : TPBaseTableViewController

@property (nonatomic, assign) BOOL isAdd;
@property (nonatomic, strong) TuyaSmartSceneModel *model;

@end
