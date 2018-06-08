//
//  TYReceiveMemberDeviceListCell.h
//  TuyaSmart
//
//  Created by 冯晓 on 16/1/6.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TYReceiveMemberDeviceListDelegate <NSObject>

@required
- (void)didSettingDeviceSwitch:(UISwitch *)deviceSwitch isOn:(BOOL)isOn model:(TuyaSmartShareDeviceModel *)model;

@end

@interface TYReceiveMemberDeviceListCell : UITableViewCell

@property (nonatomic,strong) UISwitch *switchView;
@property (nonatomic, weak) id <TYReceiveMemberDeviceListDelegate> delegate;

- (void)setModel:(TuyaSmartShareDeviceModel *)model type:(NSInteger)type;

@end
