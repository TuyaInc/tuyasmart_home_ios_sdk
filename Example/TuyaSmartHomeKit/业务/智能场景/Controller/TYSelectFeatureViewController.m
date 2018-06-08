//
//  TYSelectFeatureViewController.m
//  TuyaSmartPublic
//
//  Created by XuChengcheng on 16/7/6.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TYSelectFeatureViewController.h"
#import "TYEditSceneTableViewCell.h"
#import "TYSelectDPViewController.h"

@interface TYSelectFeatureViewController ()

@end

@implementation TYSelectFeatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [self initData];
}

- (void)initView {

    self.tableViewStyle = UITableViewStyleGrouped;
    self.tableView.frame = CGRectMake(0, APP_TOP_BAR_HEIGHT, APP_CONTENT_WIDTH, APP_VISIBLE_HEIGHT);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorColor = LIST_LINE_COLOR;
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_SCREEN_WIDTH, 20)];
    self.tableView.tableHeaderView = headerView;
    [self.view addSubview:self.tableView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTableView:) name:kNotificationSmartSceneDPChange object:nil];
}

- (NSString *)titleForCenterItem {
    return NSLocalizedString(@"ty_smart_scene_choose_func", @"");
}

- (NSString *)titleForRightItem {
    return NSLocalizedString(@"ty_smart_scene_save", @"");
}

//是否显示下拉刷新
- (BOOL)showPullToRefresh {
    return NO;
}
//是否显示上拉刷新
- (BOOL)showInfinite {
    return NO;
}

- (void)initData {
    WEAKSELF_AT
    [self showLoadingView];
    
    if (_isCondition)
    {
        TuyaSmartDevice *smartDevice = [TuyaSmartDevice deviceWithDeviceId:self.entityId];

        [[TuyaSmartSceneManager sharedInstance] getCondicationDeviceDPListWithDevId:smartDevice.deviceModel.devId success:^(NSArray<TuyaSmartSceneDPModel *> *list) {
            for (TuyaSmartSceneDPModel *model in list)
            {
                [weakSelf_AT.dataSource addObject:[weakSelf_AT formateSceneDPModel:model]];
            }
            [weakSelf_AT hideLoadingView];
            [weakSelf_AT.tableView reloadData];
        } failure:^(NSError *error) {
            [weakSelf_AT hideLoadingView];
            [TPProgressUtils showError:error];
        }];
    }
    else
    {
        [[TuyaSmartSceneManager sharedInstance] getActionDeviceDPListWithDevId:self.entityId success:^(NSArray<TuyaSmartSceneDPModel *> *list){
            for (TuyaSmartSceneDPModel *model in list)
            {
                [weakSelf_AT.dataSource addObject:[weakSelf_AT formateSceneDPModel:model]];
            }
            [weakSelf_AT hideLoadingView];
            [weakSelf_AT.tableView reloadData];
        } failure:^(NSError *error) {
            [weakSelf_AT hideLoadingView];
            [TPProgressUtils showError:error];
        }];
    }
}

- (void)rightBtnAction {
    BOOL selected = NO;
    for (TuyaSmartSceneDPModel *model in self.dataSource) {
        if (model.selectedRow >= 0) {
            selected = YES;
            break;
        }
    }
    if (!selected) {
        [TPProgressUtils showError:NSLocalizedString(@"ty_device_func_cant_emp", @"")];
        return;
    }
    for (UIViewController *viewController in self.navigationController.viewControllers) {
        if ([viewController isKindOfClass:NSClassFromString(@"TYAddSceneViewController")]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationSmartSceneDPSave object:@{@"model" : self.dataSource, @"selectedItem" : @(_selectedItem)}];
            [self.navigationController popToViewController:viewController animated:YES];
            break;
        }
    }
}

- (void)refreshTableView:(NSNotification *)notification {
    NSDictionary *userInfo = notification.object;
    NSLog(@"userInfo : %@", userInfo);
    NSInteger row = [userInfo[@"row"] tp_toInt];
    TuyaSmartSceneDPModel *model = self.dataSource[row];
    model.selectedRow = [userInfo[@"selectedRow"] tp_toInt];
    if (model.valueRangeJson.count == 0 && model.selectedRow >= 0) {
        model.dpModel.property.scale = model.dpModel.property.min + [userInfo[@"selectedRow"] tp_toInt] * model.dpModel.property.step;
    }
    NSIndexPath *index = [NSIndexPath indexPathForRow:row inSection:0];
    [self.tableView reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 48;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"deviceListCell";
    TYEditSceneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[TYEditSceneTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.subTitleLabel.frame = CGRectMake(APP_CONTENT_WIDTH - 37 - 100, 0, 100, 48);
    cell.subTitleLabel.textAlignment = NSTextAlignmentRight;
    TuyaSmartSceneDPModel *model = self.dataSource[indexPath.row];
    
    model.devId = self.entityId;
    
    cell.titleLable.text = model.entityName;
    
    if (model.valueRangeJson.count > 0) {
        if (model.selectedRow == -1) {
            cell.subTitleLabel.text = @"";
        } else {
            NSArray *array = model.valueRangeJson[model.selectedRow];
            cell.subTitleLabel.text = array[1];
        }
        
    } else {
        
        if (model.selectedRow == -1) {
            cell.subTitleLabel.text = @"";
        } else {
            if (_isCondition && _expr.count == 1) {
                NSArray *value = _expr[0];
                NSString *condition = value[1];
                NSString *text = @"";
                if ([condition isEqualToString:@"<"]) {
                    text = NSLocalizedString(@"ty_smart_scene_edit_lessthan", @"");
                } else if ([condition isEqualToString:@">"]) {
                    text = NSLocalizedString(@"ty_smart_scene_edit_morethan", @"");
                } else if ([condition isEqualToString:@"=="]) {
                    text = NSLocalizedString(@"ty_smart_scene_edit_equal", @"");
                }
               
                cell.subTitleLabel.text = [NSString stringWithFormat:@"%@%ld%@", text, (long)model.dpModel.property.scale, model.dpModel.property.unit];
            } else {
                cell.subTitleLabel.text = [NSString stringWithFormat:@"%ld%@", (long)model.dpModel.property.scale, model.dpModel.property.unit];
            }
        }
    }
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    TYSelectDPViewController *vc = [[TYSelectDPViewController alloc] init];
    TuyaSmartSceneDPModel *model = self.dataSource[indexPath.row];
    model.expr = _expr;
    vc.model = model;
    vc.selectedItem = _selectedItem;
    vc.isCondition = _isCondition;
    vc.row = indexPath.row;
    [self.navigationController pushViewController:vc animated:YES];
}


- (TuyaSmartSceneDPModel *)formateSceneDPModel:(TuyaSmartSceneDPModel *)model
{
    model.selectedRow = -1;
    model.entityId = self.entityId;
    model.expr = self.expr;
    if (self.isCondition &&self.expr.count == 1)
    {
        NSArray *value = self.expr[0];
        NSString *dpIdStr = value[0];
        id obj = value[2];
        NSInteger dpId = 0;
        if (model.entityType != 3)
        {
            dpId = [[dpIdStr substringWithRange:NSMakeRange(3, dpIdStr.length - 3)] intValue];
        }
        if (model.dpId == dpId || model.entityType == 3)
        {
            if (model.valueRangeJson.count > 0)
            {
                if ([model.dpModel.property.type isEqualToString:@"bool"])
                {
                    if ([obj tp_toInt] == 0)
                    {
                        model.selectedRow = 1;
                    }
                    else
                    {
                        model.selectedRow = 0;
                    }
                }
                else
                {
                    for (int i = 0; i < model.dpModel.property.range.count; i ++)
                    {
                        if ([obj isEqualToString:model.dpModel.property.range[i]])
                        {
                            model.selectedRow = i;
                        }
                    }
                }
            }
            else
            {
                model.dpModel.property.scale = [obj tp_toInt];
                model.selectedRow = ([obj tp_toInt] - model.dpModel.property.min) / model.dpModel.property.step;
            }
        }
    }
    else
    {
        for (id keyItem in self.actDic)
        {
            id obj = [self.actDic objectForKey:keyItem];
            if (model.dpId == [keyItem tp_toInt])
            {
                if (model.valueRangeJson.count > 0)
                {
                    if ([model.dpModel.property.type isEqualToString:@"bool"])
                    {
                        if ([obj tp_toInt] == 0) {
                            model.selectedRow = 1;
                        } else {
                            model.selectedRow = 0;
                        }
                    }
                    else
                    {
                        for (int i = 0; i < model.dpModel.property.range.count; i ++)
                        {
                            if ([obj isEqualToString:model.dpModel.property.range[i]])
                            {
                                model.selectedRow = i;
                            }
                        }
                    }
                }
                else
                {
                    model.dpModel.property.scale = [obj tp_toInt];
                    model.selectedRow = ([obj tp_toInt] - model.dpModel.property.min) / model.dpModel.property.step;
                }
            }
        }
    }
    return model;
}

@end
