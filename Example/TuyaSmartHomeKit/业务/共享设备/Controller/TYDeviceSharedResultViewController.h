//
//  TYDeviceSharedResultViewController.h
//  TuyaSmartPublic
//
//  Created by XuChengcheng on 2017/5/15.
//  Copyright © 2017年 Tuya. All rights reserved.
//

#import "TPBaseViewController.h"

@class TuyaSmartShareMemberModel;

@interface TYDeviceSharedResultViewController : TPBaseViewController

@property (nonatomic, assign) BOOL isSuccess;
@property (nonatomic, strong) NSString *errorInfo;
@property (nonatomic, assign) BOOL isPresent;
@property (nonatomic, strong) TuyaSmartShareMemberModel *member;


@end
