//
//  TYDeviceGroupViewController.m
//  TuyaSmartHomeKit_Example
//
//  Created by 温明妍 on 2019/9/11.
//  Copyright © 2019 xuchengcheng. All rights reserved.
//

#import "TYDeviceGroupViewController.h"
#import <Masonry/Masonry.h>
#import <TuyaSmartBLEMeshKit/TuyaSmartBLEMeshKit.h>
#import "TYSmartHomeManager.h"
#import "TYDeviceListViewCell.h"

@interface TYDeviceGroupViewController () <UITableViewDelegate,UITableViewDataSource,TuyaSmartSIGMeshManagerDelegate>

@property (nonatomic, strong) NSMutableArray<TuyaSmartDevice *> *selectDevices;
@property(nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) NSMutableArray<TuyaSmartDevice *> *unselectedDevices;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) NSInteger address;
@property (nonatomic, strong) TuyaSmartBleMeshGroup *group;

@property (nonatomic, strong) NSString *pcc;

@end

@implementation TYDeviceGroupViewController


#pragma mark - --------------------dealloc ------------------
#pragma mark - --------------------life cycle--------------------

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initView];
}

- (void)initData {
    // 根据device的pid搜索家庭中的设备
    
    for (TuyaSmartDeviceModel *deviceModel in [[TYSmartHomeManager sharedInstance] currentHome].deviceList) {
        if ([deviceModel.pcc isEqualToString:self.device.deviceModel.pcc]) {
            TuyaSmartDevice *device = [TuyaSmartDevice deviceWithDeviceId:deviceModel.devId];
            [self.unselectedDevices addObject:device];
        }
    }
    [TuyaSmartSIGMeshManager sharedInstance].delegate = self;
    [self.tableView reloadData];
}

- (void)initView {
    self.topBarView.leftItem = self.leftBackItem;
    self.topBarView.rightItem = self.rightTitleItem;
    self.rightTitleItem.title = NSLocalizedString(@"finish", @"");;
    self.centerTitleItem.title = NSLocalizedString(@"add_group", @"");
    self.topBarView.centerItem = self.centerTitleItem;
    
    [self.tableView registerClass:TYDeviceListViewCell.class forCellReuseIdentifier:NSStringFromClass(TYDeviceListViewCell.class)];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(APP_TOP_BAR_HEIGHT);
        make.left.right.bottom.equalTo(self.view);
    }];
}

#pragma mark - --------------------UITableViewDelegate--------------

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 0, APP_SCREEN_WIDTH, 44);
    UILabel *label = [[UILabel alloc] init];
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.centerY.equalTo(view);
    }];
    if (section == 0) {
        label.text = @"already added";
    }
    if (section == 1) {
        label.text = @"can add";
    }
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TYDeviceListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(TYDeviceListViewCell.class)];
    if (!cell) {
        cell = [[TYDeviceListViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                           reuseIdentifier:NSStringFromClass(TYDeviceListViewCell.class)];
    }
    TuyaSmartDevice *device;
    if (indexPath.section == 0) {
        device = [self.selectDevices objectAtIndex:indexPath.row];
        
    }
    if (indexPath.section == 1) {
        device = [self.unselectedDevices objectAtIndex:indexPath.row];
    }
    [cell setItem:device.deviceModel];
    return cell;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleInsert | UITableViewCellEditingStyleDelete;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.selectDevices.count;
    }
    if (section == 1) {
        return self.unselectedDevices.count;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        TuyaSmartDevice *device = [self.selectDevices objectAtIndex:indexPath.row];
        [self.unselectedDevices addObject:device];
        [self.selectDevices removeObject:device];
    }
    if (indexPath.section == 1) {
        TuyaSmartDevice *device = [self.unselectedDevices objectAtIndex:indexPath.row];
        [self.selectDevices addObject:device];
        [self.unselectedDevices removeObject:device];
    }
    [self.tableView reloadData];
}

#pragma mark - --------------------TuyaSmartSIGMeshManagerDelegate--------------

- (void)sigMeshManager:(TuyaSmartSIGMeshManager *)manager didHandleGroupWithGroupAddress:(NSString *)groupAddress deviceNodeId:(NSString *)nodeId error:(NSError *)error {
    NSLog(@"❤❤❤❤❤❤❤ = %@ is add to group :%@",nodeId,groupAddress);
    WEAKSELF_AT
    TuyaSmartDevice *device = [self.selectDevices objectAtIndex:self.currentIndex];
    [self.group addDeviceWithDeviceId:device.deviceModel.devId success:^{
        weakSelf_AT.currentIndex++;
        [weakSelf_AT calculateNeedHandleDevices];
    } failure:^(NSError *error) {
        [TPProgressUtils showError:error];
    }];
}

#pragma mark - --------------------Event Response--------------

- (void)rightBtnAction {
    // 添加群组
    [self createGroup];
    
}

- (void)createGroup {
    WEAKSELF_AT
    [TuyaSmartBleMeshGroup
     getBleMeshGroupAddressFromCluondWithMeshId:[TYSmartHomeManager sharedInstance].currentHome.sigMeshModel.meshId
     success:^(int result) {
         NSInteger address = result + 0x4000;
         self.address = address;
         [weakSelf_AT newMeshGroupHandle];
     } failure:^(NSError *error) {
         [TPProgressUtils showError:error.localizedDescription];
     }];
}


- (void)newMeshGroupHandle{
    NSInteger benchmark = 49153;
    NSInteger count = self.address - benchmark;
    NSString *groupName = [NSString stringWithFormat:@"BLE Mesh %@%ld", @"SIG_MESH_GROUP", ((long)count + 1) / 8];
    [TPProgressUtils showSuccess:[NSString stringWithFormat:@"%@ now is creating",groupName]
                          toView:[UIApplication sharedApplication].keyWindow];
    [self saveNewGroupWithName:groupName];
}

- (void)saveNewGroupWithName:(NSString *)name {
    // 先新建群组在添加设备
    WEAKSELF_AT
    [TuyaSmartBleMeshGroup createMeshGroupWithGroupName:name
                                                 meshId:[TYSmartHomeManager sharedInstance].currentHome.sigMeshModel.meshId
                                                localId:[NSString stringWithFormat:@"%lx", self.address]
                                                    pcc:self.device.deviceModel.pcc
                                                success:^(int result) {
                                                    TuyaSmartBleMeshGroup *group = [TuyaSmartBleMeshGroup meshGroupWithGroupId:result];
                                                    weakSelf_AT.group = group;
                                                    [weakSelf_AT calculateNeedHandleDevices];
                                                } failure:^(NSError *error) {
                                                    [TPProgressUtils showError:error];
                                                }];
}

- (void)calculateNeedHandleDevices {
    if (self.currentIndex < self.selectDevices.count) {
        TuyaSmartDevice *device = [self.selectDevices objectAtIndex:self.currentIndex];
        [self handleAddDevice:device.deviceModel];
    }
}




- (void)handleAddDevice:(TuyaSmartDeviceModel *)deviceModel {
    if (deviceModel.isMeshBleOnline && deviceModel.isMeshBleOnline) {
        // ble
        [[TuyaSmartSIGMeshManager sharedInstance] addDeviceToGroupWithDevId:deviceModel.devId
                                                               groupAddress:[self.group.meshGroupModel.localId intValue]];
    }
}

#pragma mark - --------------------private methods--------------
#pragma mark - --------------------getters & setters & init members ------------------

- (NSMutableArray<TuyaSmartDevice *> *)unselectedDevices {
    if (!_unselectedDevices) {
        _unselectedDevices = [NSMutableArray<TuyaSmartDevice *> array];
    }
    return _unselectedDevices;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
#if DEBUG
        _tableView.layer.borderWidth = 1;
        _tableView.layer.borderColor = [UIColor redColor].CGColor;
#endif
    }
    return _tableView;
}

- (NSMutableArray<TuyaSmartDevice *> *)selectDevices {
    if (!_selectDevices) {
        _selectDevices = [NSMutableArray<TuyaSmartDevice *> array];
    }
    return _selectDevices;
}

@end
