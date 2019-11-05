//
//  TYPanelBaseGroupViewController.m
//  TuyaSmartHomeKit_Example
//
//  Created by 温明妍 on 2019/11/4.
//  Copyright © 2019 xuchengcheng. All rights reserved.
//

#import "TYPanelBaseGroupViewController.h"

@interface TYPanelBaseGroupViewController () <TuyaSmartGroupDelegate>

@property (nonatomic, strong) TuyaSmartGroup *group;
@property (nonatomic, strong) UILabel  *offlineLabel;

@end

@implementation TYPanelBaseGroupViewController

#pragma mark - dealloc
#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.centerTitleItem.title = self.group.groupModel.name;
    self.topBarView.centerItem = self.centerTitleItem;
    self.topBarView.leftItem = self.leftBackItem;
    self.rightTitleItem.title = NSLocalizedString(@"action_more", @"");
    self.topBarView.rightItem = self.rightTitleItem;
    [self.view addSubview:self.topBarView];
}

#pragma mark - UITableViewDelegate
#pragma mark - TuyaSmartGroupDelegate

- (void)group:(TuyaSmartGroup *)group dpsUpdate:(NSDictionary *)dps {
    [self reloadDatas];
}

#pragma mark - Event Response

- (void)rightBtnAction {
    UIActionSheet *sheet = [UIActionSheet bk_actionSheetWithTitle:NSLocalizedString(@"action_more", @"")];
    WEAKSELF_AT
    [sheet bk_addButtonWithTitle:NSLocalizedString(@"rename_group", @"") handler:^{
        [weakSelf_AT updateName];
    }];
    [sheet bk_addButtonWithTitle:NSLocalizedString(@"delete_group", @"") handler:^{
        [weakSelf_AT deleteGroup];
    }];
    [sheet bk_setCancelButtonWithTitle:NSLocalizedString(@"action_cancel", @"") handler:nil];
    [sheet showInView:self.view];
}

- (void)deleteGroup {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"rename_group", @"")
                                                                   message:NSLocalizedString(@"really_to_delete_group", @"")
                                                            preferredStyle:UIAlertControllerStyleAlert];
    WEAKSELF_AT
    [alert addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"confirm", @"") style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
           [weakSelf_AT invokeDeleteGroup];
       }]];
    [alert addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"action_cancel", @"")
                                              style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
           
       }]];
    [self.navigationController presentViewController:alert animated:YES completion:nil];
}

- (void)invokeDeleteGroup {
    WEAKSELF_AT
    [self.group dismissGroup:^{
        [TPProgressUtils showSuccess:@"success" toView:weakSelf_AT.view];
        [weakSelf_AT.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        [TPProgressUtils showSuccess:@"failure" toView:weakSelf_AT.view];
    }];
}

- (void)updateName {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"rename_group", @"") message:@"please input group name" preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        
    }];
    WEAKSELF_AT
    [alert addAction:[UIAlertAction actionWithTitle:@"finish" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSString *text = alert.textFields.firstObject.text;
        [weakSelf_AT renameGroupName:text];
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"action_cancel", nil)
                                              style:UIAlertActionStyleCancel
                                            handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self.navigationController presentViewController:alert animated:YES completion:nil];
}

- (void)renameGroupName:(NSString *)text {
    WEAKSELF_AT
    [self.group updateGroupName:text success:^{
        [TPProgressUtils showSuccess:@"success" toView:weakSelf_AT.view];
    } failure:^(NSError *error) {
        [TPProgressUtils showSuccess:@"failure" toView:weakSelf_AT.view];
    }];
}

#pragma mark - private methods

- (BOOL)isOfflineLabelNeedShow {
    BOOL needShow = YES;
    for (TuyaSmartDeviceModel *deviceModel in self.group.groupModel.deviceList) {
        TuyaSmartDevice *device = [TuyaSmartDevice deviceWithDeviceId:deviceModel.devId];
        if (device.deviceModel.isOnline) {
            needShow = NO;
        }
        if (!needShow) {
            break;
        }
    }
    return needShow;
}

- (NSArray<TuyaSmartSchemaModel *> *)schemaArray {
    return self.group.groupModel.schemaArray;
}

- (NSDictionary *)dps {
    return self.group.groupModel.dps;
}

- (void)publishDps:(NSDictionary *)dictionary success:(nullable TYSuccessHandler)success failure:(nullable TYFailureError)failure {
    [self.group publishDps:dictionary success:^{
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

#pragma mark - getters & setters & init members

- (TuyaSmartGroup *)group {
    if (!_group) {
        _group = [TuyaSmartGroup groupWithGroupId:self.groupId];
        _group.delegate = self;
    }
    return _group;
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

@end
