//
//  TYReceiveMemberDeviceListView.m
//  TuyaSmart
//
//  Created by 冯晓 on 16/1/6.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TYReceiveMemberDeviceListView.h"

@interface TYReceiveMemberDeviceListView() <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray *deviceList;
@property (nonatomic, assign) NSInteger type;

@end

@implementation TYReceiveMemberDeviceListView

- (instancetype)initWithFrame:(CGRect)frame deviceList:(NSArray *)deviceList type:(NSInteger)type {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        _deviceList = deviceList;
        _type = type;
        [self addSubview:self.tableView];
    }
    return self;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, APP_SCREEN_WIDTH, self.height) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[TYReceiveMemberDeviceListCell class] forCellReuseIdentifier:@"MemberTableViewCell"];
    }
    return _tableView;
}

#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.deviceList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TYReceiveMemberDeviceListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MemberTableViewCell" forIndexPath:indexPath];
    
    cell.delegate = self.delegate;
    
    TuyaSmartShareDeviceModel *model = [self.deviceList objectAtIndex:indexPath.row];
    
    [cell setModel:model type:_type];
    return cell;
}

#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
