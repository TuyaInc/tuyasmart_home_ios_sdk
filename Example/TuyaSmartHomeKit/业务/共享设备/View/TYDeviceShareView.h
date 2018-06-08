//
//  TYDeviceShareView.h
//  TuyaSmart
//
//  Created by 冯晓 on 16/1/7.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPBaseLayout.h"
#import "TYDeviceShareViewListCell.h"

@protocol TYDeviceShareViewDelegate <NSObject>

@required
- (void)deleteRowWithMember:(TuyaSmartShareMemberModel *)member;

@end

@interface TYDeviceShareView : TPBaseLayout

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *shareButton;
@property (nonatomic, strong) NSArray *memberList;
@property (nonatomic, weak) id <TYDeviceShareViewDelegate> delegate;

- (void)reloadData;

@end
