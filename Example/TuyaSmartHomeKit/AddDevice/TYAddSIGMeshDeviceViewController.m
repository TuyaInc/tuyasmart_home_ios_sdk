//
//  TYAddSIGMeshDeviceViewController.m
//  TuyaSmartHomeKit_Example
//
//  Created by 温明妍 on 2019/9/10.
//  Copyright © 2019 xuchengcheng. All rights reserved.
//

#import "TYAddSIGMeshDeviceViewController.h"
#import <Masonry/Masonry.h>
#import <TuyaSmartBLEMeshKit/TuyaSmartBLEMeshKit.h>
#import <TuyaSmartDeviceKit/TuyaSmartDeviceKit.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "TYDeviceListViewCell.h"
#import "TYSmartHomeManager.h"

#define kDESTableViewTag 2
#define kTableViewTag 1

@interface TYAddSIGMeshDeviceViewController () <TuyaSmartHomeManagerDelegate,UITableViewDelegate,UITableViewDataSource,TuyaSmartSIGMeshManagerDelegate>

@property (nonatomic, strong) UIButton *startBtn;
@property (nonatomic, strong) UIButton *addAllBtn; /**< add all device to mesh  */

@property (nonatomic, strong) TuyaSmartHomeManager *homeManager;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UITableView *desTableView; /**< show step  */

@property (nonatomic, strong) UILabel *topLabel;

@property (nonatomic, strong) NSMutableArray<TuyaSmartSIGMeshDiscoverDeviceInfo *> *discoveredDevices;
@property (nonatomic, strong) NSMutableArray<NSString *> *steps;

@end

@implementation TYAddSIGMeshDeviceViewController


#pragma mark - --------------------dealloc ------------------
#pragma mark - --------------------life cycle--------------------

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initView];
}

- (void)initData {
    self.topBarView.leftItem = self.leftBackItem;
    self.centerTitleItem.title = @"SIG Mesh Device";
    self.topBarView.centerItem = self.centerTitleItem;
    [TuyaSmartSIGMeshManager sharedInstance].delegate = self;
}

- (void)initView {
    [self.view addSubview:self.startBtn];
    [self.view addSubview:self.addAllBtn];
    [self.view addSubview:self.desTableView];
    [self.view addSubview:self.tableView];
    
    [self.startBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.width.equalTo(self.view).offset(-20).multipliedBy(0.5);
        make.top.mas_equalTo(20 + APP_TOP_BAR_HEIGHT);
        make.height.mas_equalTo(30);
    }];
    
    [self.addAllBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-10);
        make.width.equalTo(self.view).offset(-20).multipliedBy(0.5);
        make.top.mas_equalTo(20 + APP_TOP_BAR_HEIGHT);
        make.height.mas_equalTo(30);
    }];
    
    [self.desTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.startBtn.mas_bottom).offset(20);
        make.centerX.equalTo(self.view);
        make.width.equalTo(self.view).offset(-20);
        make.height.mas_equalTo(300);
    }];
    self.desTableView.layer.borderWidth = 1;
    self.desTableView.layer.borderColor = [UIColor redColor].CGColor;
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.desTableView.mas_bottom).offset(20);
        make.centerX.equalTo(self.view);
        make.width.equalTo(self.view).offset(-20);
        make.bottom.equalTo(self.view).offset(-20);
    }];
#if DEBUG
    self.tableView.layer.borderWidth = 1;
    self.tableView.layer.borderColor = [UIColor redColor].CGColor;
#endif
    
}


- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[TuyaSmartSIGMeshManager sharedInstance] stopActiveDevice];
}

#pragma mark - --------------------UITableViewDelegate--------------

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(UITableViewCell.class)];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                           reuseIdentifier:NSStringFromClass(TYDeviceListViewCell.class)];
    }
    if (tableView.tag == kDESTableViewTag) {
        NSString *str = [self.steps objectAtIndex:indexPath.row];
        cell.textLabel.text = str;
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.font = [UIFont systemFontOfSize:12];
    }
    if (tableView.tag == kTableViewTag) {
        TuyaSmartSIGMeshDiscoverDeviceInfo *device = [self.discoveredDevices objectAtIndex:indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"mac:%@",device.mac];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"pid:%@",device.productId];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == kDESTableViewTag) {
        return 25;
    }
    return 80;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView.tag == kDESTableViewTag) {
        return self.steps.count;
    }
    return self.discoveredDevices.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (tableView.tag == kDESTableViewTag) {
        return;
    }
    TuyaSmartSIGMeshDiscoverDeviceInfo *info = [self.discoveredDevices objectAtIndex:indexPath.row];
    [[TuyaSmartSIGMeshManager sharedInstance] startActive:@[info] meshModel:[TYSmartHomeManager sharedInstance].currentHome.sigMeshModel];
}

#pragma mark - --------------------TuyaSmartSIGMeshManagerDelegate--------------

- (void)sigMeshManager:(TuyaSmartSIGMeshManager *)manager
    didActiveSubDevice:(TuyaSmartSIGMeshDiscoverDeviceInfo *)device
                 devId:(NSString *)devId
                 error:(NSError *)error {
    if (error) {
        [self addItemAndReloadTableView:[NSString stringWithFormat:@"mac:%@ is fail,error: %@",device.mac,error]];
        return;
    }
    [self addItemAndReloadTableView:[NSString stringWithFormat:@"mac:%@ is success active!",device.mac]];
}

- (void)didFinishToActiveDevList {
    [self addItemAndReloadTableView:@"active device list finish!"];
}

- (void)sigMeshManager:(TuyaSmartSIGMeshManager *)manager
 didFailToActiveDevice:(TuyaSmartSIGMeshDiscoverDeviceInfo *)device
                 error:(NSError *)error {
    if (error) {
        [self addItemAndReloadTableView:[NSString stringWithFormat:@"active device.mac:%@ fail, error: %@",device.mac,error.domain]];
    }
}

- (void)sigMeshManager:(TuyaSmartSIGMeshManager *)manager
       didScanedDevice:(TuyaSmartSIGMeshDiscoverDeviceInfo *)device {
    [self addItemAndReloadTableView:[NSString stringWithFormat:@"NOW FIND A DEVICE mac:%@,pid:%@",device.mac,device.productId]];
    [self.discoveredDevices addObject:device];
    [self.tableView reloadData];
}


- (void)centralManagerStatusChange:(CBManagerState)status {
    switch (status) {
        case CBManagerStatePoweredOn:
            [self addItemAndReloadTableView:@"bluetooth power on"];
            break;
        case CBManagerStatePoweredOff:
            [self addItemAndReloadTableView:@"bluetooth power off"];
            break;
        case CBManagerStateUnsupported:
            [self addItemAndReloadTableView:@"bluetooth power unsupported"];
            break;
        case CBManagerStateResetting:
            [self addItemAndReloadTableView:@"bluetooth power reseting"];
            break;
        case CBManagerStateUnknown:
            [self addItemAndReloadTableView:@"bluetooth power unknown"];
            break;
            
        default:
            break;
    }
}

#pragma mark - --------------------Event Response--------------

- (BOOL)checkBlueTooth {
    BOOL isPowerOn = [TuyaSmartBLEManager sharedInstance].isPoweredOn;
    if (!isPowerOn) {
        [self addItemAndReloadTableView:@"please check bluetooth is power on"];
        [self addItemAndReloadTableView:@"check again"];
        isPowerOn = [TuyaSmartBLEManager sharedInstance].isPoweredOn;
    } else {
        [self addItemAndReloadTableView:@"now bluetooth is power on"];
    }
    return isPowerOn;
}


- (void)onClickAddAll {
    if (!self.discoveredDevices.count) {
        return;
    }
    [self addItemAndReloadTableView:@"start add all sig mesh device(s)"];
    [[TuyaSmartSIGMeshManager sharedInstance] startActive:self.discoveredDevices meshModel:[self currentHome].sigMeshModel];
}

- (void)onClickStartSearch {
    if (self.startBtn.isSelected) {
        [self addItemAndReloadTableView:@"stop search"];
        [[TuyaSmartSIGMeshManager sharedInstance] stopActiveDevice];
        self.startBtn.selected = NO;
        [self.discoveredDevices removeAllObjects];
        [self.tableView reloadData];
        return;
    }
    // start search
    if (![self checkBlueTooth]) {
        return;
    }
    
    if (![self currentHome]) {
        [self addItemAndReloadTableView:@"current account has no family, now fetch family from net"];
        [self.homeManager getHomeListWithSuccess:^(NSArray<TuyaSmartHomeModel *> *homes) {
            if (!homes.count) {
                [self addItemAndReloadTableView:@"please create a new home"];
            } else {
                TuyaSmartHomeModel *homeModel = [homes objectAtIndex:0];
                TuyaSmartHome *home = [TuyaSmartHome homeWithHomeId:homeModel.homeId];
                [TYSmartHomeManager sharedInstance].currentHome = home;
            }
            [self fetchMeshModel];
        } failure:^(NSError *error) {
            [self addItemAndReloadTableView:error.domain];
        }];

    } else {
        TuyaSmartHome *home = [self currentHome];
        [self addItemAndReloadTableView:[NSString stringWithFormat:@"curren home's name is %@",home.homeModel.name]];
        [self fetchMeshModel];
    }
}

- (void)fetchMeshModel {
    if (![self currentHome].sigMeshModel) {
        [self addItemAndReloadTableView:@"current has no meshModel, now create A meshModel"];
        //TODO: wmy weakify
//        @weakify(self);
        [TuyaSmartBleMesh createSIGMeshWithHomeId:[self currentHome].homeModel.homeId success:^(TuyaSmartBleMeshModel * _Nonnull meshModel) {
            [self addItemAndReloadTableView:@"meshModel create success"];
            [self startSearch];
        } failure:^(NSError *error) {
            [self addItemAndReloadTableView:error.domain];
        }];
    } else {
        [self addItemAndReloadTableView:@"current has meshModel"];
        [self startSearch];
    }
}

- (void)startSearch {
    self.startBtn.selected = YES;
    [self addItemAndReloadTableView:@"start search sig mesh device(s)"];
    [[TuyaSmartSIGMeshManager sharedInstance] startScanWithScanType:ScanForUnprovision meshModel:[self currentHome].sigMeshModel];
}

#pragma mark - --------------------private methods--------------

- (void)checkAndAddDevice:(TuyaSmartSIGMeshDiscoverDeviceInfo *)addDevice {
    BOOL canAdd = YES;
    for (TuyaSmartSIGMeshDiscoverDeviceInfo *device in self.discoveredDevices) {
        if ([device.mac isEqualToString:addDevice.mac]) {
            canAdd = NO;
            break;
        }
    }
    if (canAdd) {
        [self.discoveredDevices addObject:addDevice];
    }
    if (self.discoveredDevices.count) {
        self.addAllBtn.enabled = YES;
    } else {
        self.addAllBtn.enabled = NO;
    }
}
- (void)addItemAndReloadTableView:(NSString *)description {
    if (!description.length) {
        return;
    }
    [self.steps addObject:description];
    [self.desTableView reloadData];
}

#pragma mark - --------------------getters & setters & init members ------------------

- (TuyaSmartHome *)currentHome {
    return [TYSmartHomeManager sharedInstance].currentHome;
}

- (UIButton *)startBtn {
    if (!_startBtn) {
        _startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _startBtn.layer.cornerRadius = 5;
        _startBtn.backgroundColor = UIColor.orangeColor;
        [_startBtn setTitle:@"Start Search" forState:UIControlStateNormal];
        [_startBtn setTitle:@"Stop Search" forState:UIControlStateSelected];
        [_startBtn addTarget:self action:@selector(onClickStartSearch) forControlEvents:UIControlEventTouchUpInside];
    }
    return _startBtn;
}

- (UIButton *)addAllBtn {
    if (!_addAllBtn) {
        _addAllBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addAllBtn setTitle:@"AddAll" forState:UIControlStateNormal];
        [_addAllBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_addAllBtn setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
        _addAllBtn.layer.cornerRadius = 5;
        _addAllBtn.backgroundColor = UIColor.orangeColor;
        [_addAllBtn addTarget:self action:@selector(onClickAddAll) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addAllBtn;
}

- (TuyaSmartHomeManager *)homeManager {
    if (!_homeManager) {
        _homeManager = [[TuyaSmartHomeManager alloc] init];
        _homeManager.delegate = self;
    }
    return _homeManager;
}

- (UITableView *)desTableView {
    if (!_desTableView) {
        _desTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _desTableView.delegate = self;
        _desTableView.dataSource = self;
        _desTableView.separatorColor = [UIColor clearColor];
        _desTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _desTableView.backgroundColor = [UIColor clearColor];
        _desTableView.tag = kDESTableViewTag;
    }
    return _desTableView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.tag = kTableViewTag;
        _tableView.layer.borderWidth = 1;
        _tableView.layer.borderColor = [UIColor redColor].CGColor;
    }
    return _tableView;
}

- (UILabel *)topLabel {
    if (!_topLabel) {
        _topLabel = [[UILabel alloc] init];
    }
    return _topLabel;
}

- (NSMutableArray<NSString *> *)steps {
    if (!_steps) {
        _steps = [NSMutableArray<NSString *> array];
    }
    return _steps;
}

- (NSMutableArray<TuyaSmartSIGMeshDiscoverDeviceInfo *> *)discoveredDevices {
    if (!_discoveredDevices) {
        _discoveredDevices = [NSMutableArray<TuyaSmartSIGMeshDiscoverDeviceInfo *> array];
    }
    return _discoveredDevices;
}

@end
