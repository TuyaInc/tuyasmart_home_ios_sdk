//
//  TYDeviceGroupViewController.m
//  TuyaSmartHomeKit_Example
//
//  Created by 温明妍 on 2019/9/11.
//  Copyright © 2019 xuchengcheng. All rights reserved.
//

#import "TYDeviceGroupViewController.h"
#import <Masonry/Masonry.h>
#import <TuyaSmartDeviceKit/TuyaSmartDeviceKit.h>
#import <TuyaSmartBLEMeshKit/TuyaSmartBLEMeshKit.h>
#import "TYSmartHomeManager.h"
#import "TYDeviceListViewCell.h"

@interface TYDeviceGroupViewController () <UITableViewDelegate,UITableViewDataSource,TuyaSmartSIGMeshManagerDelegate>

@property (nonatomic, strong) NSMutableArray<TuyaSmartDevice *> *selectDevices;
@property(nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) NSMutableArray<TuyaSmartDevice *> *unselectedDevices;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) NSInteger address;
@property (nonatomic, strong) TuyaSmartBleMeshGroup *meshGroup;
@property (nonatomic, strong) TuyaSmartGroup *group;

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
    // 创建群组的选择页面
    if (self.device.deviceModel.deviceType == TuyaSmartDeviceModelTypeSIGMeshSubDev ||
        self.device.deviceModel.deviceType == TuyaSmartDeviceModelTypeMeshBleSubDev) {
        // sigmesh设备
        [TuyaSmartSIGMeshManager sharedInstance].delegate = self;
        for (TuyaSmartDeviceModel *deviceModel in [[TYSmartHomeManager sharedInstance] currentHome].deviceList) {
            if ([deviceModel.pcc isEqualToString:self.device.deviceModel.pcc]) {
                TuyaSmartDevice *device = [TuyaSmartDevice deviceWithDeviceId:deviceModel.devId];
                if ([device.deviceModel.devId isEqualToString:self.device.deviceModel.devId]) {
                    [self.selectDevices addObject:device];
                } else {
                    [self.unselectedDevices addObject:device];
                }
            }
        }
        [self.tableView reloadData];
    } else if (self.device.deviceModel.deviceType == TuyaSmartDeviceModelTypeWifiDev ||
               self.device.deviceModel.deviceType == TuyaSmartDeviceModelTypeWifiSubDev ) {
        //WIFI设备
        [self showProgressView:NSLocalizedString(@"loading", @"")];
        WEAKSELF_AT
        [TuyaSmartGroup getDevList:self.device.deviceModel.productId
                            homeId:self.device.deviceModel.homeId
                           success:^(NSArray<TuyaSmartGroupDevListModel *> * _Nonnull list) {
            [weakSelf_AT addWifiToSelectDevice:list];
            [weakSelf_AT hideLoadingView];
        } failure:^(NSError *error) {
            [TPProgressUtils showError:error];
            [weakSelf_AT hideLoadingView];
        }];
    } else if (self.device.deviceModel.deviceType == TuyaSmartDeviceModelTypeZigbeeSubDev) {
        WEAKSELF_AT
        [self addWifiToSelectDevice:@[self.device]];
        [TuyaSmartGroup getDevListWithProductId:self.device.deviceModel.productId
                                           gwId:self.device.deviceModel.devId
                                         homeId:self.device.deviceModel.homeId
                                        success:^(NSArray<TuyaSmartGroupDevListModel *> * _Nonnull deviceList) {
            [weakSelf_AT addWifiToSelectDevice:deviceList];
            [weakSelf_AT hideLoadingView];
        } failure:^(NSError *error) {
            [TPProgressUtils showError:error];
            [weakSelf_AT hideLoadingView];
        }];
    }
}

- (void)addWifiToSelectDevice:(NSArray<TuyaSmartGroupDevListModel *> *)list {
    for (TuyaSmartGroupDevListModel *model in list) {
        TuyaSmartDevice *device = [TuyaSmartDevice deviceWithDeviceId:model.devId];
        if ([model.devId isEqualToString:self.device.deviceModel.devId]) {
            [self.selectDevices addObject:device];
        } else {
            [self.unselectedDevices addObject:device];
        }
    }
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
//    NSLog(@"❤❤❤❤❤❤❤ = %@ is add to group :%@",nodeId,groupAddress);
    WEAKSELF_AT
    TuyaSmartDevice *device = [self.selectDevices objectAtIndex:self.currentIndex];
    [self.meshGroup addDeviceWithDeviceId:device.deviceModel.devId success:^{
        weakSelf_AT.currentIndex++;
        [weakSelf_AT calculateNeedHandleDevices];
    } failure:^(NSError *error) {
        [TPProgressUtils showError:error];
    }];
}

#pragma mark - --------------------Event Response--------------

- (void)rightBtnAction {
    // 添加群组
    if (self.device.deviceModel.deviceType == TuyaSmartDeviceModelTypeSIGMeshSubDev) {
        [self createGroup];
    } else if (self.device.deviceModel.deviceType == TuyaSmartDeviceModelTypeWifiDev ||
               self.device.deviceModel.deviceType == TuyaSmartDeviceModelTypeWifiSubDev ||
               self.device.deviceModel.deviceType == TuyaSmartDeviceModelTypeZigbeeSubDev) {
        [self invokeCreateGroup];
    } else if (self.device.deviceModel.deviceType == TuyaSmartDeviceModelTypeMeshBleSubDev) {
        NSString *meshId = [TuyaSmartUser sharedInstance].meshModel.meshId;
        WEAKSELF_AT
        [TuyaSmartBleMeshGroup getBleMeshGroupAddressFromCluondWithMeshId:meshId success:^(int result) {
            NSInteger address = result;
            [weakSelf_AT newMeshGroupHandle:address benchmark:32769 isSIGMesh:NO];
        } failure:^(NSError *error) {
            [TPProgressUtils showError:error.localizedDescription];
        }];
    }
    
}

- (void)newMeshGroupHandle:(NSInteger)address benchmark:(NSInteger)benchmark isSIGMesh:(BOOL)isSIGMesh {
    
    WEAKSELF_AT
    //保存
    UIAlertView *alertView = [UIAlertView bk_alertViewWithTitle:NSLocalizedString(@"group_rename_dialog_title", @"") message:nil];
//    [alertView bk_setCancelButtonWithTitle:NSLocalizedString(@"cancel", @"") handler:^{
//        [weakSelf_AT.meshGroup deleteBleMeshGroupAddress:address];
//    }];
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    UITextField *textField = [alertView textFieldAtIndex:0];
    NSInteger count = address - benchmark;
    NSString *groupName = [NSString stringWithFormat:@"%@%ld", NSLocalizedString(@"group_item_flag", @""), (long)count + 1];
    
    if (isSIGMesh) {
        groupName = [NSString stringWithFormat:@"BLE Mesh %@%ld", NSLocalizedString(@"group_item_flag", @""), ((long)count + 1) / 8];
    }
    textField.text = groupName;
    [alertView bk_addButtonWithTitle:NSLocalizedString(@"save", @"") handler:^{
        NSString *deviceName = textField.text;
        TuyaSmartBleMeshGroup *meshGroup = [TuyaSmartBleMeshGroup meshGroupWithGroupId:0];
        if (deviceName.length == 0) {
            [TPProgressUtils showError:NSLocalizedString(@"group_add_name_empty", @"")];
            [meshGroup deleteBleMeshGroupAddress:address];
        } else if (deviceName.length > 25) {
            [TPProgressUtils showError:NSLocalizedString(@"ty_modify_group_name_length_limit", @"")];
            [meshGroup deleteBleMeshGroupAddress:address];
        } else {
            [weakSelf_AT saveNewGroupWithName:deviceName address:address];
        }
    }];
    
    [alertView show];
}

- (void)saveNewGroupWithName:(NSString *)name address:(NSInteger)address {
    // 先新建群组在添加设备
    WEAKSELF_AT
    [TuyaSmartBleMeshGroup createMeshGroupWithGroupName:name meshId:[TuyaSmartUser sharedInstance].meshModel.meshId localId:[NSString stringWithFormat:@"%lx", (long)address] pcc:_pcc success:^(int result) {
        [weakSelf_AT calculateNeedHandleDevices];
    } failure:^(NSError *error) {
        [TPProgressUtils showError:error];
    }];
}

- (void)invokeCreateGroup {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"add group" message:@"please input group name" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        
    }];
    WEAKSELF_AT
    UIAlertAction *finish = [UIAlertAction actionWithTitle:@"finish" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSString *text = alertController.textFields.firstObject.text;
        if (text.length) {
            [weakSelf_AT fetchCreateGroupWithName:text];
        }
    }];
    [alertController addAction:finish];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:cancel];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)fetchCreateGroupWithName:(NSString *)text {
    WEAKSELF_AT
    NSMutableArray<NSString *> *deviceIds = [NSMutableArray<NSString *> array];
    for (TuyaSmartDevice *device in self.selectDevices) {
        [deviceIds addObject:device.deviceModel.devId];
    }
    if (self.device.deviceModel.deviceType == TuyaSmartDeviceModelTypeZigbeeSubDev) {
        [TuyaSmartGroup createGroupWithName:text
                                     homeId:self.device.deviceModel.homeId
                                       gwId:self.device.deviceModel.devId
                                  productId:self.device.deviceModel.productId
                                    success:^(TuyaSmartGroup * _Nonnull group) {
            if (group) {
                self.group = group;
                [self.group addZigbeeDeviceWithNodeList:deviceIds success:^{
                    [TPProgressUtils showSuccess:@"success" toView:weakSelf_AT.view];
                    [weakSelf_AT.navigationController popViewControllerAnimated:YES];
                } failure:^(NSError *error) {
                    [TPProgressUtils showSuccess:@"failure" toView:weakSelf_AT.view];
                }];
            }
        } failure:^(NSError *error) {
            [TPProgressUtils showSuccess:@"failure" toView:weakSelf_AT.view];
        }];

    } else {
        
    }
    
    [TuyaSmartGroup createGroupWithName:text
                              productId:self.device.deviceModel.productId
                                 homeId:TYSmartHomeManager.sharedInstance.currentHome.homeModel.homeId
                              devIdList:deviceIds
                                success:^(TuyaSmartGroup * _Nonnull group) {
        if (group) {
            [TPProgressUtils showSuccess:@"success" toView:weakSelf_AT.view];
            [weakSelf_AT.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSError *error) {
        
    }];
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
                                                localId:[NSString stringWithFormat:@"%lx", (long)self.address]
                                                    pcc:self.device.deviceModel.pcc
                                                success:^(int result) {
                                                    TuyaSmartBleMeshGroup *group = [TuyaSmartBleMeshGroup meshGroupWithGroupId:result];
                                                    weakSelf_AT.meshGroup = group;
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
    if (deviceModel.deviceType == TuyaSmartDeviceModelTypeSIGMeshSubDev) {
        if (deviceModel.isMeshBleOnline && deviceModel.isMeshBleOnline) {
            // ble
            [[TuyaSmartSIGMeshManager sharedInstance] addDeviceToGroupWithDevId:deviceModel.devId
                                                                   groupAddress:[self.meshGroup.meshGroupModel.localId intValue]];
        }
    }
    if (deviceModel.deviceType == TuyaSmartDeviceModelTypeMeshBleSubDev) {
        int nodeId = [deviceModel.nodeId intValue] << 8;
        [[TYBLEMeshManager sharedInstance] addDeviceAddress:nodeId >> 8
                                                       type:self.meshGroup.meshGroupModel.pcc
                                               groupAddress:[self.meshGroup.meshGroupModel.localId intValue]];
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
