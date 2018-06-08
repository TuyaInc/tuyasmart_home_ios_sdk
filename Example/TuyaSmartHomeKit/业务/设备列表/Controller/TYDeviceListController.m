//
//  TYDeviceListController.m
//  TuyaSmart
//
//  Created by 冯晓 on 16/1/4.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TYDeviceListController.h"
#import "TYDeviceListViewCell.h"
#import "TYCommonPanelViewController.h"
#import "TYSwitchPanelViewController.h"

#define DeviceListCellViewIdentifier    @"DeviceListCellViewIdentifier"

@interface TYDeviceListController() <TuyaSmartHomeDelegate, TuyaSmartHomeManagerDelegate>

@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic, strong) TuyaSmartRequest *request;
@property (nonatomic, strong) TuyaSmartHomeManager *homeManager;
@property (nonatomic, strong) TuyaSmartHome *home;

@end

@implementation TYDeviceListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    [self reloadDataFromCloud];
}

- (void)viewWillAppear:(BOOL)animated {
    [self reloadData];
}

- (void)initView {
    self.centerTitleItem.title = NSLocalizedString(@"my_smart_home", @"");
    self.topBarView.leftItem = [TPBarButtonItem titleItem:NSLocalizedString(@"ty_smart_switch_home", @"") target:self action:@selector(leftButtonTap)];
    self.topBarView.centerItem = self.centerTitleItem;
    [self.view addSubview:self.topBarView];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, APP_TOP_BAR_HEIGHT, APP_SCREEN_WIDTH, APP_CONTENT_HEIGHT) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(reloadDataFromCloud) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
    
    self.emptyView = [[TPEmptyView alloc] initWithFrame:self.tableView.bounds title:NSLocalizedString(@"no_device", @"") imageName:@"ty_list_empty"];
  
    
    UIButton *button = [TPViewUtil buttonWithFrame:CGRectMake(APP_SCREEN_WIDTH / 2 - 100, self.emptyView.titleLabel.bottom + 20, 200, 44) fontSize:16 bgColor:[UIColor whiteColor] textColor:LIST_MAIN_TEXT_COLOR borderColor:LIST_LINE_COLOR];
    [button setTitle:NSLocalizedString(@"Add Test Device", @"") forState:UIControlStateNormal];
    [button addTarget:self action:@selector(getTestDevice) forControlEvents:UIControlEventTouchUpInside];
    [self.emptyView addSubview:button];
    [self.tableView addSubview:self.emptyView];
    
    self.homeManager.delegate = self;
    
    // 从远端读取数据
    WEAKSELF_AT
    [self.homeManager getHomeListWithSuccess:^(NSArray<TuyaSmartHomeModel *> *homes) {
        
        if (homes.count > 0) {
            TuyaSmartHomeModel *model = [homes firstObject];
            weakSelf_AT.home = [TuyaSmartHome homeWithHomeId:model.homeId];
            weakSelf_AT.home.delegate = weakSelf_AT;
            [TYHomeManager sharedInstance].home = weakSelf_AT.home;
            [weakSelf_AT reloadDataFromCloud];
        }
    } failure:^(NSError *error) {
        
    }];
}

- (TuyaSmartHomeManager *)homeManager {
    if (!_homeManager ) {
        _homeManager = [TuyaSmartHomeManager new];
    }
    return _homeManager;
}

- (void)reloadDataFromCloud {
    [self showProgressView:NSLocalizedString(@"loading", @"")];
    WEAKSELF_AT
    [self.refreshControl beginRefreshing];
    [self.home getHomeDetailWithSuccess:^(TuyaSmartHomeModel *homeModel) {
        [weakSelf_AT hideProgressView];
        [weakSelf_AT reloadData];
    } failure:^(NSError *error) {
        [weakSelf_AT hideProgressView];
        [weakSelf_AT.refreshControl endRefreshing];
        [TPProgressUtils showError:error.localizedDescription];
    }];
}

- (void)reloadData {
    [self.refreshControl endRefreshing];
    self.emptyView.hidden = [self.home.deviceList count] != 0;
    [self.tableView reloadData];
}

- (void)leftButtonTap {
    UIAlertController *homeListAC = [UIAlertController alertControllerWithTitle:@"all homes" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    for (TuyaSmartHomeModel *homeModel in self.homeManager.homes) {
        NSString *homeName = homeModel.name;
        if (homeModel.homeId == [TYHomeManager sharedInstance].home.homeModel.homeId) {
            homeName = [NSString stringWithFormat:@"%@ is primary", homeModel.name];
        }
        
        __weak typeof(self) weakSelf = self;
        UIAlertAction *action = [UIAlertAction actionWithTitle:homeName style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            weakSelf.home = [TuyaSmartHome homeWithHomeId:homeModel.homeId];
            weakSelf.home.delegate = weakSelf;
            [TYHomeManager sharedInstance].home = weakSelf.home;
            [weakSelf reloadDataFromCloud];
        }];
        [homeListAC addAction:action];
    }
    
    UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {}];
    [homeListAC addAction:actionCancel];
    
    [self presentViewController:homeListAC animated:YES completion:^{
    }];
}

//添加一个特定的虚拟演示设备
- (void)getTestDevice {

#warning 绑定演示设备到账号下面，生产环境勿使用
    
    [self showProgressView:NSLocalizedString(@"loading", @"")];
    WEAKSELF_AT
    [self.request requestWithApiName:@"s.m.dev.sdk.demo.list" postData:nil getData:@{@"gid" : @(self.home.homeModel.homeId)} version:@"1.0" success:^(id result) {
        [weakSelf_AT hideProgressView];
        [weakSelf_AT reloadDataFromCloud];
    } failure:^(NSError *error) {
        [weakSelf_AT hideProgressView];
        [TPProgressUtils showError:error.localizedDescription];
    }];
}

- (TuyaSmartRequest *)request {
    if (!_request) {
        _request = [TuyaSmartRequest new];
    }
    return _request;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.home.deviceList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TYDeviceListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DeviceListCellViewIdentifier];
    if (!cell) {
        cell = [[TYDeviceListViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:DeviceListCellViewIdentifier];
    }
    
    TuyaSmartDeviceModel *deviceModel = [self.home.deviceList objectAtIndex:indexPath.row];
    [cell setItem:deviceModel];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    
    TuyaSmartDeviceModel *deviceModel = [self.home.deviceList objectAtIndex:indexPath.row];
    
    
    //演示设备produckId
    if ([deviceModel.productId isEqualToString:@"4eAeY1i5sUPJ8m8d"]) {
        
        TYSwitchPanelViewController *vc = [[TYSwitchPanelViewController alloc] init];
        vc.devId = deviceModel.devId;
        [ViewControllerUtils pushViewController:vc from:self];

    } else {
        
        TYCommonPanelViewController *vc = [[TYCommonPanelViewController alloc] init];
        vc.devId = deviceModel.devId;
        [ViewControllerUtils pushViewController:vc from:self];
        
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

// 删除群组
- (void)home:(TuyaSmartHome *)home didRemoveGroup:(NSString *)groupId {
    [self.tableView reloadData];
}

// 群组信息更新，例如name
- (void)home:(TuyaSmartHome *)home groupInfoUpdate:(TuyaSmartGroupModel *)group {
    [self.tableView reloadData];
}

#pragma mark - TuyaSmartHomeManagerDelegate

// 添加一个家庭
- (void)homeManager:(TuyaSmartHomeManager *)manager didAddHome:(TuyaSmartHomeModel *)home {
    
}

// 删除一个家庭
- (void)homeManager:(TuyaSmartHomeManager *)manager didRemoveHome:(long long)homeId {
    
}

// MQTT连接成功
- (void)serviceConnectedSuccess {
    // 刷新当前家庭UI
    [self reloadDataFromCloud];
}

@end
