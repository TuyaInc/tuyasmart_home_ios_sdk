//
//  TYPanelBaseViewController.m
//  TuyaSmartKitDemo
//
//  Created by 冯晓 on 16/8/30.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TYPanelBaseDeviceViewController.h"
#import "TYDeviceGroupViewController.h"

@interface TYPanelBaseDeviceViewController() <UIActionSheetDelegate>



@end

@implementation TYPanelBaseDeviceViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.centerTitleItem.title = self.device.deviceModel.name;
 
    self.topBarView.centerItem = self.centerTitleItem;
    self.topBarView.leftItem = self.leftBackItem;
    self.rightTitleItem.title = NSLocalizedString(@"action_more", @"");
    self.topBarView.rightItem = self.rightTitleItem;
  
    [self.view addSubview:self.topBarView];
}

- (BOOL)isOfflineLabelNeedShow {
    return self.device.deviceModel.isOnline;
}

- (void)publishDps:(NSDictionary *)dictionary success:(TYSuccessHandler)success failure:(TYFailureError)failure {
    [self.device publishDps:dictionary success:success failure:failure];
}

- (NSDictionary *)dps {
    return self.device.deviceModel.dps;
}

- (NSArray<TuyaSmartSchemaModel *> *)schemaArray {
    return self.device.deviceModel.schemaArray;
}

#pragma mark - TuyaSmartDeviceDelegate

/// dp数据更新
- (void)device:(TuyaSmartDevice *)device dpsUpdate:(NSDictionary *)dps {
    [self reloadDatas];
}

/// 设备信息更新
- (void)deviceInfoUpdate:(TuyaSmartDevice *)device {
    [self reloadDatas];
}

/// 设备被移除
- (void)deviceRemoved:(TuyaSmartDevice *)device {
}

#pragma mark - menu

- (void)rightBtnAction {
    UIActionSheet *sheet = [UIActionSheet bk_actionSheetWithTitle:NSLocalizedString(@"action_more", @"")];
    WEAKSELF_AT
    [sheet bk_addButtonWithTitle:NSLocalizedString(@"rename_device", @"") handler:^{
        [weakSelf_AT updateName];
    }];
    if (self.device.deviceModel.deviceType != TuyaSmartDeviceModelTypeBle &&
        self.device.deviceModel.supportGroup) {
        [sheet bk_addButtonWithTitle:NSLocalizedString(@"add_group", @"") handler:^{
            [weakSelf_AT addDeviceGroup];
        }];
    }
    [sheet bk_addButtonWithTitle:NSLocalizedString(@"cancel_connect", @"") handler:^{
        [weakSelf_AT removeDevice];
    }];
    [sheet bk_setCancelButtonWithTitle:NSLocalizedString(@"action_cancel", @"") handler:nil];
    [sheet showInView:self.view];
}

- (void)addDeviceGroup {
    TYDeviceGroupViewController *group = [[TYDeviceGroupViewController alloc] init];
    group.device = self.device;
    [self.navigationController pushViewController:group animated:YES];
}

- (void)updateName {
    UIAlertView *alertView = [UIAlertView bk_alertViewWithTitle:NSLocalizedString(@"rename_device", @"")];
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    UITextField *textField = [alertView textFieldAtIndex:0];
    textField.text = self.device.deviceModel.name;
    
    if (textField.text.length == 0) {
        return;
    }
    
    WEAKSELF_AT
    [alertView bk_addButtonWithTitle:NSLocalizedString(@"confirm", @"") handler:^{
        [weakSelf_AT.device updateName:textField.text success:^{
            UIButton *btn = [weakSelf_AT.topBarView viewWithTag:TP_CENTER_VIEW_TAG];
            [btn setTitle:textField.text forState:UIControlStateNormal];
        } failure:^(NSError *error) {
            [TPProgressUtils showError:error.localizedDescription];
        }];
    }];
    [alertView bk_setCancelButtonWithTitle:NSLocalizedString(@"action_cancel", @"") handler:nil];
    [alertView show];
}

- (void)removeDevice {
    WEAKSELF_AT
    [UIAlertView bk_showAlertViewWithTitle:NSLocalizedString(@"cancel_connect", @"")
                                   message:NSLocalizedString(@"device_confirm_remove", @"")
                         cancelButtonTitle:NSLocalizedString(@"action_cancel", @"")
                         otherButtonTitles:@[NSLocalizedString(@"confirm", @"")]
                                   handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
        if (buttonIndex == 1) {
            [weakSelf_AT.device remove:^{
                
                [TPProgressUtils showSuccess:NSLocalizedString(@"device_has_unbinded", @"") toView:nil block:^{
                    [tp_topMostViewController().navigationController popViewControllerAnimated:YES];
                }];
                
            } failure:^(NSError *error) {
                [TPProgressUtils showError:error.localizedDescription];
            }];
        }
    }];
}

- (TuyaSmartDevice *)device {
    if (!_device) {
        _device = [TuyaSmartDevice deviceWithDeviceId:self.devId];
        _device.delegate = self;
    }
    return _device;
}

@end
