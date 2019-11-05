//
//  TYGroupListViewController.m
//  TuyaSmartHomeKit_Example
//
//  Created by 温明妍 on 2019/10/29.
//  Copyright © 2019 xuchengcheng. All rights reserved.
//

#import "TYGroupListViewController.h"
#import <Masonry/Masonry.h>
#import "TYSmartHomeManager.h"
#import "TYPanelBaseGroupViewController.h"

@interface TYGroupListViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UILabel *emptyLabel;

@end

@implementation TYGroupListViewController

#pragma mark - --------------------dealloc ------------------
#pragma mark - --------------------life cycle--------------------

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initView];
}

- (void)initData {
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
}

- (void)initView {
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self.view addSubview:self.emptyLabel];
    [self.emptyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
}

- (void)reloadData {
    if (TYSmartHomeManager.sharedInstance.currentHome.groupList.count) {
        self.emptyLabel.hidden = YES;
    } else {
        self.emptyLabel.hidden = NO;
    }
    [self.tableView reloadData];
}

#pragma mark - --------------------UITableViewDelegate--------------

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    
    TuyaSmartGroupModel *groupModel = [[TYSmartHomeManager sharedInstance].currentHome.groupList objectAtIndex:indexPath.row];
    cell.textLabel.text = groupModel.name;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count = [TYSmartHomeManager sharedInstance].currentHome.groupList.count;
    return count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    TuyaSmartGroupModel *groupModel = [[TYSmartHomeManager sharedInstance].currentHome.groupList objectAtIndex:indexPath.row];
    if (!groupModel.deviceList.count) {
        [self showNoDeviceAlert:groupModel];
    } else {
        TYPanelBaseGroupViewController *panelVC = [[TYPanelBaseGroupViewController alloc] init];
        panelVC.groupId = groupModel.groupId;
        [self.navigationController pushViewController:panelVC animated:YES];
    }
}

- (void)showNoDeviceAlert:(TuyaSmartGroupModel *)groupModel {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"group_item_flag", @"")
                                                                             message:NSLocalizedString(@"group_no_device", @"")
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    WEAKSELF_AT
    UIAlertAction *dismiss = [UIAlertAction actionWithTitle:NSLocalizedString(@"group_no_device_dismiss", @"") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf_AT dismissGroup:groupModel];
        
    }];
    [alertController addAction:dismiss];
    UIAlertAction *manage =  [UIAlertAction actionWithTitle:NSLocalizedString(@"group_no_device_manage", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertController addAction:manage];
    
    [self.navigationController presentViewController:alertController animated:YES completion:nil];
}

- (void)dismissGroup:(TuyaSmartGroupModel *)groupModel {
    TuyaSmartGroup *group = [TuyaSmartGroup groupWithGroupId:groupModel.groupId];
    [group dismissGroup:^{
        [TPProgressUtils showSuccess:@"success" toView:self.view];
    } failure:^(NSError *error) {
        [TPProgressUtils showSuccess:@"failure" toView:self.view];
    }];
}

#pragma mark - --------------------CustomDelegate--------------
#pragma mark - --------------------Event Response--------------
#pragma mark - --------------------private methods--------------
#pragma mark - --------------------getters & setters & init members ------------------

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (UILabel *)emptyLabel {
    if (!_emptyLabel) {
        _emptyLabel = [[UILabel alloc] init];
        _emptyLabel.textColor = [UIColor blackColor];
        _emptyLabel.text = NSLocalizedString(@"home_no_group", @"");
    }
    return _emptyLabel;
}

@end
