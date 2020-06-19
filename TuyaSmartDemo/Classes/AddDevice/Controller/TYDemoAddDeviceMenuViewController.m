//
//  TYAddDeviceMenuViewController.m
//  TuyaSmartHomeKit_Example
//
//  Created by 盖剑秋 on 2018/11/15.
//  Copyright © 2018 xuchengcheng. All rights reserved.
//

#import "TYDemoAddDeviceMenuViewController.h"
#import "TYDemoAPAddDeviceViewController.h"
#import "TYDemoEZAddDeviceViewController.h"
#import "TYDemoAddZigBeeViewController.h"

typedef NS_ENUM(NSInteger, AddDeviceMode) {
    AddDeviceModeEZ,
    AddDeviceModeAP,
    AddZigBeeGateway,
    AddZigBeeSubdevice,
    AddDeviceSIGMesh,
    AddDeviceModeCount,
};

/*
 doc link
 
 en:https://tuyainc.github.io/tuyasmart_home_ios_sdk_doc/en/resource/Activator.html#network-configuration
 zh-hans:https://tuyainc.github.io/tuyasmart_home_ios_sdk_doc/zh-hans/resource/Activator.html#%E8%AE%BE%E5%A4%87%E9%85%8D%E7%BD%91
 */

@interface TYDemoAddDeviceMenuViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation TYDemoAddDeviceMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.centerTitleItem.title = NSLocalizedString(@"Add Device", @"");
    self.topBarView.centerItem = self.centerTitleItem;
    [self.view addSubview:self.topBarView];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, APP_TOP_BAR_HEIGHT, APP_SCREEN_WIDTH, APP_CONTENT_HEIGHT) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.tableFooterView = [UIView new];
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return AddDeviceModeCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:NSStringFromClass([UITableViewCell class])];
        UIImageView *arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell_view_arrow@2x"]];
        arrow.top = (66 - arrow.height)/2;
        arrow.right = APP_SCREEN_WIDTH - arrow.width - 15;
        [cell.contentView addSubview:arrow];
    }
    
    NSString *title = @"placeholder";
    switch (indexPath.row) {
        case AddDeviceModeEZ:
            title = NSLocalizedString(@"Add device in EZ mode", @"");
            break;
        case AddDeviceModeAP:
            title = NSLocalizedString(@"Add device in AP mode", @"");
            break;
        case AddZigBeeGateway:
            title = NSLocalizedString(@"Add ZigBee gateway", @"");
            break;
        case AddZigBeeSubdevice:
            title = NSLocalizedString(@"Add ZigBee subdevice", @"");
            break;
        case AddDeviceSIGMesh: {
            title = NSLocalizedString(@"Add SIG Mesh device", @"");
        }
            break;
        default:
            break;
    }
    cell.textLabel.text = title;
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    UIViewController *controller = nil;
    switch (indexPath.row) {
        case AddDeviceModeEZ:
            controller = [TYDemoEZAddDeviceViewController new];
            break;
        case AddDeviceModeAP:
            controller = [TYDemoAPAddDeviceViewController new];
            break;
        case AddZigBeeGateway:
            controller = [TYDemoAddZigBeeViewController new];
            break;
        case AddZigBeeSubdevice:
            controller = [TYDemoAddZigBeeViewController new];
            ((TYDemoAddZigBeeViewController *)controller).forZigBeeSubdevice = YES;
            break;
//        case AddDeviceSIGMesh: { //todo hk
//            controller = [TYAddSIGMeshDeviceViewController new];
//        }
            break;
        default:
            break;
    }
    if (controller) {
        [self.navigationController pushViewController:controller animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 66;
}

@end
