//
//  TYSelectConditionViewController.m
//  TuyaSmartPublic
//
//  Created by 冯晓 on 2016/11/2.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TYSelectConditionViewController.h"
#import "TYSelectDeviceListViewController.h"
#import "TYSelectDPViewController.h"
#import "TYSelectConditionTableViewCell.h"

@interface TYSelectConditionViewController ()

@end

@implementation TYSelectConditionViewController

- (void)dealloc {
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initView];
}

- (void)initData {
    WEAKSELF_AT
    [[TuyaSmartSceneManager sharedInstance] getConditionListWithFahrenheit:YES success:^(NSArray<TuyaSmartSceneDPModel *> *list) {
        
        weakSelf_AT.dataSource = [NSMutableArray arrayWithArray:list];
        [weakSelf_AT reloadTable];
    } failure:^(NSError *error) {
        
    }];
}

- (void)initView {
 
    self.tableViewStyle = UITableViewStyleGrouped;
    self.tableView.frame = CGRectMake(0, APP_TOP_BAR_HEIGHT, APP_SCREEN_WIDTH, APP_VISIBLE_HEIGHT);
    self.tableView.separatorColor = LIST_LINE_COLOR;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:self.tableView];
}

- (NSString *)titleForCenterItem {
    return NSLocalizedString(@"ty_smart_scene_select_condition", nil);
}

//是否显示下拉刷新
- (BOOL)showPullToRefresh {
    return NO;
}

//是否显示上拉刷新
- (BOOL)showInfinite {
    return NO;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 48;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"UITableViewCell";
    TYSelectConditionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[TYSelectConditionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    TuyaSmartSceneDPModel *model = nil;
    if (indexPath.row >= self.dataSource.count) {
        cell.textLabel.text = NSLocalizedString(@"ty_smart_scene_device", nil);
        
    } else {
        model = [self.dataSource objectAtIndex:indexPath.row];
        cell.textLabel.text = model.entityName;
    }
    
    if (_model.entityType == 3 && indexPath.row < self.dataSource.count && [_model.entitySubIds isEqualToString:model.entitySubId]) {
        NSArray *array = [_model.exprDisplay componentsSeparatedByString:@":"];
        if (array.count >= 2) {
            cell.subTitleLabel.text = [array lastObject];
        }
    } else if (_model.entityType == 1 && indexPath.row == self.dataSource.count) {
        cell.subTitleLabel.text = _model.entityName;
    } else {
        cell.subTitleLabel.text = @"";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.row == self.dataSource.count)
    {
        TYSelectDeviceListViewController *vc = [[TYSelectDeviceListViewController alloc] init];
        vc.selectDevList = self.selectDevList;
        vc.isCondition = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {
        TuyaSmartSceneDPModel *model = [self.dataSource objectAtIndex:indexPath.row];
        TYSelectDPViewController *vc = [[TYSelectDPViewController alloc] init];
        if (_model.entityType == 3 && indexPath.row < self.dataSource.count && [_model.entitySubIds isEqualToString:model.entitySubId])
        {
            vc.model = [self formateSceneDPModel:model];
            vc.selectedItem = 0;
        }
        else
        {
            vc.model = model;
            model.selectedRow = -1;
            vc.selectedItem = -1;
        }
        vc.isCondition = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 48;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    
    
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 24, 200, 16)];
    textLabel.backgroundColor = [UIColor clearColor];
    textLabel.font = [UIFont systemFontOfSize:12];
    textLabel.textColor = LIST_LIGHT_TEXT_COLOR;
    textLabel.text = NSLocalizedString(@"ty_smart_scene_condition", nil);
    [view addSubview:textLabel];
    
    return view;
}

- (TuyaSmartSceneDPModel *)formateSceneDPModel:(TuyaSmartSceneDPModel *)model
{
    model.selectedRow = -1;
    model.entityId = self.model.entityId;
    model.expr = self.model.expr;
    if (self.model.expr.count == 1)
    {
        NSArray *value = self.model.expr[0];
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
    return model;
}

@end
