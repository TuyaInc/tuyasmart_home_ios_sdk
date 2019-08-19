//
//  TYWidgetDeviceCell.h
//  TuyaWidget
//
//  Created by lan on 2018/9/11.
//  Copyright © 2018年 Tuya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TYWidgetDeviceModel.h"
#import "TYTodayViewController.h"

@interface TYWidgetDeviceCell : UICollectionViewCell
@property (nonatomic, strong) TYWidgetDeviceModel *model;
- (void)switchStatus;
@end
