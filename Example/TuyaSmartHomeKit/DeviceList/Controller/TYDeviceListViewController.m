//
//  TYDeviceListViewController.m
//  TuyaSmartHomeKit_Example
//
//  Created by 盖剑秋 on 2018/11/8.
//  Copyright © 2018 xuchengcheng. All rights reserved.
//

#import "TYDeviceListViewController.h"
#import <TuyaSmartBLEMeshKit/TuyaSmartBLEMeshKit.h>
#import "TYSwitchPanelViewController.h"
#import "TYCommonPanelViewController.h"
#import "TYDeviceListViewCell.h"
#import "TYSmartHomeManager.h"

/*
 doc link
 
 en:https://tuyainc.github.io/tuyasmart_home_ios_sdk_doc/en/resource/Home.html#home-management
 zh-hans:https://tuyainc.github.io/tuyasmart_home_ios_sdk_doc/zh-hans/resource/Home.html#%E5%AE%B6%E5%BA%AD%E7%AE%A1%E7%90%86
 */

@interface TYDeviceListViewController() <UITableViewDelegate, UITableViewDataSource, TuyaSmartHomeManagerDelegate, TuyaSmartHomeDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic, strong) TuyaSmartRequest *request;
@property (nonatomic, strong) TuyaSmartHomeManager *homeManager;
@end

@implementation TYDeviceListViewController
{
    UIButton *emptyButton;
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self initView];
    [self initData];
    
    [TYSmartHomeManager sharedInstance].currentHome.delegate = self;
}

#pragma mark - Initializations.

- (void)initView {
    self.centerTitleItem.title = NSLocalizedString(@"my_smart_home", @"");
    self.topBarView.leftItem = [TPBarButtonItem titleItem:NSLocalizedString(@"ty_smart_switch_home", @"") target:self action:@selector(leftButtonTap)];
    self.topBarView.centerItem = self.centerTitleItem;
    [self.view addSubview:self.topBarView];
    self.rightTitleItem.title = @"Add home";
    self.topBarView.rightItem = self.rightTitleItem;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, APP_TOP_BAR_HEIGHT, APP_SCREEN_WIDTH, APP_CONTENT_HEIGHT) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.tableFooterView = [UIView new];
    [self.view addSubview:self.tableView];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(reloadDataFromCloud) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
    
    self.emptyView = [[TPEmptyView alloc] initWithFrame:self.tableView.bounds title:NSLocalizedString(@"no_device", @"") imageName:@"ty_list_empty"];
    
    
    emptyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    emptyButton.frame = CGRectMake(APP_SCREEN_WIDTH / 2 - 100, 250, 200, 44);
    emptyButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    emptyButton.backgroundColor = [UIColor orangeColor];
    emptyButton.layer.cornerRadius = 5;
    [emptyButton setTitle:@"Add Test Device" forState:UIControlStateNormal];
    [emptyButton addTarget:self action:@selector(getTestDevice) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:emptyButton];
    
    if ([TYSmartHomeManager sharedInstance].currentHome.deviceList.count) {
        [self.tableView reloadData];
    }
    emptyButton.hidden = [TYSmartHomeManager sharedInstance].currentHome.deviceList.count;
    self.tableView.hidden = !emptyButton.hidden;
}

- (void)initData {

    emptyButton.hidden = YES;
    [self showProgressView:NSLocalizedString(@"loading", @"")];
    self.homeManager = [TuyaSmartHomeManager new];
    self.homeManager.delegate = self;
    [self reloadDataFromCloud];
}

#pragma mark - Actions.

// change the current home

- (void)leftButtonTap {

    WEAKSELF_AT
    [self showLoadingView];
    [self.homeManager getHomeListWithSuccess:^(NSArray<TuyaSmartHomeModel *> *homes) {
        
        if (homes.count > 0) {
            // If homes are already exist, choose the first one as current home.
            [weakSelf_AT showHomeList:homes];
            [weakSelf_AT hideLoadingView];
        } else {
            // Or else, add a default home named "hangzhou's home" and choose it as current home.
            [weakSelf_AT.homeManager addHomeWithName:@"hangzhou's home" geoName:@"hangzhou" rooms:@[@"bedroom"] latitude:0 longitude:0 success:^(long long homeId) {
                TuyaSmartHome *home = [TuyaSmartHome homeWithHomeId:homeId];
                [weakSelf_AT showHomeList:@[home.homeModel]];
                [TYSmartHomeManager sharedInstance].currentHome = home;
                [weakSelf_AT hideLoadingView];
            } failure:^(NSError *error) {
                //Do fail action.
                [weakSelf_AT hideLoadingView];
            }];
        }
    } failure:^(NSError *error) {
        //Do fail action.
        [weakSelf_AT hideLoadingView];
    }];
}

- (void)showHomeList:(NSArray <TuyaSmartHomeModel *> *)homes {
    
    UIAlertController *homeListAC = [UIAlertController alertControllerWithTitle:@"all homes" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    for (TuyaSmartHomeModel *homeModel in homes) {
        NSString *homeName = homeModel.name;
        if (homeModel.homeId == [TYSmartHomeManager sharedInstance].currentHome.homeModel.homeId) {
            homeName = [NSString stringWithFormat:@"%@ is primary", homeModel.name];
        }
        
        __weak typeof(self) weakSelf = self;
        UIAlertAction *action = [UIAlertAction actionWithTitle:homeName style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [TYSmartHomeManager sharedInstance].currentHome = [TuyaSmartHome homeWithHomeId:homeModel.homeId];
            [weakSelf reloadDataFromCloud];
        }];
        [homeListAC addAction:action];
    }
    
    UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {}];
    [homeListAC addAction:actionCancel];
    
    [self presentViewController:homeListAC animated:YES completion:nil];
}

- (void)reloadDataFromCloud {
    [self showProgressView:NSLocalizedString(@"loading", @"")];
    [[TuyaSmartSIGMeshManager sharedInstance] startScanWithScanType:ScanForProxyed meshModel:[TYSmartHomeManager sharedInstance].currentHome.sigMeshModel];
    WEAKSELF_AT
    [self.refreshControl beginRefreshing];
    [[TYSmartHomeManager sharedInstance].currentHome getHomeDetailWithSuccess:^(TuyaSmartHomeModel *homeModel) {
//        NSUserDefaults *groupUserDefault = [[NSUserDefaults alloc] initWithSuiteName:APP_GROUP_NAME];
//        [groupUserDefault setObject:@(homeModel.homeId) forKey:@"kCurrentHomeIdKey"];
        
        [weakSelf_AT hideProgressView];
        [weakSelf_AT reloadData];
    } failure:^(NSError *error) {
        [weakSelf_AT hideProgressView];
        [weakSelf_AT.refreshControl endRefreshing];
    }];
}

- (void)reloadData {
    [self.refreshControl endRefreshing];
    emptyButton.hidden = [TYSmartHomeManager sharedInstance].currentHome.deviceList.count;
    self.tableView.hidden = !emptyButton.hidden;
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
        [weakSelf_AT reloadDataFromCloud];
    } failure:^(NSError *error) {
        [weakSelf_AT hideProgressView];
        
        NSString *msg = [NSString stringWithFormat:@"Get test device failed: %@",error.localizedDescription];
        [self alertMessage:msg];
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

// add home
- (void)rightBtnAction {
    WEAKSELF_AT
    NSString *homeName = [NSString stringWithFormat:@"Home_number_%@",@(self.homeManager.homes.count)];
    [self.homeManager addHomeWithName:homeName geoName:@"test location" rooms:@[@"class room"] latitude:0 longitude:0 success:^(long long result) {
        
        [weakSelf_AT alertMessage:@"Add a new home to your account successfully!"];
    } failure:^(NSError *error) {
        
        NSString *msg = [NSString stringWithFormat:@"Add home fail: %@",error.localizedDescription];
        [weakSelf_AT alertMessage:msg];
    }];

}

#pragma mark - TuyaSmartHomeManagerDelegate

// 添加一个家庭
- (void)homeManager:(TuyaSmartHomeManager *)manager didAddHome:(TuyaSmartHomeModel *)home {
    NSLog(@"Add a home %@", home.name);
}

// 删除一个家庭
- (void)homeManager:(TuyaSmartHomeManager *)manager didRemoveHome:(long long)homeId {
    // remove home
}

// MQTT连接成功
- (void)serviceConnectedSuccess {
    [self reloadDataFromCloud];
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
    //演示设备produckId
    if ([deviceModel.productId isEqualToString:@"4eAeY1i5sUPJ8m8d"]) {
        
        TYSwitchPanelViewController *vc = [[TYSwitchPanelViewController alloc] init];
        vc.devId = deviceModel.devId;
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        
        TYCommonPanelViewController *vc = [[TYCommonPanelViewController alloc] init];
        vc.devId = deviceModel.devId;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

#pragma mark - TuyaSmartHomeDelegate

// 家庭的信息更新，例如name
- (void)homeDidUpdateInfo:(TuyaSmartHome *)home {
    [self.tableView reloadData];
}

// 家庭和房间关系变化
- (void)homeDidUpdateRoomInfo:(TuyaSmartHome *)home {
    [self.tableView reloadData];
}

// 我收到的共享设备列表变化
- (void)homeDidUpdateSharedInfo:(TuyaSmartHome *)home {
    [self.tableView reloadData];
}

// 房间信息变更，例如name
- (void)home:(TuyaSmartHome *)home roomInfoUpdate:(TuyaSmartRoomModel *)room {
    [self.tableView reloadData];
}

// 房间与设备，群组的关系变化
- (void)home:(TuyaSmartHome *)home roomRelationUpdate:(TuyaSmartRoomModel *)room {
    [self.tableView reloadData];
}

// 添加设备
- (void)home:(TuyaSmartHome *)home didAddDeivice:(TuyaSmartDeviceModel *)device {
    [self.tableView reloadData];
}

// 删除设备
- (void)home:(TuyaSmartHome *)home didRemoveDeivice:(NSString *)devId {
    [self.tableView reloadData];
}

// 设备信息更新，例如name
- (void)home:(TuyaSmartHome *)home deviceInfoUpdate:(TuyaSmartDeviceModel *)device {
    [self.tableView reloadData];
}

// 设备dp数据更新
- (void)home:(TuyaSmartHome *)home device:(TuyaSmartDeviceModel *)device dpsUpdate:(NSDictionary *)dps {
    [self.tableView reloadData];
}

// 添加群组
- (void)home:(TuyaSmartHome *)home didAddGroup:(TuyaSmartGroupModel *)group {
    [self.tableView reloadData];
}

// 群组dp数据更新
- (void)home:(TuyaSmartHome *)home group:(TuyaSmartGroupModel *)group dpsUpdate:(NSDictionary *)dps {
    [self.tableView reloadData];
}

// 删除群组
- (void)home:(TuyaSmartHome *)home didRemoveGroup:(NSString *)groupId {
    [self.tableView reloadData];
}

// 群组信息更新，例如name
- (void)home:(TuyaSmartHome *)home groupInfoUpdate:(TuyaSmartGroupModel *)group {
    [self.tableView reloadData];
}

@end
