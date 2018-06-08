//
//  TYPanelBaseViewController.m
//  TuyaSmartKitDemo
//
//  Created by 冯晓 on 16/8/30.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TYPanelBaseViewController.h"


@interface TYPanelBaseViewController()

@property (nonatomic, strong) UILabel  *offlineLabel;


@end

@implementation TYPanelBaseViewController


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


- (UILabel *)offlineLabel {
    if (!_offlineLabel) {
        _offlineLabel = [TPViewUtil simpleLabel:CGRectMake(0, APP_TOP_BAR_HEIGHT, APP_CONTENT_WIDTH, APP_VISIBLE_HEIGHT) f:14 tc:HEXCOLOR(0xffffff) t:NSLocalizedString(@"title_device_offline", nil)];
        _offlineLabel.textAlignment = NSTextAlignmentCenter;
        _offlineLabel.backgroundColor = HEXCOLORA(0x000000, 0.6);
        [self.view addSubview:self.offlineLabel];
    }
    return _offlineLabel;
}


#pragma mark - menu

- (void)rightBtnAction {
    UIActionSheet *sheet = [UIActionSheet bk_actionSheetWithTitle:NSLocalizedString(@"action_more", @"")];
    
    WEAKSELF_AT
    
    //修改设备名称
    [sheet bk_addButtonWithTitle:NSLocalizedString(@"rename_device", @"") handler:^{
        [weakSelf_AT updateName];
    }];
    
    
    //移除设备
    [sheet bk_addButtonWithTitle:NSLocalizedString(@"cancel_connect", @"") handler:^{
        [weakSelf_AT removeDevice];
    }];
    
    [sheet bk_setCancelButtonWithTitle:NSLocalizedString(@"action_cancel", @"") handler:nil];
    [sheet showInView:self.view];
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
            ;
            
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



@end
