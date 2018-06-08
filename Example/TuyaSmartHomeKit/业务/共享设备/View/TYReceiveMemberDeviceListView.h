//
//  TYReceiveMemberDeviceListView.h
//  TuyaSmart
//
//  Created by 冯晓 on 16/1/6.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TYReceiveMemberDeviceListCell.h"

@interface TYReceiveMemberDeviceListView : UIView

@property (nonatomic, weak) id <TYReceiveMemberDeviceListDelegate> delegate;
@property (nonatomic, strong) UITableView *tableView;

- (instancetype)initWithFrame:(CGRect)frame deviceList:(NSArray *)deviceList type:(NSInteger)type;

@end
