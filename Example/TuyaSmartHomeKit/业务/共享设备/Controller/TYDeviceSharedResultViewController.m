//
//  TYDeviceSharedResultViewController.m
//  TuyaSmartPublic
//
//  Created by XuChengcheng on 2017/5/15.
//  Copyright © 2017年 Tuya. All rights reserved.
//

#import "TYDeviceSharedResultViewController.h"
#import "MemberEditViewController.h"

@interface TYDeviceSharedResultViewController ()

//@property (nonatomic, strong) TuyaSmartDeviceShare *shareService;
@property (nonatomic, strong) UILabel *infoLabel;
@property (nonatomic, strong) UISwitch *switchView;

@end

@implementation TYDeviceSharedResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addSubView];
}

- (void)addSubView {
    
    UIView *resultView = [TPViewUtil viewWithFrame:CGRectMake(0, 64, APP_SCREEN_WIDTH, 389 - 64) color:[UIColor whiteColor]];
    [self.view addSubview:resultView];
    
    UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake((APP_SCREEN_WIDTH - 65) / 2.0, 72, 65, 65)];
    iconImageView.image = [UIImage imageNamed:_isSuccess ? @"ty_member_share_success" : @"ty_member_share_failure"];
    [resultView addSubview:iconImageView];
    
    UILabel *resultLabel = [TPViewUtil simpleLabel:CGRectMake(0, 153, APP_SCREEN_WIDTH, 30) bf:22 tc:HEXCOLOR(0x4a4a4a) t:_isSuccess ? NSLocalizedString(@"ty_share_succeed", @"") : NSLocalizedString(@"ty_share_fail", @"")];
    resultLabel.textAlignment = NSTextAlignmentCenter;
    [resultView addSubview:resultLabel];
    
    UILabel *infoLabel = [TPViewUtil simpleLabel:CGRectMake(0, 186, APP_SCREEN_WIDTH, 30) f:12 tc:HEXCOLOR(0x8a9e91) t:@""];
    if (_errorInfo.length > 0) {
        infoLabel.text = _errorInfo;
    } else {
        infoLabel.text = [NSString stringWithFormat:NSLocalizedString(@"ty_share_add_succeed", @""), _member.nickName.length > 0 ? _member.nickName : _member.userName];
    }
    infoLabel.numberOfLines = 2;
    infoLabel.textAlignment = NSTextAlignmentCenter;
    [resultView addSubview:infoLabel];
    _infoLabel = infoLabel;
    
    
    if (_isSuccess && _isPresent) {
        
        UIView *lineView = [TPViewUtil viewWithFrame:CGRectMake(15, 265, APP_SCREEN_WIDTH - 30, 0.5) color:HEXCOLOR(0xdddfe8)];
        [resultView addSubview:lineView];
        
        UILabel *sharedLabel = [TPViewUtil simpleLabel:CGRectMake(18, 283, APP_SCREEN_WIDTH - 18 - 100, 24) f:16 tc:HEXCOLOR(0x303030) t:NSLocalizedString(@"ty_share_add_newdevice", @"")];
        [resultView addSubview:sharedLabel];
        
        UISwitch *switchView = [[UISwitch alloc] initWithFrame:CGRectMake(APP_SCREEN_WIDTH - 66, 278, 51, 31)];
        switchView.selected = NO;
        [switchView addTarget:self action:@selector(shareDevice:) forControlEvents:UIControlEventValueChanged];
        [resultView addSubview:switchView];
        _switchView = switchView;
    }
    
    UIButton *confirmBtn = [TPViewUtil buttonWithFrame:CGRectMake(10, 413, APP_SCREEN_WIDTH - 20, 44) fontSize:17 bgColor:BUTTON_BACKGROUND_COLOR textColor:BUTTON_TEXT_COLOR];
    [confirmBtn addTarget:self action:@selector(confirmBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [confirmBtn setTitle:NSLocalizedString(@"done", @"") forState:UIControlStateNormal];
    [self.view addSubview:confirmBtn];
    
    self.topBarView.leftItem = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (!_errorInfo) {
        _infoLabel.text = [NSString stringWithFormat:NSLocalizedString(@"ty_share_add_succeed", @""), _member.nickName.length > 0 ? _member.nickName : _member.userName];
    }
}

//- (TuyaSmartDeviceShare *)shareService {
//    if (!_shareService) {
//        _shareService = [[TuyaSmartDeviceShare alloc] init];
//    }
//    return _shareService;
//}

- (NSString *)titleForRightItem {
    if (_isSuccess && _isPresent) {
        return NSLocalizedString(@"ty_share_details", @"");
    } else {
        return nil;
    }
}

- (void)rightBtnAction {
//    WEAKSELF_AT
//    [self.shareService getShareMemberDetail:_member.memberId success:^(TuyaSmartShareMemberDetailModel *model) {
//
//
//        // 需要分享成功接口返回member model
//        MemberEditViewController *editViewController = [[MemberEditViewController alloc] init];
//
//        weakSelf_AT.member.nickName = model.name;
//        editViewController.member = weakSelf_AT.member;
//        editViewController.type = 0;
//        editViewController.isAutoShare = model.autoSharing;
//        editViewController.shareDeviceList = model.devices;
//        editViewController.updateAutoShareSwitchBlock = ^(BOOL isAuto) {
//            weakSelf_AT.switchView.on = isAuto;
//        };
//
//        [weakSelf_AT.navigationController pushViewController:editViewController animated:YES];
//        [TPProgressUtils hideHUDForView:nil animated:YES];
//
//
//
//    } failure:^(NSError *error) {
//        [TPProgressUtils hideHUDForView:nil animated:YES];
//    }];
    
    
}

- (IBAction)shareDevice:(UISwitch *)shareSwitch {
    
    [TPProgressUtils showMessag:NSLocalizedString(@"loading", nil) toView:nil];
    
//    [self.shareService enableNewDeviceAutoShare:shareSwitch.on memberId:_member.memberId success:^{
//        [TPProgressUtils hideHUDForView:nil animated:YES];
//    } failure:^(NSError *error) {
//        [TPProgressUtils hideHUDForView:nil animated:YES];
//    }];
    
}

- (IBAction)confirmBtnClicked:(id)sender {
    if (_isPresent) {
        [self dismissViewControllerAnimated:NO completion:^{
            [tp_topMostViewController() dismissViewControllerAnimated:YES completion:nil];
        }];
    } else {
        [self dismissViewControllerAnimated:YES completion:^{
            [tp_topMostViewController().navigationController popViewControllerAnimated:NO];
        }];
    }
}



@end
