//
//  MemberEditViewController.m
//  TuyaSmart
//
//  Created by fengyu on 15/3/10.
//  Copyright (c) 2015年 Tuya. All rights reserved.
//

#import "MemberEditViewController.h"
#import "MemberEditView.h"
#import "TYReceiveMemberDeviceListView.h"
#import "AppendDeviceSettingViewController.h"

@interface MemberEditViewController () <AppendDeviceSettingDelegate,TYReceiveMemberDeviceListDelegate>

@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) MemberEditView *memberEditView;
@property (nonatomic, strong) NSArray *deviceList;
@property (nonatomic, strong) TYReceiveMemberDeviceListView *deviceListView;
//@property (nonatomic, strong) TuyaSmartDeviceShare *shareService;
@property (nonatomic, strong) UILabel *switchLabel;

@end

@implementation MemberEditViewController

- (void)dealloc {

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
}

//- (TuyaSmartDeviceShare *)shareService {
//    if (!_shareService) {
//        _shareService = [[TuyaSmartDeviceShare alloc] init];
//    }
//    return _shareService;
//}

- (TYReceiveMemberDeviceListView *)deviceListView {
    if (!_deviceListView) {
        _deviceListView = [[TYReceiveMemberDeviceListView alloc] initWithFrame:CGRectMake(0, APP_TOP_BAR_HEIGHT, APP_CONTENT_WIDTH, APP_VISIBLE_HEIGHT) deviceList:self.deviceList type:_type];
        _deviceListView.tableView.scrollEnabled = YES;
        _deviceListView.delegate = self;
    }
    return _deviceListView;
}

- (void)initView {
    self.view.backgroundColor = MAIN_BACKGROUND_COLOR;
    
    self.deviceList = [NSArray arrayWithArray:_type == 0 ? self.shareDeviceList : self.receiveDeviceList];
    
    CGFloat headerHeight = 212 + (_type == 0 ? 88 : 0);
    _headerView = [TPViewUtil viewWithFrame:CGRectMake(0, 0, APP_SCREEN_WIDTH, headerHeight) color:nil];
    self.deviceListView.tableView.tableHeaderView = _headerView;
    
    _memberEditView = [[MemberEditView alloc] initWithFrame:CGRectMake(0, 0, APP_SCREEN_WIDTH, 212)];
    [_memberEditView setup:_member];
    [_memberEditView.commentsView addGestureRecognizer:[TPViewUtil singleFingerClickRecognizer:self sel:@selector(changeComments)]];
    [_headerView addSubview:_memberEditView];
    
    if (_type == 0) {
        UIView *appendDeviceView = [TPViewUtil viewWithFrame:CGRectMake(0, _memberEditView.bottom, APP_SCREEN_WIDTH, 44) color:[UIColor whiteColor]];
        
        UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 2, 40, 40)];
        iconImageView.image = [UIImage imageNamed:@"tysmart_append_device"];
        [appendDeviceView addSubview:iconImageView];
        
        UILabel *titleLabel = [TPViewUtil labelWithFrame:CGRectMake(70, 0, 135, 44) fontSize:16 color:MAIN_FONT_COLOR];
        titleLabel.text = NSLocalizedString(@"ty_share_add_newdevice", @"");
        [appendDeviceView addSubview:titleLabel];
        
        _switchLabel = [TPViewUtil labelWithFrame:CGRectMake(APP_SCREEN_WIDTH - 80 - 32, 0, 80, 44) fontSize:16 color:HEXCOLOR(0x9B9B9B)];
        _switchLabel.textAlignment = NSTextAlignmentRight;
        _switchLabel.text = _isAutoShare ? NSLocalizedString(@"open", @"") : NSLocalizedString(@"close", @"");
        [appendDeviceView addSubview:_switchLabel];
        [appendDeviceView addSubview:[TPViewUtil rightArrowImageView:CGRectMake(APP_SCREEN_WIDTH - 22, 16, 7, 12)]];
        [appendDeviceView addGestureRecognizer:[TPViewUtil singleFingerClickRecognizer:self sel:@selector(appendDeviceSetting)]];
       
        [_headerView addSubview:appendDeviceView];
    }

    UILabel *listTitleLabel = [TPViewUtil simpleLabel:CGRectMake(15, headerHeight - 30, APP_CONTENT_WIDTH - 30, 30) f:14 tc:HEXCOLOR(0xB0B0B0) t:NSLocalizedString(_type == 0 ? @"ty_share_add_select" : @"ty_add_share_receive_device", nil)];
    [_headerView addSubview:listTitleLabel];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, headerHeight - 0.5, APP_CONTENT_WIDTH, 0.5)];
    line.backgroundColor = SEPARATOR_LINE_COLOR;
    [_headerView addSubview:line];
    
    [self.view addSubview:self.deviceListView];
}

- (NSString *)titleForCenterItem {
    return NSLocalizedString(@"edit", @"");
}


- (void)changeComments {
    UIAlertView *alertView = [UIAlertView bk_alertViewWithTitle:NSLocalizedString(@"ty_share_edit_alias", @"")];
    [alertView bk_setCancelButtonWithTitle:NSLocalizedString(@"cancel", @"") handler:nil];
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    UITextField *textField = [alertView textFieldAtIndex:0];
    textField.text = _memberEditView.commentsTextField.text;
    
    WEAKSELF_AT
    [alertView bk_addButtonWithTitle:NSLocalizedString(@"Confirm", @"") handler:^{
        [weakSelf_AT saveAction:textField.text success:^{
            [weakSelf_AT hideProgressView];
            weakSelf_AT.member.nickName = weakSelf_AT.memberEditView.comments;
            weakSelf_AT.memberEditView.commentsTextField.text = textField.text;
            [TPNotification postNotificationName:kNotificationMemberUpdate];
        } failure:^(NSError *error) {
            [weakSelf_AT hideProgressView];
            [TPProgressUtils showError:error];
        }];
    }];
    
    [alertView show];
}

- (void)saveAction:(NSString *)text success:(TYSuccessHandler)success failure:(TYFailureError)failure {
//    if (_type == 0) {
//        [self.shareService updateShareMemberName:_member.memberId name:text success:success failure:failure];
//    } else {
//        [self.shareService updateReceiveMemberName:_member.memberId name:text success:success failure:failure];
//    }
}

- (void)appendDeviceSetting {
    AppendDeviceSettingViewController *vc = [[AppendDeviceSettingViewController alloc] init];
    vc.delegate = self;
    vc.isAutoShare = self.isAutoShare;
    [tp_topMostViewController().navigationController pushViewController:vc animated:YES];
}

#pragma mark - AppendDeviceSettingDelegate

- (void)didSettingSwitch:(UISwitch *)settingSwitch isOn:(BOOL)isOn {
//    WEAKSELF_AT
//    [TPProgressUtils showMessag:NSLocalizedString(@"loading", nil) toView:nil];
//
//    [self.shareService enableNewDeviceAutoShare:isOn memberId:self.member.memberId success:^{
//
//        weakSelf_AT.isAutoShare = isOn;
//        weakSelf_AT.switchLabel.text = weakSelf_AT.isAutoShare ? NSLocalizedString(@"open", @"") : NSLocalizedString(@"close", @"");
//        if (weakSelf_AT.updateAutoShareSwitchBlock) {
//            weakSelf_AT.updateAutoShareSwitchBlock(isOn);
//        }
//        [TPProgressUtils hideHUDForView:nil animated:YES];
//
//
//    } failure:^(NSError *error) {
//
//        settingSwitch.on = weakSelf_AT.isAutoShare;
//        [TPProgressUtils hideHUDForView:nil animated:YES];
//
//    }];
    
}

#pragma mark - TYReceiveMemberDeviceListDelegate

- (void)didSettingDeviceSwitch:(UISwitch *)deviceSwitch isOn:(BOOL)isOn model:(TuyaSmartShareDeviceModel *)model {
    if (_type == 0) {
        [TPProgressUtils showMessag:NSLocalizedString(@"loading", nil) toView:nil];
        if (isOn) {

//            [self.shareService addDeviceShare:self.member.memberId devId:model.devId success:^{
//                model.share = YES;
//                [TPProgressUtils hideHUDForView:nil animated:YES];
//            } failure:^(NSError *error) {
//                deviceSwitch.on = model.share;
//                [TPProgressUtils hideHUDForView:nil animated:YES];
//            }];
            
        } else {
            
//            [self.shareService removeDeviceShare:self.member.memberId devId:model.devId success:^{
//                model.share = NO;
//                [TPProgressUtils hideHUDForView:nil animated:YES];
//            } failure:^(NSError *error) {
//                deviceSwitch.on = model.share;
//                [TPProgressUtils hideHUDForView:nil animated:YES];
//            }];
            
        }
    }
}

@end
