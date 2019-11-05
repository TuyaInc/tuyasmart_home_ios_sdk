//
//  TYDeviceHomeViewController.m
//  TuyaSmartHomeKit_Example
//
//  Created by 温明妍 on 2019/10/29.
//  Copyright © 2019 xuchengcheng. All rights reserved.
//

#import "TYDeviceHomeViewController.h"
#import <Masonry/Masonry.h>
#import "TYSmartHomeManager.h"
#import "TYDeviceListViewController.h"
#import "TYGroupListViewController.h"
#import "TYSmartHomeManager.h"
#import <TuyaSmartBLEMeshKit/TYBLEMeshManager.h>


@interface TYDeviceHomeViewController () <TuyaSmartHomeManagerDelegate,UIScrollViewDelegate,TYDeviceListViewControllerDelegate, TuyaSmartHomeManagerDelegate, TuyaSmartHomeDelegate,TYBLEMeshManagerDelegate>

@property (nonatomic, strong) UISegmentedControl *segmentControl;
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) TYDeviceListViewController *deviceListViewController;
@property (nonatomic, strong) TYGroupListViewController *groupListViewController;

@property (nonatomic, assign) BOOL isSegmentControlValueChange;

@property (nonatomic, strong) TuyaSmartHomeManager *homeManager;




@end

@implementation TYDeviceHomeViewController


#pragma mark - dealloc
#pragma mark - life cycle


- (void)initData {
    self.homeManager.delegate = self;
    [self reloadDataFromCloud];
}

- (void)initView {
    [self.view addSubview:self.segmentControl];
    [self.view addSubview:self.scrollView];
    [self.segmentControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(APP_TOP_BAR_HEIGHT);
        make.centerX.equalTo(self.view);
        make.height.mas_equalTo(35);
        make.width.mas_equalTo(APP_SCREEN_WIDTH - 20);
    }];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.segmentControl.mas_bottom).offset(3);
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.width.equalTo(self.view);
    }];
    
    self.segmentControl.selectedSegmentIndex = 0;
    if (TYSmartHomeManager.sharedInstance.currentHome.homeModel.name.length) {
        self.centerTitleItem.title = TYSmartHomeManager.sharedInstance.currentHome.homeModel.name;
    } else {
        self.centerTitleItem.title = NSLocalizedString(@"my_smart_home", @"");
    }
    self.topBarView.centerItem = self.centerTitleItem;
    self.topBarView.leftItem = [TPBarButtonItem titleItem:NSLocalizedString(@"ty_smart_switch_home", @"") target:self action:@selector(leftButtonTap)];
    self.rightTitleItem.title = @"Add home";
    self.topBarView.rightItem = self.rightTitleItem;
    
    [self addChildViewController:self.deviceListViewController];
    [self addChildViewController:self.groupListViewController];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initView];
//    TuyaSmartHome *home = TYSmartHomeManager.sharedInstance.currentHome;
//    [TuyaSmartUser sharedInstance].meshModel = home.meshModel;
    
//    [[TYBLEMeshManager sharedInstance] startScanWithName:home.meshModel.name pwd:home.meshModel.password active:NO wifiAddress:0 otaAddress:0];
//    TYBLEMeshManager.sharedInstance.delegate = self;
//    [[TuyaSmartSIGMeshManager sharedInstance] startScanWithScanType:ScanForProxyed meshModel:[TYSmartHomeManager sharedInstance].currentHome.sigMeshModel];
}

#pragma mark - TYBLEMeshManagerDelegate

- (void)bleMeshManager:(TYBLEMeshManager *)manager didScanedDevice:(TYBleMeshDeviceModel *)device {
    
}

#pragma mark - TYDeviceListViewControllerDelegate

- (void)controllerDidAddTestDevice:(TYDeviceListViewController *)controller {
    [self reloadDataFromCloud];
}

- (void)controllerNeedReloadData:(TYDeviceListViewController *)controller {
    [self reloadDataFromCloud];
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

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger index = scrollView.contentOffset.x / scrollView.size.width;
    
    if (self.segmentControl.selectedSegmentIndex != index && self.isSegmentControlValueChange == NO) {
        self.segmentControl.selectedSegmentIndex = index;
    }
}

#pragma mark - TuyaSmartHomeDelegate

// 家庭的信息更新，例如name
- (void)homeDidUpdateInfo:(TuyaSmartHome *)home {
    [self reloadData];
}

// 家庭和房间关系变化
- (void)homeDidUpdateRoomInfo:(TuyaSmartHome *)home {
    [self reloadData];
}

// 我收到的共享设备列表变化
- (void)homeDidUpdateSharedInfo:(TuyaSmartHome *)home {
    [self reloadData];
}

// 房间信息变更，例如name
- (void)home:(TuyaSmartHome *)home roomInfoUpdate:(TuyaSmartRoomModel *)room {
    [self reloadData];
}

// 房间与设备，群组的关系变化
- (void)home:(TuyaSmartHome *)home roomRelationUpdate:(TuyaSmartRoomModel *)room {
    [self reloadData];
}

// 添加设备
- (void)home:(TuyaSmartHome *)home didAddDeivice:(TuyaSmartDeviceModel *)device {
    [self reloadData];
}

// 删除设备
- (void)home:(TuyaSmartHome *)home didRemoveDeivice:(NSString *)devId {
    [self reloadData];
}

// 设备信息更新，例如name
- (void)home:(TuyaSmartHome *)home deviceInfoUpdate:(TuyaSmartDeviceModel *)device {
    [self reloadData];
}

// 设备dp数据更新
- (void)home:(TuyaSmartHome *)home device:(TuyaSmartDeviceModel *)device dpsUpdate:(NSDictionary *)dps {
    [self reloadData];
}

// 添加群组
- (void)home:(TuyaSmartHome *)home didAddGroup:(TuyaSmartGroupModel *)group {
    [self reloadData];
}

// 群组dp数据更新
- (void)home:(TuyaSmartHome *)home group:(TuyaSmartGroupModel *)group dpsUpdate:(NSDictionary *)dps {
    [self reloadData];
}

// 删除群组
- (void)home:(TuyaSmartHome *)home didRemoveGroup:(NSString *)groupId {
    [self reloadData];
}

// 群组信息更新，例如name
- (void)home:(TuyaSmartHome *)home groupInfoUpdate:(TuyaSmartGroupModel *)group {
    [self reloadData];
}

#pragma mark - Event Response

- (void)onValueChange {
    self.isSegmentControlValueChange = YES;
    [self.scrollView setContentOffset:CGPointMake(self.segmentControl.selectedSegmentIndex * self.scrollView.width, 0) animated:YES];
}
#pragma mark - Actions.

#pragma mark LeftButton
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
                TYSmartHomeManager.sharedInstance.currentHome.delegate = self;
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
            TYSmartHomeManager.sharedInstance.currentHome.delegate = weakSelf;
            weakSelf.centerTitleItem.title = [TYSmartHomeManager sharedInstance].currentHome.homeModel.name;
            weakSelf.topBarView.centerItem = self.centerTitleItem;
            [weakSelf reloadDataFromCloud];
        }];
        [homeListAC addAction:action];
    }
    
    UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {}];
    [homeListAC addAction:actionCancel];
    
    [self presentViewController:homeListAC animated:YES completion:nil];
}

#pragma mark RightButton
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

- (void)alertMessage:(NSString *)message {
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:message
                                                     message:nil
                                                    delegate:nil
                                           cancelButtonTitle:@"OK"
                                           otherButtonTitles:nil];
    [alert show];
}
#pragma mark - private methods

- (void)beginReload {
    [self.deviceListViewController beginReload];
}

- (void)reloadData {
    [self.deviceListViewController reloadData];
    [self.groupListViewController reloadData];
   

}
- (void)reloadDataFromCloud {
    [self showProgressView:NSLocalizedString(@"loading", @"")];
    
    WEAKSELF_AT
    [self beginReload];
    if (!TYSmartHomeManager.sharedInstance.currentHome) {
        [self hideProgressView];
        return;
    }
    [[TYSmartHomeManager sharedInstance].currentHome getHomeDetailWithSuccess:^(TuyaSmartHomeModel *homeModel) {
        [weakSelf_AT hideProgressView];
        TuyaSmartHome *home = TYSmartHomeManager.sharedInstance.currentHome;
        [TuyaSmartUser sharedInstance].meshModel = home.meshModel;
        [TuyaSmartUser sharedInstance].mesh = [TuyaSmartBleMesh bleMeshWithMeshId:home.meshModel.meshId homeId:homeModel.homeId];
        if (home.meshModel) {
            [[TYBLEMeshManager sharedInstance] startScanWithName:home.meshModel.name pwd:home.meshModel.password active:NO wifiAddress:0 otaAddress:0];
        }
        [[TuyaSmartSIGMeshManager sharedInstance] startScanWithScanType:ScanForProxyed meshModel:[TYSmartHomeManager sharedInstance].currentHome.sigMeshModel];
        [weakSelf_AT reloadData];
    } failure:^(NSError *error) {
        [weakSelf_AT hideProgressView];
        [weakSelf_AT reloadData];
    }];
}

#pragma mark - getters & setters & init members

- (UISegmentedControl *)segmentControl {
    if (!_segmentControl) {
        _segmentControl = [[UISegmentedControl alloc] initWithItems:@[@"Devices",@"Group"]];
        [_segmentControl addTarget:self action:@selector(onValueChange) forControlEvents:UIControlEventValueChanged];
    }
    return _segmentControl;
}

- (TYDeviceListViewController *)deviceListViewController {
    if (!_deviceListViewController) {
        _deviceListViewController = [[TYDeviceListViewController alloc] init];
        _deviceListViewController.vcDelegate = self;
    }
    return _deviceListViewController;
}

- (TYGroupListViewController *)groupListViewController {
    if (!_groupListViewController) {
        _groupListViewController = [[TYGroupListViewController alloc] init];
    }
    return _groupListViewController;
}
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;

        [_scrollView addSubview:self.deviceListViewController.view];
        [_scrollView addSubview:self.groupListViewController.view];
        
        [self.deviceListViewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(0));
            make.top.equalTo(@(0));
            make.height.equalTo(self.scrollView.mas_height);
            make.width.equalTo(self.scrollView);
        }];
        
        [self.groupListViewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.deviceListViewController.view.mas_right);
            make.top.equalTo(@(0));
            make.height.equalTo(self.scrollView.mas_height);
            make.width.equalTo(self.deviceListViewController.view.mas_width);
            make.right.equalTo(self.scrollView);
        }];
        
    }
    return _scrollView;
}

- (TuyaSmartHomeManager *)homeManager {
    if (!_homeManager) {
        _homeManager = [[TuyaSmartHomeManager alloc] init];
    }
    return _homeManager;
}

@end
