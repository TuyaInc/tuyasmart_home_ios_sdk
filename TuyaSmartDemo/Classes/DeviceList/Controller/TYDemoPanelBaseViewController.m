//
//  TYPanelBaseViewController.m
//  TuyaSmartKitDemo
//
//  Created by 冯晓 on 16/8/30.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TYDemoPanelBaseViewController.h"
#import "TPDemoUtils.h"
#import "TPDemoProgressUtils.h"

@interface TYDemoPanelBaseViewController()

@property (nonatomic, strong) UILabel  *offlineLabel;

@end

@implementation TYDemoPanelBaseViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.centerTitleItem.title = self.device.deviceModel.name;
 
    self.topBarView.centerItem = self.centerTitleItem;
    self.topBarView.leftItem = self.leftBackItem;
    self.rightTitleItem.title = NSLocalizedString(@"action_more", @"");
    self.topBarView.rightItem = self.rightTitleItem;
  
    [self.view addSubview:self.topBarView];
}

- (void)updateOfflineView {
    self.offlineLabel.hidden = self.device.deviceModel.isOnline;
    
    [self.view bringSubviewToFront:self.offlineLabel];
}

- (TuyaSmartDevice *)device {
    if (!_device) {
        _device = [TuyaSmartDevice deviceWithDeviceId:self.devId];
        _device.delegate = self;
    }
    return _device;
}

- (TuyaSmartGroup *)group {
    if (!_group) {
        _group = [TuyaSmartGroup groupWithGroupId:self.groupId];
    }
    return _group;
}

- (UILabel *)offlineLabel {
    if (!_offlineLabel) {
        _offlineLabel = [TPDemoViewUtil simpleLabel:CGRectMake(0, APP_TOP_BAR_HEIGHT, APP_CONTENT_WIDTH, APP_VISIBLE_HEIGHT) f:14 tc:HEXCOLOR(0xffffff) t:NSLocalizedString(@"title_device_offline", nil)];
        _offlineLabel.textAlignment = NSTextAlignmentCenter;
        _offlineLabel.backgroundColor = HEXCOLORA(0x000000, 0.6);
        [self.view addSubview:self.offlineLabel];
    }
    return _offlineLabel;
}

#pragma mark - menu

- (void)rightBtnAction {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"action_more", @"") message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    WEAKSELF_AT
    
    //修改设备名称
    UIAlertAction *rename = [UIAlertAction actionWithTitle:NSLocalizedString(@"rename_device", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf_AT updateName];
    }];
    [alert addAction:rename];
    
    //移除设备
    UIAlertAction *remove = [UIAlertAction actionWithTitle:NSLocalizedString(@"cancel_connect", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf_AT removeDevice];
    }];
    
    [alert addAction:remove];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:NSLocalizedString(@"action_cancel", @"") style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancel];
    
    
    [self presentViewController:alert animated:YES completion:nil];
}

//- (void)addDeviceGroup {
//    TYDeviceGroupViewController *group = [[TYDeviceGroupViewController alloc] init];
//    group.device = self.device;
//    [self.navigationController pushViewController:group animated:YES];
//}

- (void)updateName {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"rename_device", @"") message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    NSString *text = @"";
    if (self.device) {
        text = self.device.deviceModel.name;
    } else {
        text = self.group.groupModel.name;
    }

    
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text = text;
    }];

    WEAKSELF_AT
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:NSLocalizedString(@"confirm", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField *textField = alert.textFields.firstObject;
        
        if (weakSelf_AT.device) {
            [weakSelf_AT.device updateName:textField.text success:^{
                ;
                
                UIButton *btn = [weakSelf_AT.topBarView viewWithTag:TP_CENTER_VIEW_TAG];
                
                [btn setTitle:textField.text forState:UIControlStateNormal];
                
            } failure:^(NSError *error) {
                [TPDemoProgressUtils showError:error.localizedDescription];
            }];
        } else if (weakSelf_AT.group) {
            [weakSelf_AT.group updateGroupName:textField.text success:^{
                ;
                
                UIButton *btn = [weakSelf_AT.topBarView viewWithTag:TP_CENTER_VIEW_TAG];
                
                [btn setTitle:textField.text forState:UIControlStateNormal];
                
            } failure:^(NSError *error) {
                [TPDemoProgressUtils showError:error.localizedDescription];
            }];
        }
    }];
    
    [alert addAction:confirm];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:NSLocalizedString(@"action_cancel", @"") style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)removeDevice {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"cancel_connect", @"") message:NSLocalizedString(@"device_confirm_remove", @"") preferredStyle:UIAlertControllerStyleAlert];
    
    WEAKSELF_AT
    UIAlertAction *remove = [UIAlertAction actionWithTitle:NSLocalizedString(@"confirm", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (weakSelf_AT.device) {
            [weakSelf_AT.device remove:^{
                
                [TPDemoProgressUtils showSuccess:NSLocalizedString(@"device_has_unbinded", @"") toView:nil block:^{
                    [tp_topMostViewController().navigationController popViewControllerAnimated:YES];
                }];
                
            } failure:^(NSError *error) {
                [TPDemoProgressUtils showError:error.localizedDescription];
            }];
        } else if (weakSelf_AT.group) {
            [weakSelf_AT.group dismissGroup:^{
                [TPDemoProgressUtils showSuccess:NSLocalizedString(@"device_has_unbinded", @"") toView:nil block:^{
                    [tp_topMostViewController().navigationController popViewControllerAnimated:YES];
                }];
            } failure:^(NSError *error) {
                [TPDemoProgressUtils showError:error.localizedDescription];
            }];
        }
    }];
    
    [alert addAction:remove];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:NSLocalizedString(@"action_cancel", @"") style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:nil];
}

@end
