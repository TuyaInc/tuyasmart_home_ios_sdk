//
//  TYSmartSceneTableViewCell.h
//  TuyaSmartPublic
//
//  Created by XuChengcheng on 16/7/4.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TuyaSmartSceneModel;

@interface TYDemoSmartSceneTableViewCell : UITableViewCell

@property (nonatomic, strong) UIButton *executeButton;
@property (nonatomic, strong) TuyaSmartSceneModel *model;

@end
