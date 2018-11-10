//
//  TYBleMeshViewController.m
//  TuyaSmartHomeKit_Example
//
//  Created by 黄凯 on 2018/11/10.
//  Copyright © 2018 xuchengcheng. All rights reserved.
//

#import "TYBleMeshViewController.h"
#import "TYDeviceListViewCell.h"
#import "TYBleMeshActivatorViewController.h"
#import "TYDeviceViewController.h"

#define MeshDeviceListCellViewIdentifier    @"MeshDeviceListCellViewIdentifier"
@interface TYBleMeshViewController () <TuyaSmartHomeDelegate>

@property (nonatomic, strong) UIRefreshControl *refreshControl;

@property (nonatomic, strong) NSMutableArray<TuyaSmartDeviceModel *> *meshDevList;

@end

@implementation TYBleMeshViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [TYHomeManager sharedInstance].home.delegate = self;
    
    [[TuyaSmartSDK sharedInstance] setValue:@(YES) forKey:@"bleMeshEnable"];
    
    // 设置 mesh
    [TuyaSmartUser sharedInstance].mesh = [TuyaSmartBleMesh bleMeshWithMeshId:[TYHomeManager sharedInstance].home.meshModel.meshId homeId:[TYHomeManager sharedInstance].home.meshModel.homeId];
    [TuyaSmartUser sharedInstance].meshModel = [TYHomeManager sharedInstance].home.meshModel;
    
    if ([TuyaSmartUser sharedInstance].meshModel ) {
        [[TYBLEMeshManager sharedInstance] startScanWithName:[TuyaSmartUser sharedInstance].meshModel.code pwd:[TuyaSmartUser sharedInstance].meshModel.password active:NO wifiAddress:0 otaAddress:0];
    }
    
    
    [self initView];
    [self initData];
}

- (void)initView {
    self.centerTitleItem.title = @"blemesh";
    
    self.topBarView.rightItem = [TPBarButtonItem titleItem:NSLocalizedString(@"Add Test Device", @"") target:self action:@selector(rightButtonTap)];
    self.topBarView.centerItem = self.centerTitleItem;
    [self.view addSubview:self.topBarView];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, APP_TOP_BAR_HEIGHT, APP_SCREEN_WIDTH, APP_SCREEN_HEIGHT - APP_TOP_BAR_HEIGHT) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(initData) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
    
    self.emptyView = [[TPEmptyView alloc] initWithFrame:self.tableView.bounds title:NSLocalizedString(@"no_device", @"") imageName:@"ty_list_empty"];

}

- (void)initData {
    _meshDevList = [NSMutableArray array];
    [[TYHomeManager sharedInstance].home.deviceList enumerateObjectsUsingBlock:^(TuyaSmartDeviceModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.deviceType == TuyaSmartDeviceModelTypeMeshBleSubDev) {
            [_meshDevList addObject:obj];
        }
    }];
    
    [self reloadData];
}

- (void)reloadData {
    [self.refreshControl endRefreshing];
    self.emptyView.hidden = [_meshDevList count] != 0;
    [self.tableView reloadData];
}

- (void)rightButtonTap {
    TYBleMeshActivatorViewController *vc = [[TYBleMeshActivatorViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.meshDevList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TYDeviceListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MeshDeviceListCellViewIdentifier];
    if (!cell) {
        cell = [[TYDeviceListViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:MeshDeviceListCellViewIdentifier];
    }
    
    TuyaSmartDeviceModel *deviceModel = [self.meshDevList objectAtIndex:indexPath.row];
    [cell setItem:deviceModel];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    
    TuyaSmartDeviceModel *deviceModel = [self.meshDevList objectAtIndex:indexPath.row];
    
    TYDeviceViewController *vc = [[TYDeviceViewController alloc] initWithNibName:@"TYDeviceViewController" bundle:nil];
    vc.deviceModel = deviceModel;
    
    int address = [deviceModel.nodeId intValue] << 8;
    // 获取设备信息
    if ([TYBLEMeshManager sharedInstance].isLogin && deviceModel.isMeshBleOnline) {
        
        
        [[TYBLEMeshManager sharedInstance] getDeviceStatusAllWithAddress:address type:deviceModel.pcc];
    
    } else {
        NSString *raw = [[TYBLEMeshManager sharedInstance] rawDataGetStatusAllWithAddress:address type:deviceModel.pcc];
    
        [[TuyaSmartUser sharedInstance].mesh publishRawDataWithRaw:raw pcc:deviceModel.pcc success:^{
            NSLog(@"success");
        } failure:^(NSError *error) {
            NSLog(@"error %@", error);
        }];
    }
    
    
    [self.navigationController pushViewController:vc animated:YES];
    
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
    [self initData];
}


@end
