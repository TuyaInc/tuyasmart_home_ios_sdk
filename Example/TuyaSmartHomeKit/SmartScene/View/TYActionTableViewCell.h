//
//  TYActionTableViewCell.h
//  TuyaSmartPublic
//
//  Created by XuChengcheng on 16/7/25.
//  Copyright © 2016年 Tuya. All rights reserved.
//


@class TuyaSmartSceneActionModel;

@interface TYActionTableViewCell : UITableViewCell

@property (nonatomic, strong) TuyaSmartSceneActionModel *model;
@property (nonatomic, strong) UIImageView *iconImageView;

@end
