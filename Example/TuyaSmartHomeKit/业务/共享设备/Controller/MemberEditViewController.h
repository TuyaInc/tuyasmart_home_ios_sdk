//
//  MemberEditViewController.h
//  TuyaSmart
//
//  Created by fengyu on 15/3/10.
//  Copyright (c) 2015年 Tuya. All rights reserved.
//

#import "TPBaseViewController.h"

typedef void (^UpdateAutoShareSwitchBlock)(BOOL isAuto);

@interface MemberEditViewController : TPBaseViewController

@property (nonatomic, strong) TuyaSmartShareMemberModel *member;
@property (nonatomic, strong) NSArray *receiveDeviceList;
@property (nonatomic, strong) NSArray *shareDeviceList;
@property (nonatomic, assign) BOOL isAutoShare;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, copy) UpdateAutoShareSwitchBlock updateAutoShareSwitchBlock;

@end
