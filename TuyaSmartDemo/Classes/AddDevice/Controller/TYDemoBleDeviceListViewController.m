//
//  TYBleDeviceListViewController.m
//  TuyaSmartHomeKit_Example
//
//  Created by milong on 2020/8/5.
//  Copyright © 2020 xuchengcheng. All rights reserved.
//

#import "TYDemoBleDeviceListViewController.h"
#import "TYBleDeviceCell.h"

@interface TYDemoBleDeviceListViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray<TuyaSmartSIGMeshDiscoverDeviceInfo *> *selectedMeshModelArray;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation TYDemoBleDeviceListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
}

- (void)setupUI {
    self.topBarView.leftItem = self.leftBackItem;
    
    self.topBarView.rightItem = self.rightTitleItem;
    self.centerTitleItem.title = @"Select BLE Mesh";
    self.topBarView.centerItem = self.centerTitleItem;
    [self.view addSubview:self.tableView];
    self.tableView.frame = CGRectMake(0, 64, APP_SCREEN_WIDTH, APP_SCREEN_HEIGHT);
    [self.tableView setEditing:YES animated:YES];
    
}

- (NSString *)titleForRightItem {
    return @"配网";
}

- (void)rightBtnAction{
    [[self.tableView indexPathsForSelectedRows] enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.row < self.meshModelArray.count) {
            [self.selectedMeshModelArray addObject:self.meshModelArray[obj.row]];
        }
    }];
    if (self.selectedDeviceBlock) {
        self.selectedDeviceBlock(self.selectedMeshModelArray);
    }
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark -- UITableView delegate and dataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.meshModelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TYBleDeviceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BleCell"];
    TuyaSmartSIGMeshDiscoverDeviceInfo *deviceInfo = self.meshModelArray[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"mac id:%@",deviceInfo.mac];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.isEditing) {
        return;
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
}


#pragma mark -- getter and seeter

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
        _tableView.dataSource      = self;
        _tableView.delegate        = self;
        [_tableView registerClass:[TYBleDeviceCell class] forCellReuseIdentifier:@"BleCell"];
    }
    return _tableView;
}

- (NSMutableArray<TuyaSmartSIGMeshDiscoverDeviceInfo *> *)selectedMeshModelArray {
    if (!_selectedMeshModelArray) {
        _selectedMeshModelArray = [NSMutableArray array];
    }
    return _selectedMeshModelArray;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
