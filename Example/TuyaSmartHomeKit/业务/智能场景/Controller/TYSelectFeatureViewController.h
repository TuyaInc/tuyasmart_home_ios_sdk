//
//  TYSelectFeatureViewController.h
//  TuyaSmartPublic
//
//  Created by XuChengcheng on 16/7/6.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TPBaseTableViewController.h"

@interface TYSelectFeatureViewController : TPBaseTableViewController

@property (nonatomic, strong) NSString *entityId;
@property (nonatomic, strong) NSDictionary *actDic;
@property (nonatomic, assign) NSInteger selectedItem;
@property (nonatomic, assign) BOOL isCondition;
@property (nonatomic, strong) NSArray *expr;

@end
