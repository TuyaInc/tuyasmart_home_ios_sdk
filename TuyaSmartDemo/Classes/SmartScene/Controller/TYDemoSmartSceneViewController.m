//
//  SmartSceneViewController.m
//  TuyaSmartPublic
//
//  Created by XuChengcheng on 16/7/4.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TYDemoSmartSceneViewController.h"
#import "TYDemoSmartSceneTableViewCell.h"
#import "TYDemoAddSceneViewController.h"
#import "TYDemoConfiguration.h"
#import <TuyaSmartSceneKit/TuyaSmartSceneKit.h>
#import "TPDemoUtils.h"
#import "TPDemoNavigationController.h"
#import "TPDemoProgressUtils.h"

@interface TYDemoSmartSceneViewController ()

@property (nonatomic, strong) TuyaSmartScene *smartScene;

@end

#define SmartSceneTableViewCellIdentifier @"SmartSceneTableViewCellIdentifier"

@implementation TYDemoSmartSceneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [self loadSceneList];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadSceneList) name:@"kNotificationSmartSceneListUpdate" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadSceneList) name:kNotificationSwitchHome object:nil];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [self reloadTable];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)initView {
    self.view.backgroundColor = MAIN_BACKGROUND_COLOR;
    
    [self.view addSubview:self.tableView];
    
    NSArray *viewControllers = self.navigationController.viewControllers;
    
    if (viewControllers.count > 1) {
        self.tableView.frame = CGRectMake(0, APP_TOP_BAR_HEIGHT, APP_CONTENT_WIDTH, APP_VISIBLE_HEIGHT);
    } else {
        self.tableView.frame = CGRectMake(0, APP_TOP_BAR_HEIGHT, APP_CONTENT_WIDTH, APP_VISIBLE_HEIGHT - APP_TAB_BAR_HEIGHT);
    }
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_SCREEN_WIDTH, 20)];
    self.tableView.tableFooterView = footerView;
}

- (NSString *)titleForCenterItem {
    return NSLocalizedString(@"ty_smart_scene", @"");
}

- (UIView *)customViewForRightItem {
    
    UIView *rightCustomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    UIImageView *settingImageView = [TPDemoViewUtil imageViewWithFrame:CGRectMake(100 - 36, 4, 36, 36) image:[UIImage imageNamed:@"ty_add"]];
    [rightCustomView addSubview:settingImageView];
    [rightCustomView addGestureRecognizer:[TPDemoViewUtil singleFingerClickRecognizer:self sel:@selector(addSceneViewController)]];
    settingImageView.image = [settingImageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    settingImageView.tintColor = TOP_BAR_TEXT_COLOR;
    return rightCustomView;
}

- (void)loadSceneList
{
    [self showLoadingView];
    id<TYDemoDeviceListModuleProtocol> impl = [[TYDemoConfiguration sharedInstance] serviceOfProtocol:@protocol(TYDemoDeviceListModuleProtocol)];
    long long homeId = [impl currentHomeId];
    WEAKSELF_AT
    [[TuyaSmartSceneManager sharedInstance] getSceneListWithHomeId:homeId success:^(NSArray<TuyaSmartSceneModel *> *list) {
        [weakSelf_AT hideLoadingView];
        weakSelf_AT.dataSource = [NSMutableArray arrayWithArray:list];
        [weakSelf_AT reloadTable];
    } failure:^(NSError *error) {
        [weakSelf_AT hideLoadingView];
        [TPDemoProgressUtils showError:error];
    }];
}

- (void)reloadTable {
    [super reloadTable];
}

- (void)addSceneViewController {
    
    TYDemoAddSceneViewController *addSceneViewController = [[TYDemoAddSceneViewController alloc] init];
    [self presentViewController:[[TPDemoNavigationController alloc] initWithRootViewController:addSceneViewController] animated:YES completion:nil];
}

//是否显示下拉刷新
- (BOOL)showPullToRefresh {
    return YES;
}

//是否显示上拉刷新
- (BOOL)showInfinite {
    return NO;
}

- (IBAction)executeButtonClicked:(UIButton *)sender {
    TuyaSmartSceneModel *model = self.dataSource[sender.tag];
    self.smartScene = [TuyaSmartScene sceneWithSceneModel:model];
    [self.smartScene executeSceneWithSuccess:^{
        [TPDemoProgressUtils showSuccess:@"Success" toView:self.view];
    } failure:^(NSError *error) {
        [TPDemoProgressUtils showError:error];
    }];
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TYDemoSmartSceneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SmartSceneTableViewCellIdentifier];
    if (cell == nil) {
        cell = [[TYDemoSmartSceneTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SmartSceneTableViewCellIdentifier];
    }
    
    cell.tag = indexPath.row;
    cell.executeButton.tag = indexPath.row;
    [cell.executeButton addTarget:self action:@selector(executeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    TuyaSmartSceneModel *model = self.dataSource[indexPath.row];
    if (model.sceneId == 0) {
        cell.executeButton.enabled = NO;
        cell.executeButton.layer.borderColor = HEXCOLORA(0x8a8e91, 0.4).CGColor;
    } else {
        cell.executeButton.enabled = YES;
        cell.executeButton.layer.borderColor = HEXCOLOR(0x44db5e).CGColor;
    }
    
    cell.model = model;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return (APP_SCREEN_WIDTH - 30) * 140 / 343 + 20;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
