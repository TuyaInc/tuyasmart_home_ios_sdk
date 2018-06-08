//
//  AddDeviceListViewController.m
//  TuyaSmart
//
//  Created by fengyu on 15/3/10.
//  Copyright (c) 2015年 Tuya. All rights reserved.
//

#import "AddDeviceListViewController.h"
#import "AddNewMemberViewController.h"
#import "TYReceiveMemberDeviceListView.h"

@interface AddDeviceListViewController () <TYReceiveMemberDeviceListDelegate> {
    BOOL _isAutoShare;
}

@property (nonatomic, strong) TYReceiveMemberDeviceListView *deviceListView;
@property (nonatomic, strong) UIView *shareButton;
@property (nonatomic, strong) NSMutableSet *shareDeviceIds;
@property (nonatomic, strong) UILabel *switchLabel;
@property (nonatomic, strong) UIImageView *buttonImageView;

//@property (nonatomic, strong) TuyaSmartDeviceShare *shareService;
@property (nonatomic, strong) NSArray *shareDeviceList;


@end

@implementation AddDeviceListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.shareDeviceList = [self.shareService getShareDeviceList];
    
    _isAutoShare = NO;
    [self initView];
}


- (void)dealloc {
//    _shareService = nil;
}

- (TYReceiveMemberDeviceListView *)deviceListView {
    if (!_deviceListView) {
        _deviceListView = [[TYReceiveMemberDeviceListView alloc] initWithFrame:CGRectMake(0, APP_TOP_BAR_HEIGHT + 30 + 15, APP_CONTENT_WIDTH, APP_SCREEN_HEIGHT - APP_TOP_BAR_HEIGHT - 30 - 60 - 15) deviceList:self.shareDeviceList type:0];
        _deviceListView.delegate = self;
    }
    return _deviceListView;
}


//- (TuyaSmartDeviceShare *)shareService {
//    if (!_shareService) {
//        _shareService = [[TuyaSmartDeviceShare alloc] init];
//    }
//    return _shareService;
//}


- (NSMutableSet *)shareDeviceIds {
    if (!_shareDeviceIds) {
        _shareDeviceIds = [NSMutableSet set];
    }
    return _shareDeviceIds;
}

- (UIView *)shareButton {
    if (!_shareButton) {
        _shareButton = [TPViewUtil viewWithFrame:CGRectMake(0, APP_SCREEN_HEIGHT - 60, APP_SCREEN_WIDTH, 60) color:[UIColor whiteColor]];
        
        UILabel *titleLabel = [TPViewUtil labelWithFrame:CGRectMake(0, 41, APP_SCREEN_WIDTH, 15) fontSize:12 color:MAIN_FONT_COLOR];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.text = NSLocalizedString(@"ty_share_add", @"");
        [_shareButton addSubview:titleLabel];
        
        _buttonImageView = [[UIImageView alloc] initWithFrame:CGRectMake((APP_SCREEN_WIDTH - 30) / 2, 7, 30, 30)];
        _buttonImageView.image = [[UIImage imageNamed:@"ty_mainbt_about"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _buttonImageView.tintColor = DISABLE_BUTTON_BACKGROUND_COLOR;
        
        [_shareButton addSubview:_buttonImageView];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_SCREEN_WIDTH, 0.5)];
        lineView.backgroundColor = SEPARATOR_LINE_COLOR;
        [_shareButton addSubview:lineView];
    }
    return _shareButton;
}

- (NSString *)titleForCenterItem {
    return NSLocalizedString(@"ty_share_add_device", @"");
}

- (NSString *)titleForEmptyView {
    return NSLocalizedString(@"ty_share_add_device_nodevice", @"");
}

- (void)initView {
    self.view.backgroundColor = MAIN_BACKGROUND_COLOR;
    
    if (self.shareDeviceList.count > 0) {
        
        UILabel *listTitleLabel = [TPViewUtil simpleLabel:CGRectMake(15, APP_TOP_BAR_HEIGHT + 15, APP_CONTENT_WIDTH - 30, 30) f:14 tc:HEXCOLOR(0xB0B0B0) t:NSLocalizedString(@"ty_share_add_select", nil)];
        [self.view addSubview:listTitleLabel];

        [self.view addSubview:self.deviceListView];
        
        [self.shareButton addGestureRecognizer:[TPViewUtil singleFingerClickRecognizer:self sel:@selector(shareToMember)]];
        [self.view addSubview:self.shareButton];
        [self hideEmptyView];
    } else {
        [self showEmptyView];
    }
}


- (void)shareToMember {
    if (self.shareDeviceIds.count > 0) {
        AddNewMemberViewController *vc = [[AddNewMemberViewController alloc] init];
        vc.type = 1;
        vc.shareDeviceIds = self.shareDeviceIds.allObjects;
        vc.isAutoShare = _isAutoShare;
        [tp_topMostViewController().navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - TYReceiveMemberDeviceListDelegate

- (void)didSettingDeviceSwitch:(UISwitch *)deviceSwitch isOn:(BOOL)isOn model:(TuyaSmartShareDeviceModel *)model{
    if (isOn) {
        model.share = YES;
        [self.shareDeviceIds addObject:model.devId];
    } else {
        model.share = NO;
        [self.shareDeviceIds removeObject:model.devId];
    }
    if (self.shareDeviceIds.count > 0) {
        _buttonImageView.tintColor = MAIN_COLOR;
    } else {
        _buttonImageView.tintColor = DISABLE_BUTTON_BACKGROUND_COLOR;
    }
}
@end
