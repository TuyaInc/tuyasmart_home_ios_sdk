//
//  TYDeviceListViewController.m
//  TuyaSmartHomeKit_Example
//
//  Created by 盖剑秋 on 2018/11/8.
//  Copyright © 2018 xuchengcheng. All rights reserved.
//

#import "TYDeviceListViewController.h"
#import <Masonry/Masonry.h>
#import <TuyaSmartBLEMeshKit/TuyaSmartBLEMeshKit.h>
#import "TYSwitchPanelViewController.h"
#import "TYPanelBaseDeviceViewController.h"
#import "TYDeviceListViewCell.h"
#import "TYSmartHomeManager.h"

/*
 doc link
 
 en:https://tuyainc.github.io/tuyasmart_home_ios_sdk_doc/en/resource/Home.html#home-management
 zh-hans:https://tuyainc.github.io/tuyasmart_home_ios_sdk_doc/zh-hans/resource/Home.html#%E5%AE%B6%E5%BA%AD%E7%AE%A1%E7%90%86
 */

@interface TYDeviceListViewController() <UITableViewDelegate, UITableViewDataSource, TuyaSmartHomeDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) TuyaSmartRequest *request;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@property (nonatomic, strong) UIButton *emptyButton;

@end

@implementation TYDeviceListViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self initView];
    [self initData];
    
}

#pragma mark - Initializations.

- (void)initView {

    self.topBarView.hidden = YES;
    [self.view addSubview:self.tableView];
    [self.tableView addSubview:self.refreshControl];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.view addSubview:self.emptyButton];
    
    if ([TYSmartHomeManager sharedInstance].currentHome.deviceList.count) {
        [self.tableView reloadData];
    }
    self.emptyButton.hidden = [TYSmartHomeManager sharedInstance].currentHome.deviceList.count;
    self.tableView.hidden = !self.emptyButton.hidden;
    
    self.emptyButton.hidden = YES;
}

- (void)initData {

}

- (void)beginReload {
    [self.refreshControl beginRefreshing];
}

- (void)reloadData {
    [self.refreshControl endRefreshing];
    self.emptyButton.hidden = [TYSmartHomeManager sharedInstance].currentHome.deviceList.count;
    self.tableView.hidden = !self.emptyButton.hidden;
    [self.tableView reloadData];
}

// add experience device
- (void)getTestDevice {
    
    [self showProgressView:NSLocalizedString(@"loading", @"")];
    WEAKSELF_AT
    if (!self.request) {
        self.request = [TuyaSmartRequest new];
    }
    long long gid = [TYSmartHomeManager sharedInstance].currentHome.homeModel.homeId;
    [self.request requestWithApiName:@"s.m.dev.sdk.demo.list" postData:nil getData:@{@"gid" : @(gid)} version:@"1.0" success:^(id result) {
        [weakSelf_AT hideProgressView];
        if ([weakSelf_AT.vcDelegate respondsToSelector:@selector(controllerDidAddTestDevice:)]) {
            [weakSelf_AT.vcDelegate controllerDidAddTestDevice:weakSelf_AT];
        }
    } failure:^(NSError *error) {
        [weakSelf_AT hideProgressView];
        
        NSString *msg = [NSString stringWithFormat:@"Get test device failed: %@",error.localizedDescription];
        [weakSelf_AT alertMessage:msg];
    }];
}

- (void)alertMessage:(NSString *)message {
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:message
                                                     message:nil
                                                    delegate:nil
                                           cancelButtonTitle:@"OK"
                                           otherButtonTitles:nil];
    [alert show];
}

- (void)reloadDataFromCloud {
    if ([self.vcDelegate respondsToSelector:@selector(controllerNeedReloadData:)]) {
        [self.vcDelegate controllerNeedReloadData:self];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [TYSmartHomeManager sharedInstance].currentHome.deviceList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TYDeviceListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TYDeviceListViewCell class])];
    if (!cell) {
        cell = [[TYDeviceListViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:NSStringFromClass([TYDeviceListViewCell class])];
    }
    
    TuyaSmartDeviceModel *deviceModel = [[TYSmartHomeManager sharedInstance].currentHome.deviceList objectAtIndex:indexPath.row];
    [cell setItem:deviceModel];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    TuyaSmartDeviceModel *deviceModel = [[TYSmartHomeManager sharedInstance].currentHome.deviceList objectAtIndex:indexPath.row];
    //演示设备productId
    if ([deviceModel.productId isEqualToString:@"4eAeY1i5sUPJ8m8d"]) {
        
        TYSwitchPanelViewController *vc = [[TYSwitchPanelViewController alloc] init];
        vc.devId = deviceModel.devId;
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        
        TYPanelBaseDeviceViewController *vc = [[TYPanelBaseDeviceViewController alloc] init];
        vc.devId = deviceModel.devId;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

#pragma mark - getters & setters & init members

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

- (UIButton *)emptyButton {
    if (!_emptyButton) {
        _emptyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _emptyButton.frame = CGRectMake(APP_SCREEN_WIDTH / 2 - 100, 250, 200, 44);
        _emptyButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        _emptyButton.backgroundColor = [UIColor orangeColor];
        _emptyButton.layer.cornerRadius = 5;
        [_emptyButton setTitle:@"Add Test Device" forState:UIControlStateNormal];
        [_emptyButton addTarget:self action:@selector(getTestDevice) forControlEvents:UIControlEventTouchUpInside];
    }
    return _emptyButton;
}

- (TPEmptyView *)emptyView {
    if (![super emptyView]) {
        [self setEmptyView:[[TPEmptyView alloc] initWithFrame:self.tableView.bounds title:NSLocalizedString(@"no_device", @"") imageName:@"ty_list_empty"]];
    }
    return [super emptyView];
}

- (UIRefreshControl *)refreshControl {
    if (!_refreshControl) {
        _refreshControl = [[UIRefreshControl alloc] init];
        [_refreshControl addTarget:self action:@selector(reloadDataFromCloud) forControlEvents:UIControlEventValueChanged];
    }
    return _refreshControl;
}

@end
