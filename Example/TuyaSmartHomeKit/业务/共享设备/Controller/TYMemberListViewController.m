//
//  TYMemberListViewController.m
//  TuyaSmart
//
//  Created by 冯晓 on 16/1/7.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TYMemberListViewController.h"
#import "TYMemberListDataSource.h"
#import "TYMemberListDelegate.h"
#import "TYMemberListLayout.h"
#import "MJRefresh.h"

@interface TYMemberListViewController ()

@property (nonatomic, strong) TYMemberListDataSource *dataSource;
@property (nonatomic, strong) TYMemberListDelegate   *delegate;
@property (nonatomic, strong) TYMemberListLayout     *layout;
//@property (nonatomic, strong) TuyaSmartDeviceShare   *shareService;

@end

@implementation TYMemberListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = MAIN_BACKGROUND_COLOR;
    self.view = self.layout;
    
    if (_type > 0) {
        [self.layout setCurrentSelectIndex:_type];
    }
    
    [self reloadData];
    [self loadNotification];
    
    [self.layout.memberListView.tableView tp_addPullToRefresh:self refreshingAction:@selector(pullRefreshAction)];

}


- (void)pullRefreshAction {
    
    if (self.layout.memberListView.currentIndex == 0) {
        [self getMemberList];
    } else {
        [self getReceiveMemberList];
    }
    
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)loadNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData) name:kNotificationMemberUpdate object:nil];
}

- (void)reloadData {
    [self getMemberList];
    [self getReceiveMemberList];
}

- (void)getMemberList {
//    WEAKSELF_AT
//    [self.shareService getShareMemberList:^(NSArray *list) {
//        weakSelf_AT.dataSource.memberList = list;
//        [weakSelf_AT.layout reloadData];
//
//
//        [weakSelf_AT.layout.memberListView.tableView.mj_header endRefreshing];
//
//    } failure:^(NSError *error) {
//        [weakSelf_AT.layout.memberListView.tableView.mj_header endRefreshing];
//    }];
}

- (void)getReceiveMemberList {
//    WEAKSELF_AT
//    [self.shareService getReceiveMemberList:^(NSArray *list) {
//        weakSelf_AT.dataSource.receiveMemberList = list;
//        [weakSelf_AT.layout reloadData];
//        [weakSelf_AT.layout.memberListView.tableView.mj_header endRefreshing];
//    } failure:^(NSError *error) {
//        [weakSelf_AT.layout.memberListView.tableView.mj_header endRefreshing];
//    }];
}

#pragma mark - lazy load

//- (TuyaSmartDeviceShare *)shareService {
//    if (!_shareService) {
//        _shareService = [[TuyaSmartDeviceShare alloc] init];
//    }
//    return _shareService;
//}

- (TYMemberListLayout *)layout {
    if (!_layout) {
        _layout = [[TYMemberListLayout alloc] initWithFrame:self.view.bounds];
        _layout.delegate = self.delegate;
        _layout.dataSource = self.dataSource;
    }
    return _layout;
}

- (TYMemberListDelegate *)delegate {
    if (!_delegate) {
        _delegate = [[TYMemberListDelegate alloc] init];
    }
    return _delegate;
}

- (TYMemberListDataSource *)dataSource {
    if (!_dataSource) {
        _dataSource = [TYMemberListDataSource new];
    }
    return _dataSource;
}
@end
