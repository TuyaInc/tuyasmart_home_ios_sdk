//
//  AddNewMemberViewController.h
//  TuyaSmart
//
//  Created by fengyu on 15/3/10.
//  Copyright (c) 2015年 Tuya. All rights reserved.
//

#import "TPBaseViewController.h"

@interface AddNewMemberViewController : TPBaseViewController


// 0 设备共享  1 所有
@property (nonatomic, assign) NSInteger type;

@property (nonatomic, strong) NSArray *shareDeviceIds;
@property (nonatomic, assign) BOOL isAutoShare;

@end
