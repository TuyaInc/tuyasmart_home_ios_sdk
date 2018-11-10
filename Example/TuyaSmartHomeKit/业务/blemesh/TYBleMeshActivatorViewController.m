//
//  TYBleMeshActivatorViewController.m
//  TuyaSmartHomeKit_Example
//
//  Created by 黄凯 on 2018/11/10.
//  Copyright © 2018 xuchengcheng. All rights reserved.
//

#import "TYBleMeshActivatorViewController.h"
#import "TYHomeBLEActivatorTableViewCell.h"
#import "TYMeshBleActivatorSuccessViewController.h"

@interface TYBleMeshActivatorViewController () <TYBLEMeshManagerDelegate, UITableViewDelegate, UITableViewDataSource, TYBLEActivatorCellDelegate>

@property (nonatomic, strong) NSMutableArray<TYBleMeshDeviceModel *> *meshDevList; // mesh 设备
@property (nonatomic, strong) NSMutableArray<TYBleMeshDeviceModel *> *meshGatewayList; // mesh 网关

@property (nonatomic, strong) NSMutableDictionary *productInfo;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation TYBleMeshActivatorViewController

- (NSMutableArray<TYBleMeshDeviceModel *> *)meshDevList {
    if (!_meshDevList) {
        _meshDevList = [NSMutableArray array];
    }
    
    return _meshDevList;
}

- (NSMutableArray<TYBleMeshDeviceModel *> *)meshGatewayList {
    if (!_meshGatewayList) {
        _meshGatewayList = [NSMutableArray array];
    }
    
    return _meshGatewayList;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, APP_TOP_BAR_HEIGHT, APP_CONTENT_WIDTH, APP_VISIBLE_HEIGHT) style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = RGBCOLOR(248, 248, 248);
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
        [_tableView registerClass:[TYHomeBLEActivatorTableViewCell class] forCellReuseIdentifier:@"TYHomeBLEActivatorTableViewCell"];
    }
    
    return _tableView;
}

- (NSMutableDictionary *)productInfo {
    if (!_productInfo) {
        _productInfo = [NSMutableDictionary new];
    }
    
    return _productInfo;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [TPViewUtil simpleLabel:CGRectMake(0, APP_SCREEN_HEIGHT - APP_TAB_BAR_HEIGHT - 5, APP_SCREEN_WIDTH, 20) f:14 tc:RGBCOLOR(34, 36, 44) t:@"Scanning..."];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    
    [self.view addSubview:self.tableView];
    self.tableView.hidden = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self bleFlow];
    
    self.tableView.hidden = (_meshGatewayList.count == 0) && (_meshDevList.count == 0);
}

- (void)bleFlow {
    [TYBLEMeshManager sharedInstance].delegate = self;
    TuyaSmartHome *home = [TYHomeManager sharedInstance].home;
    
    if (!home.meshModel) {
        
        WEAKSELF_AT
        [[TYHomeManager sharedInstance].home getMeshListWithSuccess:^(NSArray<TuyaSmartBleMeshModel *> *list) {
            if (list.count > 0) {
                
                [TuyaSmartUser sharedInstance].meshModel = [TYHomeManager sharedInstance].home.meshModel;
                [TuyaSmartUser sharedInstance].mesh = [TuyaSmartBleMesh bleMeshWithMeshId:home.meshModel.meshId homeId:home.meshModel.homeId];
                
                // 开始扫描
                [weakSelf_AT checkBLEStatus];
            } else {
                NSTimeInterval interval = [[NSDate date] timeIntervalSince1970];
                NSString *meshName = [NSString stringWithFormat:@"tymesh%.0f", interval];
                [TuyaSmartBleMesh createBleMeshWithMeshName:meshName homeId:home.homeModel.homeId success:^(TuyaSmartBleMeshModel *meshModel) {
                    [TuyaSmartUser sharedInstance].meshModel = meshModel;
                    [TuyaSmartUser sharedInstance].mesh = [TuyaSmartBleMesh bleMeshWithMeshId:meshModel.meshId homeId:home.homeModel.homeId];
                    
                    // 开始扫描
                    [weakSelf_AT checkBLEStatus];
                } failure:^(NSError *error) {
                    [weakSelf_AT showMeshError:error];
                }];
            }
        } failure:^(NSError *error) {
              [self showMeshError:error];
        }];
    } else {
        // 开始扫描
        [self checkBLEStatus];
    }
}

- (void)showMeshError:(NSError *)error {
    UIAlertView *alert = [UIAlertView bk_showAlertViewWithTitle:error.localizedDescription message:nil cancelButtonTitle:NSLocalizedString(@"cancel_tip", @"") otherButtonTitles:nil handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
    }];
    [alert show];
}

- (void)checkBLEStatus {
    BOOL isPoweredOn = [TYBLEMeshManager sharedInstance].isPoweredOn;
    if (isPoweredOn) {
        [self startScan];
    } else {
        
        UIAlertView *_openBleAlertView = [UIAlertView bk_showAlertViewWithTitle:@"please open Bluetooth" message:nil cancelButtonTitle:@"ok" otherButtonTitles:nil handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
            
        }];
        [_openBleAlertView show];
    }
}

- (void)startScan {
    if ([TYBLEMeshManager sharedInstance].isPoweredOn) {
        [[TYBLEMeshManager sharedInstance] stopScan];
        [self.meshDevList removeAllObjects];
        [self.meshGatewayList removeAllObjects];
        [self.tableView reloadData];
        // 配网
        [[TYBLEMeshManager sharedInstance] startScanWithName:kInitMeshName pwd:@"123456" active:YES wifiAddress:0 otaAddress:0];
    }
}

- (void)getProductNameByProductId:(NSString *)productId {
    WEAKSELF_AT
    [[TYBLEMeshManager sharedInstance] getProductNameByProductId:productId completion:^(NSString *gotProductName) {
        
        if (gotProductName.length > 0) {
            [weakSelf_AT.productInfo setObject:gotProductName forKey:productId];
            [weakSelf_AT.tableView reloadData];
        }
    }];
}

#pragma mark UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return _meshGatewayList.count;;
    }
    
    return _meshDevList.count > 0 ? 1 : 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TYHomeBLEActivatorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TYHomeBLEActivatorTableViewCell" forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        
        cell.textLabel.text = @"mesh 网关设备";
        [cell updateState:YES];
    } else {
//        NSString *productId = _meshDevList.firstObject.productId;
        
//            NSString *productName = [self.productInfo objectForKey:productId];
            
        NSString *str = [NSString stringWithFormat:@"已扫描到 %lu 个设备", (unsigned long)_meshDevList.count];
        cell.textLabel.text = str;
        [cell updateState:YES];
    }
    cell.indexPath = indexPath;
    cell.delegate = self;
    
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self activeDevice:indexPath];
}


- (void)activeDevice:(NSIndexPath *)indexPath {
    // mesh 流程
    NSUInteger unActiveDeviceCount = 1;
    
    if (indexPath.section == 0) { // 蓝牙 mesh 网关
        TYBleMeshDeviceModel *model = [_meshGatewayList objectAtIndex:indexPath.row];
        [[TYBLEMeshManager sharedInstance] activeMeshDevice:model];
    } else { // 蓝牙 mesh 子设备
        unActiveDeviceCount = _meshDevList.count;
        [[TYBLEMeshManager sharedInstance] activeMeshDeviceIncludeGateway:NO];
    }
    [TYBLEMeshManager sharedInstance].delegate = nil;
    TYMeshBleActivatorSuccessViewController *vc = [[TYMeshBleActivatorSuccessViewController alloc] init];
    vc.unActiveDeviceCount = unActiveDeviceCount;
    vc.isChinese = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

/**
 扫描到待配网的设备
 
 @param manager mesh manager
 @param device 待配网设备信息
 */
- (void)bleMeshManager:(TYBLEMeshManager *)manager didScanedDevice:(TYBleMeshDeviceModel *)device {
    self.tableView.hidden = NO;
    if (device.type == [TPUtils getIntValueByHex:@"0x0108"] || ([TPUtils getIntValueByHex:[device.vendorInfo substringWithRange:NSMakeRange(0, 2)]] & 0x08) == 0x08) {
        [_meshGatewayList addObject:device];
        [self.tableView reloadData];
        return;
    }
    
    NSLog(@"🚀");
    [_meshDevList addObject:device];
    [self.tableView reloadData];
}

@end
