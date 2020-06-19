//
//  TYDeviceListViewController.m
//  TuyaSmartHomeKit_Example
//
//  Created by 盖剑秋 on 2018/11/8.
//  Copyright © 2018 xuchengcheng. All rights reserved.
//

#import "TYDemoDeviceListViewController.h"
#import "TYDemoSwitchPanelViewController.h"
#import "TYDemoCommonPanelViewController.h"
#import "TYDemoDeviceListViewCell.h"
#import "TYDemoSmartHomeManager.h"

#import "TPDemoUtils.h"
#import "TPDemoProgressUtils.h"

#import "TYDemoConfiguration.h"

/*
 doc link
 
 en:https://tuyainc.github.io/tuyasmart_home_ios_sdk_doc/en/resource/Home.html#home-management
 zh-hans:https://tuyainc.github.io/tuyasmart_home_ios_sdk_doc/zh-hans/resource/Home.html#%E5%AE%B6%E5%BA%AD%E7%AE%A1%E7%90%86
 */

@interface TYDemoDeviceListViewController() <UITableViewDelegate, UITableViewDataSource, TuyaSmartHomeManagerDelegate, TuyaSmartHomeDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic, strong) TuyaSmartRequest *request;
@property (nonatomic, strong) TuyaSmartHomeManager *homeManager;
@property (nonatomic, strong) UIButton *emptyButton;
@property (nonatomic, strong) TuyaSmartHome *home;

@end

@implementation TYDemoDeviceListViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self initView];
    [self initData];
}

#pragma mark - Initializations.

- (void)initView {
    self.centerTitleItem.title = NSLocalizedString(@"my_smart_home", @"");
    self.topBarView.leftItem = [TPDemoBarButtonItem titleItem:NSLocalizedString(@"ty_smart_switch_home", @"") target:self action:@selector(leftButtonTap)];
    self.topBarView.centerItem = self.centerTitleItem;
    [self.view addSubview:self.topBarView];
    self.rightTitleItem.title = NSLocalizedString(@"Add home", @"");
    self.topBarView.rightItem = self.rightTitleItem;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, APP_TOP_BAR_HEIGHT, APP_SCREEN_WIDTH, APP_CONTENT_HEIGHT) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.tableFooterView = [UIView new];
    [self.view addSubview:self.tableView];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(reloadDataFromCloud) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
    
    self.emptyView = [[TPDemoEmptyView alloc] initWithFrame:self.tableView.bounds title:NSLocalizedString(@"no_device", @"") imageName:@"ty_list_empty"];
    
    _emptyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _emptyButton.frame = CGRectMake(APP_SCREEN_WIDTH / 2 - 100, 250, 200, 44);
    _emptyButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    _emptyButton.backgroundColor = [UIColor orangeColor];
    _emptyButton.layer.cornerRadius = 5;
    [_emptyButton setTitle:NSLocalizedString(@"Add Test Device", @"") forState:UIControlStateNormal];
    [_emptyButton addTarget:self action:@selector(getTestDevice) forControlEvents:UIControlEventTouchUpInside];
    _emptyButton.hidden = YES;
    [self.view addSubview:_emptyButton];
}

- (void)initData {
    
    _homeManager = [[TuyaSmartHomeManager alloc] init];
    _homeManager.delegate = self;
    
    NSString *homeId = [[NSUserDefaults standardUserDefaults] objectForKey:kDefaultCurrentHomeId];
    if ([homeId longLongValue] > 0) {
        self.home = [TuyaSmartHome homeWithHomeId:[homeId longLongValue]];
        self.home.delegate = self;
        self.topBarView.leftItem.title = [NSString stringWithFormat:@"%@ ∨", self.home.homeModel.name];
        [TYDemoSmartHomeManager sharedInstance].currentHomeModel = self.home.homeModel;
        
        [self reloadDataFromCloud];
    } else {
        [self loadFirstHomeData];
    }
}

- (void)swithCurrentHomeIdWithHomeModel:(TuyaSmartHomeModel *)homeModel {
    [TYDemoSmartHomeManager sharedInstance].currentHomeModel = homeModel;
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%lld", homeModel.homeId] forKey:kDefaultCurrentHomeId];
    [self switchHome];
    self.topBarView.leftItem.title = [NSString stringWithFormat:@"%@ ∨", homeModel.name];
    [self.topBarView setNeedsLayout];
}

- (void)loadFirstHomeData {

    WEAKSELF_AT
    [_homeManager getHomeListWithSuccess:^(NSArray<TuyaSmartHomeModel *> *homes) {

        if (homes.count > 0) {
            // If homes are already exist, choose the first one as current home.
            TuyaSmartHomeModel *model = [homes firstObject];
            [weakSelf_AT swithCurrentHomeIdWithHomeModel:model];
        } else {
            // Or else, add a default home named "hangzhou's home" and choose it as current home.
            [weakSelf_AT.homeManager addHomeWithName:@"hangzhou's home" geoName:@"hangzhou" rooms:@[@"bedroom"] latitude:0 longitude:0 success:^(long long homeId) {
                TuyaSmartHome *home = [TuyaSmartHome homeWithHomeId:homeId];
                [weakSelf_AT swithCurrentHomeIdWithHomeModel:home.homeModel];
            } failure:^(NSError *error) {

            }];
        }
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - Actions.

// change the current home

- (void)leftButtonTap {

    WEAKSELF_AT
    [self showLoadingView];
    [self.homeManager getHomeListWithSuccess:^(NSArray<TuyaSmartHomeModel *> *homes) {
        [weakSelf_AT showHomeList:homes];
        [weakSelf_AT hideLoadingView];
    } failure:^(NSError *error) {
        [weakSelf_AT hideLoadingView];
    }];
}

- (void)showHomeList:(NSArray <TuyaSmartHomeModel *> *)homes {
    
    UIAlertController *homeListAC = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"All Homes", @"") message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    for (TuyaSmartHomeModel *homeModel in homes) {
        NSString *homeName = homeModel.name;
        if (homeModel.homeId == [TYDemoSmartHomeManager sharedInstance].currentHomeModel.homeId) {
            homeName = [NSString stringWithFormat:@"%@", homeModel.name];
        }
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:homeName style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self swithCurrentHomeIdWithHomeModel:homeModel];
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationSwitchHome object:nil];
        }];
        [homeListAC addAction:action];
    }
    
    UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:NSLocalizedString(@"cancel", @"") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {}];
    [homeListAC addAction:actionCancel];
    
    [self presentViewController:homeListAC animated:YES completion:nil];
}

- (void)reloadDataFromCloud {
    // sigmesh
//    [[TuyaSmartSIGMeshManager sharedInstance] startScanWithScanType:ScanForProxyed meshModel:self.home.sigMeshModel];
    WEAKSELF_AT
    [self.refreshControl beginRefreshing];
    [self.home getHomeDetailWithSuccess:^(TuyaSmartHomeModel *homeModel) {
        
        [weakSelf_AT reloadData];
    } failure:^(NSError *error) {
        if ([error.localizedFailureReason isEqualToString:@"PERMISSION_DENIED"]) {
            [weakSelf_AT loadFirstHomeData];
        }
        [weakSelf_AT.refreshControl endRefreshing];
    }];
}

- (void)reloadData {
    [self.refreshControl endRefreshing];
    _emptyButton.hidden = self.home.deviceList.count + self.home.groupList.count;
    self.tableView.hidden = !_emptyButton.hidden;
    [self.tableView reloadData];
}

- (void)switchHome {
    self.home = [TuyaSmartHome homeWithHomeId:[TYDemoSmartHomeManager sharedInstance].currentHomeModel.homeId];
    self.home.delegate = self;
    [self reloadDataFromCloud];
}

- (TuyaSmartRequest *)request {
    if (!_request) {
        _request = [[TuyaSmartRequest alloc] init];
    }
    return _request;
}

// add experience device
- (void)getTestDevice {
    
#warning 绑定演示设备到账号下面，生产环境勿使用
    
    [self showProgressView:NSLocalizedString(@"loading", @"")];
    WEAKSELF_AT
    long long gid = self.home.homeModel.homeId;
    [self.request requestWithApiName:@"s.m.dev.sdk.demo.list" postData:nil getData:@{@"gid" : @(gid)} version:@"1.0" success:^(id result) {
        
        [weakSelf_AT hideProgressView];
        [weakSelf_AT reloadDataFromCloud];
    } failure:^(NSError *error) {
        [weakSelf_AT hideProgressView];
        [TPDemoProgressUtils showError:error.localizedDescription];
    }];
}

// add home
- (void)rightBtnAction {
    NSString *homeName = [NSString stringWithFormat:@"Home_%@", @(self.homeManager.homes.count)];
    WEAKSELF_AT
    [self.homeManager addHomeWithName:homeName geoName:@"hangzhou" rooms:@[@"room1"] latitude:0 longitude:0 success:^(long long homeId) {
        [TPDemoProgressUtils showSuccess:@"Add Success" toView:nil];
        // 切换到新增家庭
        TuyaSmartHome *home = [TuyaSmartHome homeWithHomeId:homeId];
        [weakSelf_AT swithCurrentHomeIdWithHomeModel:home.homeModel];
    } failure:^(NSError *error) {
        [TPDemoProgressUtils showError:error.localizedDescription];
    }];
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.home.deviceList.count + self.home.groupList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TYDemoDeviceListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TYDemoDeviceListViewCell class])];
    if (!cell) {
        cell = [[TYDemoDeviceListViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:NSStringFromClass([TYDemoDeviceListViewCell class])];
    }
    
    if (indexPath.row < self.home.groupList.count) {
        TuyaSmartGroupModel *groupModel = [self.home.groupList objectAtIndex:indexPath.row];
        [cell setItem:groupModel];
    } else if (indexPath.row < self.home.deviceList.count + self.home.groupList.count) {
        TuyaSmartDeviceModel *deviceModel = [self.home.deviceList objectAtIndex:(indexPath.row - self.home.groupList.count)];
        [cell setItem:deviceModel];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.row < self.home.groupList.count) {
        TuyaSmartGroupModel *groupModel = [self.home.groupList objectAtIndex:indexPath.row];
        
        id<TYDemoPanelControlProtocol> impl = [[TYDemoConfiguration sharedInstance] serviceOfProtocol:@protocol(TYDemoPanelControlProtocol)];
        if ([impl respondsToSelector:@selector(gotoPanelControlDevice:group:)]) {
            [impl gotoPanelControlDevice:nil group:groupModel];
        } else {
            TYDemoCommonPanelViewController *vc = [[TYDemoCommonPanelViewController alloc] init];
            vc.groupId = groupModel.groupId;
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    } else if (indexPath.row < self.home.deviceList.count + self.home.groupList.count) {
        TuyaSmartDeviceModel *deviceModel = [self.home.deviceList objectAtIndex:(indexPath.row - self.home.groupList.count)];
        
        id<TYDemoPanelControlProtocol> impl = [[TYDemoConfiguration sharedInstance] serviceOfProtocol:@protocol(TYDemoPanelControlProtocol)];
        if ([impl respondsToSelector:@selector(gotoPanelControlDevice:group:)]) {
            [impl gotoPanelControlDevice:deviceModel group:nil];
        } else {
            // 演示设备 productId
            if ([deviceModel.productId isEqualToString:@"4eAeY1i5sUPJ8m8d"]) {
                
                TYDemoSwitchPanelViewController *vc = [[TYDemoSwitchPanelViewController alloc] init];
                vc.devId = deviceModel.devId;
                [self.navigationController pushViewController:vc animated:YES];
            } else {
                
                TYDemoCommonPanelViewController *vc = [[TYDemoCommonPanelViewController alloc] init];
                vc.devId = deviceModel.devId;
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
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

#pragma mark - TuyaSmartHomeManagerDelegate

// add home
- (void)homeManager:(TuyaSmartHomeManager *)manager didAddHome:(TuyaSmartHomeModel *)home {
    NSLog(@"Add a home %@", home.name);
}

// remove home
- (void)homeManager:(TuyaSmartHomeManager *)manager didRemoveHome:(long long)homeId {
    // 如果删除的家庭是当前家庭，当前家庭切换到另外一个
    if ([TYDemoSmartHomeManager sharedInstance].currentHomeModel.homeId == homeId) {
        [self loadFirstHomeData];
    }
}

// MQTT connect success
- (void)serviceConnectedSuccess {
    [self reloadDataFromCloud];
}

@end
