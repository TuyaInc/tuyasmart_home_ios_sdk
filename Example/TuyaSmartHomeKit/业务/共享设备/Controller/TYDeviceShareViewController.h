//
//  TYDeviceShareViewController.h
//  TuyaSmart
//
//  Created by 冯晓 on 16/1/7.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TPBaseViewController.h"

@interface TYDeviceShareViewController : TPBaseViewController

// 0:设备 1:群组 2:所有
//@property (nonatomic, assign) NSInteger type;
@property (nonatomic, strong) NSString *devId;

@end
