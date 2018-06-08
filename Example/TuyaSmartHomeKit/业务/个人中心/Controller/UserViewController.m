//
//  UserViewController.m
//  TuyaSmart
//
//  Created by fengyu on 15/2/28.
//  Copyright (c) 2015年 Tuya. All rights reserved.
//

#import "UserViewController.h"
#import "TYMemberListViewController.h"
#import "TYUserInfoViewController.h"
#import "TYSmartSceneViewController.h"

#import "TPItemView.h"
#import "UserView.h"
#import "UserInfoTableViewCell.h"
#import "UserItemTableViewCell.h"
#import "SeparatorTableViewCell.h"
#import "TPBaseUtils.h"


#define UserInfoTableViewCellIdentifier  @"UserInfoTableViewCellIdentifier"
#define UserItemTableViewCellIdentifier  @"UserItemTableViewCellIdentifier"
#define SeparatorTableViewCellIdentifier @"SeparatorTableViewCellIdentifier"

@interface UserViewController ()<UITableViewDataSource,UITableViewDelegate,TPItemViewDelegate>

@property (nonatomic,strong) NSArray         *dataSource;
@property (nonatomic,strong) UserView        *userView;

@end

@implementation UserViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    
    
//    TuyaSmartMemberModel *user = [[TuyaSmartMemberModel alloc] init];
    NSObject *profileItem = [[NSObject alloc] init];
    
//    MenuItem *shareItem   = [MenuItem normalItem:[UIImage imageNamed:@"ty_me_share"]      title:NSLocalizedString(@"menu_title_share", @"") action:@selector(gotoMemberListViewController)];
    MenuItem *smartSceneItem   = [MenuItem firstItem:[UIImage imageNamed:@"ty_me_scene"]      title:NSLocalizedString(@"ty_smart_scene", nil) action:@selector(gotoSmartSceneController)];
//    MenuItem *FAQItem       = [MenuItem normalItem:[UIImage imageNamed:@"ty_me_faq"] title:NSLocalizedString(@"feedback_faq", @"") action:@selector(gotoFAQViewController)];
    
    NSMutableArray *list = [NSMutableArray new];
    [list addObject:profileItem];
    [list addObject:[MenuItem separatorItem:16]];
    
    [list addObject:smartSceneItem];
//    [list addObject:shareItem];
//    [list addObject:FAQItem];
    
    [list addObject:[MenuItem separatorItem:16]];
    
    _dataSource = [NSArray arrayWithArray:list];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData) name:TPNotificationUpdateUserInfo object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

- (void)reloadData {
    [_userView.userTableView reloadData];
}

- (void)initView {
    [self initTopBarView];
    [self initUserView];
}

- (void)initTopBarView {
    
    self.centerTitleItem.title = NSLocalizedString(@"personal_center", @"");
    self.topBarView.centerItem = self.centerTitleItem;
    
    [self.view addSubview:self.topBarView];
}

- (void)initUserView {
    _userView = [[UserView alloc] initWithFrame:CGRectMake(0, APP_TOP_BAR_HEIGHT, APP_SCREEN_WIDTH,APP_CONTENT_HEIGHT)];
    [_userView.userTableView registerClass:[UserInfoTableViewCell class] forCellReuseIdentifier:UserInfoTableViewCellIdentifier];
    [_userView.userTableView registerClass:[UserItemTableViewCell class] forCellReuseIdentifier:UserItemTableViewCellIdentifier];
    [_userView.userTableView registerClass:[SeparatorTableViewCell class] forCellReuseIdentifier:SeparatorTableViewCellIdentifier];
    _userView.userTableView.dataSource = self;
    _userView.userTableView.delegate = self;
    
    [self.view addSubview:_userView];
}


- (void)gotoUserInfoViewcontroller {
    TYUserInfoViewController *vc = [TYUserInfoViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)gotoMemberListViewController {
    TYMemberListViewController *memberListViewController = [TYMemberListViewController new];
    [self.navigationController pushViewController:memberListViewController animated:YES];
}

- (void)gotoSmartSceneController {
    TYSmartSceneViewController *vc = [[TYSmartSceneViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)gotoFAQViewController {
    [ViewControllerUtils gotoWebViewController:NSLocalizedString(@"feedback_faq", @"") url:[TPBaseUtils getFAQUrl] from:self];
}

- (void)userInfoCellTap:(UITapGestureRecognizer *)sender {
    [self gotoUserInfoViewcontroller];
}

#pragma mark TPItemViewDelegate

- (void)itemViewTap:(TPItemView *)itemView {
    
    MenuItem *item = [_dataSource objectAtIndex:itemView.tag];
    
    SEL action = item.action;
    if ([self respondsToSelector:action]) {
        
        ((void (*)(id, SEL))[self methodForSelector:action])(self, action);
    }
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {

        UserInfoTableViewCell *userInfoCell = [tableView dequeueReusableCellWithIdentifier:UserInfoTableViewCellIdentifier forIndexPath:indexPath];
        
        [userInfoCell addGestureRecognizer:[TPViewUtil singleFingerClickRecognizer:self sel:@selector(userInfoCellTap:)]];
        
        return userInfoCell;
    } else {
        MenuItem *item = [self dataForIndexPath:indexPath];
        if (item.type == MenuItemTypeSeparator) {
            SeparatorTableViewCell *separatorCell = [tableView dequeueReusableCellWithIdentifier:SeparatorTableViewCellIdentifier forIndexPath:indexPath];
            return separatorCell;
        } else {
            UserItemTableViewCell *userItemCell = [tableView dequeueReusableCellWithIdentifier:UserItemTableViewCellIdentifier forIndexPath:indexPath];
            userItemCell.itemView.tag = indexPath.row;
            
            userItemCell.itemView.delegate = self;
            [userItemCell setUp:item];
            return userItemCell;
        }
    }
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 116;
    } else {
        MenuItem *item = [self dataForIndexPath:indexPath];
        if (item.type == MenuItemTypeSeparator) {
            return item.height;
        } else {
            return 44;
        }
    }
}

- (id)dataForIndexPath:(NSIndexPath *)indexPath {
    return [_dataSource objectAtIndex:indexPath.row];
}

@end
