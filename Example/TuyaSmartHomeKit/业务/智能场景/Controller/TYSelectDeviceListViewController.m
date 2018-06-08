//
//  TYSelectDeviceListViewController.m
//  TuyaSmartPublic
//
//  Created by XuChengcheng on 16/7/6.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TYSelectDeviceListViewController.h"
#import "TYDeviceListViewCell.h"
#import "TYSelectFeatureViewController.h"

@interface TYSelectDeviceListViewController ()

@end

@implementation TYSelectDeviceListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [self initData];
}

- (void)initView {
    self.view.backgroundColor = MAIN_BACKGROUND_COLOR;

    self.tableView.frame = CGRectMake(0, APP_TOP_BAR_HEIGHT, APP_CONTENT_WIDTH, APP_VISIBLE_HEIGHT);
    [self.view addSubview:self.tableView];
}

- (NSString *)titleForCenterItem {
    return NSLocalizedString(@"ty_smart_scene_choose_device", @"");
}

- (NSString *)titleForEmptyView {
    return NSLocalizedString(@"ty_smart_scene_error_no_device", @"");
}

- (void)initData {
    WEAKSELF_AT
    [self showLoadingView];

    if (_isCondition) {
        [[TuyaSmartSceneManager sharedInstance] getConditionDeviceListWithHomeId:[TYHomeManager sharedInstance].home.homeModel.homeId success:^(NSArray<TuyaSmartDeviceModel *> *list) {
            if (list.count == 0) {
                [weakSelf_AT showEmptyView];
            }
            [weakSelf_AT hideLoadingView];
            [weakSelf_AT.dataSource removeAllObjects];
            
            for (TuyaSmartDeviceModel *model in list) {
                
                if (![weakSelf_AT.selectDevList containsObject:model.devId]) {
                    [weakSelf_AT.dataSource tp_safeAddObject:model];
                }
            }
            [weakSelf_AT reloadTable];
        } failure:^(NSError *error) {
            [weakSelf_AT hideLoadingView];
            [TPProgressUtils showError:error];
        }];
    } else {

        [[TuyaSmartSceneManager sharedInstance] getActionDeviceListWithHomeId:[TYHomeManager sharedInstance].home.homeModel.homeId success:^(NSArray<TuyaSmartDeviceModel *> *list) {
            if (list.count == 0) {
                [weakSelf_AT showEmptyView];
            }
            [weakSelf_AT hideLoadingView];
            [weakSelf_AT.dataSource removeAllObjects];
            
            for (TuyaSmartDeviceModel *model in list) {
                
                if (![weakSelf_AT.selectDevList containsObject:model.devId]) {
                    [weakSelf_AT.dataSource tp_safeAddObject:model];
                }
            }
            [weakSelf_AT reloadTable];
        } failure:^(NSError *error) {
            [weakSelf_AT hideLoadingView];
            [TPProgressUtils showError:error];
        }];
    }


}

//是否显示下拉刷新
- (BOOL)showPullToRefresh {
    return NO;
}
//是否显示上拉刷新
- (BOOL)showInfinite {
    return NO;
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"deviceListCell";
    TYDeviceListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[TYDeviceListViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    TuyaSmartDeviceModel *device = (TuyaSmartDeviceModel *)[self.dataSource objectAtIndex:indexPath.row];
    [cell setItem:[TuyaSmartDevice deviceWithDeviceId:device.devId].deviceModel];
    
    return cell;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    TuyaSmartDeviceModel *device = (TuyaSmartDeviceModel *)[self.dataSource objectAtIndex:indexPath.row];
    TYSelectFeatureViewController *vc = [[TYSelectFeatureViewController alloc] init];
    vc.entityId = device.devId;
    vc.selectedItem = -1;
    vc.isCondition = _isCondition;
    [self.navigationController pushViewController:vc animated:YES];
}


@end

