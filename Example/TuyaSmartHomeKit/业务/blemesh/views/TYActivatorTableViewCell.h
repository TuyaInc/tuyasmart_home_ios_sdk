//
//  TYActivatorTableViewCell.h
//  TuyaSmartPublic
//
//  Created by XuChengcheng on 16/9/21.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TYBaseTableViewCell.h"

@interface TYActivatorTableViewCell : TYBaseTableViewCell

@property (nonatomic, strong) UIButton *renameButton;

- (void)setDeviceModel:(TuyaSmartDeviceModel *)deviceModel error:(NSError *)error;

@end
