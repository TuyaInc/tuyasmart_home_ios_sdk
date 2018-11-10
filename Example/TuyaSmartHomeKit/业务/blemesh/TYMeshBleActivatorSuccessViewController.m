//
//  TYMeshBleActivatorSuccessViewController.m
//  TuyaSmartKitExample
//
//  Created by 黄凯 on 2018/11/10.
//  Copyright © 2017年 tuya. All rights reserved.
//

#import "TYMeshBleActivatorSuccessViewController.h"
#import "TYActivatorTableViewCell.h"
#import "TYBLEScanView.h"
#import "TPWebViewController.h"

@interface TYMeshBleActivatorSuccessViewController () <UITableViewDataSource, UITableViewDelegate, TYBLEMeshManagerDelegate, TuyaSmartActivatorDelegate>

@property (nonatomic, strong) UILabel *addDeviceTitleLabel;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UIButton *doneButton;

@property (nonatomic, strong) NSMutableArray<TuyaSmartDeviceModel *> *devList;

@property (nonatomic, strong) NSTimer *scanTimer;

@end

@implementation TYMeshBleActivatorSuccessViewController {
    
    NSUInteger finishDeviceCount;
    NSUInteger failedDeviceCount;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _devList = [NSMutableArray array];
    
    [self initTopSubView];
    [self initDeviceListView];
    [self initBottomView];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(meshPairMeshRequestError) name:kNotificationPairMeshRequestError object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [TYBLEMeshManager sharedInstance].delegate = self;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [_scanTimer invalidate];
    _scanTimer = nil;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (NSString *)titleForCenterItem {
    return @"Add New Device";
}

- (void)initTopSubView {
    
    self.view.backgroundColor = [UIColor whiteColor];
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, APP_TOP_BAR_HEIGHT, APP_SCREEN_WIDTH, 192)];
    [self.view addSubview:topView];
    self.topView = topView;
    
    _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake((APP_SCREEN_WIDTH - 50) / 2, 60, 50, 50)];
    
    TYBLEScanView *scanView = [[TYBLEScanView alloc] initWithFrame:CGRectMake(0, 0 , 50, 50)];
    scanView.backgroundColor = [UIColor whiteColor];
    scanView.center = _iconImageView.center;
    [topView addSubview:scanView];
    
    [topView addSubview:_iconImageView];
    
    _addDeviceTitleLabel = [TPViewUtil simpleLabel:CGRectMake(50, 130, APP_SCREEN_WIDTH - 100, 24) f:20 tc:HEXCOLOR(0x4A4A4A) t:@"Add New Device"];
    _addDeviceTitleLabel.adjustsFontSizeToFitWidth = YES;
    _addDeviceTitleLabel.textAlignment = NSTextAlignmentCenter;
    [topView addSubview:_addDeviceTitleLabel];
    
    _scanTimer = [NSTimer scheduledTimerWithTimeInterval:90 target:self selector:@selector(scanTimeout) userInfo:nil repeats:NO];
}

- (void)initDeviceListView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(_topView.frame), APP_SCREEN_WIDTH - 30, APP_VISIBLE_HEIGHT - 128 - self.topView.frame.size.height) style:UITableViewStylePlain];
    _tableView.backgroundColor = HEXCOLOR(0xF9F9F9);
    _tableView.separatorStyle = NO;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    [_tableView reloadData];
}

- (void)initBottomView {
    _doneButton = [TPViewUtil buttonWithFrame:CGRectMake(15, APP_SCREEN_HEIGHT - 44 - 30, APP_SCREEN_WIDTH - 30, 44) fontSize:16 bgColor:BUTTON_BACKGROUND_COLOR textColor:BUTTON_TEXT_COLOR];
    if ([TYBLEMeshManager sharedInstance].isWifiDevice) {
        [_doneButton setTitle:@"Next" forState:UIControlStateNormal];
    } else {
        [_doneButton setTitle:@"Done" forState:UIControlStateNormal];
    }
    [_doneButton addTarget:self action:@selector(doneAction:) forControlEvents:UIControlEventTouchUpInside];
    
    _doneButton.enabled = NO;
    [self.view addSubview:_doneButton];
}

- (void)reloadData {
    
    NSString *titleText = @"";
    NSString *doneButtonText = @"";
    
    if (finishDeviceCount == 0) {
        _doneButton.enabled = NO;
        titleText = @"设备添加成功";
        doneButtonText = @"Done";
    } else if (finishDeviceCount <= self.unActiveDeviceCount) {
        NSString *progress = [NSString stringWithFormat:@"%d/%d", (int)finishDeviceCount, (int)self.unActiveDeviceCount];
        titleText = [NSString stringWithFormat:@"已完成添加 %@", progress];
        doneButtonText = finishDeviceCount == self.unActiveDeviceCount ? @"Done" : @"Stop Now";
        _doneButton.enabled = YES;
    } else {
        NSLog(@"出错: finsh %d === unactive %d", (int)finishDeviceCount, (int)self.unActiveDeviceCount);
        return;
    }
    
    _addDeviceTitleLabel.text = titleText;
    [_doneButton setTitle:doneButtonText forState:UIControlStateNormal];
    [_tableView reloadData];
}

- (void)scanTimeout {
    _addDeviceTitleLabel.text = @"添加失败";
    _doneButton.enabled = YES;
}

- (IBAction)doneAction:(UIButton *)sender {
    
    if (failedDeviceCount != 0) {
        WEAKSELF_AT
        NSString *message = [NSString stringWithFormat:@"%lu 操作失败", (unsigned long)failedDeviceCount];
        UIAlertView *alert = [UIAlertView bk_showAlertViewWithTitle:message message:nil cancelButtonTitle:@"cancel" otherButtonTitles:@[@"go"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
            if (buttonIndex == 1) {
                NSString *helpUrl = @"https://smartapp.tuya.com/faq/mesh4";
                TPWebViewController *vc = [[TPWebViewController alloc] initWithUrlString:helpUrl];
                [weakSelf_AT.navigationController pushViewController:vc animated:YES];
            } else {
                [weakSelf_AT finish];
            }
        }];
        [alert show];
        return;
    }
    
    [self finish];
}

- (void)finish {
    if (_devList.count == 0) {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    
    if ([TYBLEMeshManager sharedInstance].isWifiDevice) {
        
        if (_devList.count == 1) {
            
            // 开始配置网关
            
            // 4. 获取 token
            NSString *nodeId = [NSString stringWithFormat:@"%02x", (int)_devList.firstObject.nodeId];
            
            [[TuyaSmartActivator sharedInstance] getTokenWithMeshId:[TuyaSmartUser sharedInstance].meshModel.meshId
                                                             nodeId:nodeId
                                                          productId:[TYBLEMeshManager sharedInstance].productId
                                                               uuid:[TYBLEMeshManager sharedInstance].uuid
                                                            authKey:[TYBLEMeshManager sharedInstance].authKey
                                                            version:[TYBLEMeshManager sharedInstance].version
                                                            success:^(NSString *token) {
                
                // 5. 设置配网代理，通过代理接收激活结果
                [TuyaSmartActivator sharedInstance].delegate = self;
                // 6. 开始 Wi-Fi 配网
                [[TuyaSmartActivator sharedInstance] startBleMeshConfigWiFiWithSsid:@"Wi-Fi 名称" password:@"Wi-Fi 密码" token:token timeout:100];
                
                
            } failure:^(NSError *error) {
                NSLog(@"error: %@", error);
            }];
            
            
            
        }
    } else {
        
        [self showProgressView];
        [[TYBLEMeshManager sharedInstance] startScanWithName:[TuyaSmartUser sharedInstance].meshModel.code pwd:[TuyaSmartUser sharedInstance].meshModel.password active:NO wifiAddress:0 otaAddress:0];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self hideProgressView];
            
             [self.navigationController popViewControllerAnimated:YES];
        });
    }
}

- (IBAction)renameButtonClicked:(UIButton *)sender {
    
    TuyaSmartDeviceModel *deviceModel = _devList[sender.tag - 1];
    
    UIAlertView *alertView = [UIAlertView bk_alertViewWithTitle:@"rename" message:nil];
    [alertView bk_setCancelButtonWithTitle:NSLocalizedString(@"cancel", @"") handler:nil];
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    UITextField *textField = [alertView textFieldAtIndex:0];
    textField.text = deviceModel.name;
    
    WEAKSELF_AT
    [alertView bk_addButtonWithTitle:NSLocalizedString(@"save", @"") handler:^{
        NSString *deviceName = textField.text;
        if (deviceName.length == 0) {
            [TPProgressUtils showError:@"name is empty"];
        } else if (deviceName.length > 25) {
            [TPProgressUtils showError:@"name is too long"];
        } else {
            [weakSelf_AT doModifyDeviceName:deviceName devId:deviceModel.devId row:(sender.tag - 1)];
        }
    }];
    
    [alertView show];
}

- (void)doModifyDeviceName:(NSString *)name devId:(NSString *)devId row:(NSInteger)row {
    [self showProgressView];
    
    WEAKSELF_AT
    
    [[TuyaSmartUser sharedInstance].mesh renameMeshSubDeviceWithDeviceId:devId name:name success:^{
        
        [weakSelf_AT hideProgressView];
        TuyaSmartDeviceModel *deviceModel = weakSelf_AT.devList[row];
        deviceModel.name = name;
        [weakSelf_AT.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:row inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
        
    } failure:^(NSError *error) {
        [weakSelf_AT hideProgressView];
        [TPProgressUtils showError:error];
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _devList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 75;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TYActivatorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[TYActivatorTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        [cell.renameButton addTarget:self action:@selector(renameButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    cell.renameButton.tag = indexPath.row + 1;
    
    TuyaSmartDeviceModel *deviceModel = [_devList objectAtIndex:indexPath.row];
    TuyaSmartDeviceModel *model = [[TuyaSmartDeviceModel alloc] init];
    model.name = deviceModel.name;
    [cell setDeviceModel:model error:nil];
    cell.renameButton.hidden = [TYBLEMeshManager sharedInstance].isWifiDevice;
    
    return cell;
}

#pragma mark - TYBLEMeshManagerDelegate

- (void)activeDeviceSuccessWithName:(NSString *)name deviceId:(NSString *)deviceId error:(NSError *)error {
    finishDeviceCount++;
    
    if (error) {
        failedDeviceCount++;
        [self reloadData];
        return;
    }
    
    TuyaSmartDeviceModel *model = [[TuyaSmartDeviceModel alloc] init];
    model.devId = deviceId;
    model.name = name;
    _doneButton.enabled = YES;
    
    BOOL hasDevice = NO;
    for (TuyaSmartDeviceModel *model in _devList) {
        if ([model.devId isEqualToString:deviceId]) {
            hasDevice = YES;
        }
    }
    if (!hasDevice) {
        [_devList addObject:model];
    }
    
    [_scanTimer invalidate];
    _scanTimer = nil;
    
    [self reloadData];
}

- (void)activeWifiDeviceWithName:(NSString *)name address:(NSInteger)address mac:(NSInteger)mac error:(NSError *)error {
    finishDeviceCount++;
    
    if (error) {
        failedDeviceCount++;
        [self reloadData];
        return;
    }
    
    TuyaSmartDeviceModel *model = [[TuyaSmartDeviceModel alloc] init];
    model.name = @"mesh 网关";
    model.nodeId = [NSString stringWithFormat:@"%02x", (int)address];
    
    WEAKSELF_AT
    [[TYBLEMeshManager sharedInstance] getProductNameByProductId:[TYBLEMeshManager sharedInstance].productId completion:^(NSString *gotProductName) {
        
        if (gotProductName.length > 0) {
            model.name = gotProductName;
            [weakSelf_AT reloadData];
        }
    }];
    
    [_devList addObject:model];
    [self reloadData];
    _doneButton.enabled = YES;
    
    // 用户输入密码再去重连，重连成功后再发送ssid,pwd,token
    [TYBLEMeshManager sharedInstance].wifiAddress = (int)mac;
}

#pragma mark - meshPairMeshRequestError notify

- (void)meshPairMeshRequestError {
    WEAKSELF_AT
    UIAlertView *alert = [UIAlertView bk_showAlertViewWithTitle:@"network_error" message:nil cancelButtonTitle:@"cancel" otherButtonTitles:nil handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
        [weakSelf_AT.navigationController popViewControllerAnimated:YES];
    }];
    [alert show];
}


#pragma mark - TuyaSmartActivatorDelegate

- (void)meshActivator:(TuyaSmartActivator *)activator didReceiveDeviceId:(NSString *)deviceId meshId:(NSString *)meshId error:(NSError *)error {
    // 7. 收到激活结果
    
    NSLog(@"success ---- %@ --- %@  ---  %@", deviceId, meshId, error);
}

@end

