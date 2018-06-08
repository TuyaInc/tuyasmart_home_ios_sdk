//
//  TYDeviceShareViewController.m
//  TuyaSmart
//
//  Created by 冯晓 on 16/1/7.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TYDeviceShareViewController.h"
#import "TYDeviceShareView.h"
#import "AddNewMemberViewController.h"

@interface TYDeviceShareViewController() <TPTopBarViewDelegate,TYDeviceShareViewDelegate>

@property (nonatomic, strong) TYDeviceShareView *deviceShareView;
//@property (nonatomic, strong) TuyaSmartDeviceShare *shareService;

@end

@implementation TYDeviceShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(initData) name:kNotificationMemberUpdate object:nil];

    [self initData];
    [self initView];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//- (TuyaSmartDeviceShare *)shareService {
//    if (!_shareService) {
//        _shareService = [[TuyaSmartDeviceShare alloc] init];
//    }
//    return _shareService;
//}

- (void)initData {
//    WEAKSELF_AT
//    [TPProgressUtils showMessag:NSLocalizedString(@"loading", nil) toView:nil];
//    [self.shareService getDeviceShareMemberList:_devId success:^(NSArray *list) {
//        weakSelf_AT.deviceShareView.memberList = list;
//        [weakSelf_AT.deviceShareView reloadData];
//        [TPProgressUtils hideHUDForView:nil animated:NO];
//    } failure:^(NSError *error) {
//        [TPProgressUtils hideHUDForView:nil animated:NO];
//    }];
}

- (void)initView {
    _deviceShareView = [[TYDeviceShareView alloc] initWithFrame:CGRectZero];
    _deviceShareView.topBarDelegate = self;
    _deviceShareView.delegate = self;
    [_deviceShareView.shareButton addTarget:self action:@selector(shareToMember) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_deviceShareView];
}

- (void)topBarLeftItemTap {
    [tp_topMostViewController() dismissViewControllerAnimated:YES completion:nil];
}

- (void)shareToMember {
    AddNewMemberViewController *vc = [[AddNewMemberViewController alloc] init];
    vc.type = 0;
    vc.shareDeviceIds = @[self.devId];
    vc.isAutoShare = YES;
    [tp_topMostViewController().navigationController pushViewController:vc animated:YES];
}

#pragma mark - TYDeviceShareViewDelegate
- (void)deleteRowWithMember:(TuyaSmartShareMemberModel *)member {
//    WEAKSELF_AT
//    [TPProgressUtils showMessag:NSLocalizedString(@"loading", nil) toView:nil];
//    [self.shareService removeDeviceShare:member.memberId devId:self.devId success:^{
//        [weakSelf_AT initData];
//        [TPProgressUtils hideHUDForView:nil animated:NO];
//    } failure:^(NSError *error) {
//        [TPProgressUtils hideHUDForView:nil animated:NO];
//    }];
}

@end
