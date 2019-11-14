//
//  TYTimerDetailViewController.m
//  TuyaSmartHomeKit_Example
//
//  Created by Sakata Gintoki on 2019/11/12.
//  Copyright © 2019 xuchengcheng. All rights reserved.
//

#import "TYTimerDetailViewController.h"
#import "TYTimerViewModel.h"
#import "TYTimerDatePickerTableViewCell.h"
#import "TYTimerCommonTableViewCell.h"
#import "TYTimerSwitchTableViewCell.h"
#import "TPDeviceTimerPeriodViewController.h"
#import "TYTimerDPSelectionViewController.h"

@interface TYTimerDetailViewController ()<UITableViewDelegate, UITableViewDataSource, TPDeviceTimerPeriodViewControllerDelegate,TYTimerDPSelectionViewControllerDelegate>
@property (nonatomic, strong) TYTimerViewModel *viewModel;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) NSInteger currentDpIndex;
@end

@implementation TYTimerDetailViewController

- (instancetype)initWithDevId:( NSString * _Nonnull)devId category:(NSString * _Nonnull)category propertyDic:(NSDictionary * _Nonnull)propertyDic timerModel:(nullable TYTimerModel *)timerModel {
    if (self = [super init]) {
        self.viewModel = [[TYTimerViewModel alloc] initWithDevId:devId category:category propertyDic:propertyDic timerModel:timerModel];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, TY_ScreenWidth(), self.view.height - 200)];
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = self.view.backgroundColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.topBarView.leftItem = self.leftBackItem;
    self.topBarView.rightItem = [TPBarButtonItem titleItem:@"Save" target:self action:@selector(rightBtnAction)];
}

- (void)rightBtnAction {
    WEAKSELF_AT
    [self.viewModel commitSaveSuccess:^{
        [weakSelf_AT.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        [TPProgressUtils showError:error];
    }];
}

#pragma  mark - table view protocols

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.viewModel commonCount] + [self.viewModel dpsCount];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < [self.viewModel commonCount]) {
        TY_Timer_Cell_Type_identifier cellId = [self.viewModel identifierWithIndex:indexPath.row];
        if ([cellId isEqualToString:TimerTableCellTypePicker]) {
            return [TYTimerDatePickerTableViewCell cellHeight];
        }
        if ([cellId isEqualToString:TimerTableCellTypeBlank]) {
            return 15;
        }
        if ([cellId isEqualToString:TimerTableCellTypeNotification]) {
            return [TYTimerSwitchTableViewCell cellHeight];
        }
        if ([cellId isEqualToString:TimerTableCellTypeRepeat]) {
            return 44;
        }
        if ([cellId isEqualToString:TimerTableCellTypeAlias]) {
            return [[TYTimerCommonTableViewCell new] cellHeightWithLeft:@"Alias Name" right:self.viewModel.aliasName];
        }
    }
    TYDeviceProperty *property = [self.viewModel devicePropertyAtIndex:indexPath.row];
    NSString *rightText = [self.viewModel dpValueAtIndex:indexPath.row];
    return [[TYTimerCommonTableViewCell new] cellHeightWithLeft:property.name right:rightText];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row < [self.viewModel commonCount]) {
        TY_Timer_Cell_Type_identifier cellId = [self.viewModel identifierWithIndex:indexPath.row];
        if ([cellId isEqualToString:TimerTableCellTypePicker]) {
            TYTimerDatePickerTableViewCell *pickerCell = [tableView dequeueReusableCellWithIdentifier:@"TYTimerDatePickerTableViewCell"];
            if (!pickerCell) {
                pickerCell = [[TYTimerDatePickerTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TYTimerDatePickerTableViewCell"];
                WEAKSELF_AT
                [pickerCell setTimeChangeBlock:^(NSString * _Nonnull time) {
                    [weakSelf_AT.viewModel setTime:time];
                }];
            }
            [pickerCell bindTimezonId:self.viewModel.timezoneId time:self.viewModel.time];
            
            return pickerCell;
        } else if ([cellId isEqualToString:TimerTableCellTypeBlank]) {
            UITableViewCell *blank = [tableView dequeueReusableCellWithIdentifier:@"blankCell"];
            if (!blank) {
                blank = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"blankCell"];
                blank.contentView.backgroundColor = self.view.backgroundColor;
                blank.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            return blank;
        } else if ([cellId isEqualToString:TimerTableCellTypeRepeat]) {
            TYTimerCommonTableViewCell *repeat = [tableView dequeueReusableCellWithIdentifier:@"TYTimerCommonTableViewCell"];
            if (!repeat) {
                repeat = [[TYTimerCommonTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TYTimerCommonTableViewCell"];
            }
            [repeat setDataWithLeft:@"Repeat" rightText:[self.viewModel loopsString]];
            return repeat;
        } else if ([cellId isEqualToString:TimerTableCellTypeAlias]) {
            TYTimerCommonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TYTimerCommonTableViewCell"];
            if (!cell) {
                cell = [[TYTimerCommonTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TYTimerCommonTableViewCell"];
            }
            [cell setDataWithLeft:@"Alias Name" rightText:self.viewModel.aliasName];
            return cell;
        } else if ([cellId isEqualToString:TimerTableCellTypeNotification]) {
            TYTimerSwitchTableViewCell *switchCell = [tableView dequeueReusableCellWithIdentifier:@"TYTimerSwitchTableViewCell"];
            if (!switchCell) {
                switchCell = [[TYTimerSwitchTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TYTimerSwitchTableViewCell"];
            }
            WEAKSELF_AT
            [switchCell setSwitchBlock:^(BOOL on) {
                [weakSelf_AT.viewModel setIsAppPush:on];
            }];
            [switchCell setOn:self.viewModel.isAppPush];
            return switchCell;
        }
    }
    
    
    TYDeviceProperty *property = [self.viewModel devicePropertyAtIndex:indexPath.row];
    NSString *rightText = [self.viewModel dpValueAtIndex:indexPath.row];
    TYTimerCommonTableViewCell *dpCell = [tableView dequeueReusableCellWithIdentifier:@"TYTimerCommonTableViewCell"];
    if (!dpCell) {
        dpCell = [[TYTimerCommonTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TYTimerCommonTableViewCell"];
    }
    [dpCell setDataWithLeft:property.name rightText:rightText];
    return dpCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.row < [self.viewModel commonCount]) {
        TY_Timer_Cell_Type_identifier cellId = [self.viewModel identifierWithIndex:indexPath.row];
        if ([cellId isEqualToString:TimerTableCellTypeRepeat]) {
            TPDeviceTimerPeriodViewController *repeatModeViewController = [[TPDeviceTimerPeriodViewController alloc] initWithQuery:@{@"loops":self.viewModel.loops}];
            repeatModeViewController.delegate = self;
            [self.navigationController pushViewController:repeatModeViewController animated:YES];

        } else if ([cellId isEqualToString:TimerTableCellTypeAlias]) {
            //Write your own text edit logic.
        }
    } else {
        TYDeviceProperty *property = [self.viewModel devicePropertyAtIndex:indexPath.row];
        
        NSNumber *selected;
        if ([[self.viewModel dps] objectForKey:property.dpId] != nil) {
            selected = [NSNumber numberWithInteger:[property indexOfKey:[[self.viewModel dps] objectForKey:property.dpId]]];
        } else {
            selected = [NSNumber numberWithInteger:property.seledted];
        }
        

        TYTimerDPSelectionViewController *controller = [[TYTimerDPSelectionViewController alloc] initWithValues:property.rangeValues index:selected.integerValue];
        controller.delegate = self;
        [self.navigationController pushViewController:controller animated:YES];
        self.currentDpIndex = indexPath.row;
    }
    
    
}

- (void)setRepeatMode:(NSString *)loops loopsWeek:(NSString *)loopsWeek {
    [self.viewModel setLoops:loops];
    [self.tableView reloadData];
}

- (void)dpSelectionViewItemSelectedAtIndex:(NSInteger)index {
    TYDeviceProperty *property = [self.viewModel devicePropertyAtIndex:self.currentDpIndex];
    NSMutableDictionary *dps = [self.viewModel.dps mutableCopy];
    if ([property keyAtIndex:index] != [NSNull null]) {
        [dps setObject:[property keyAtIndex:index] forKey:property.dpId];
    } else {
        [dps removeObjectForKey:property.dpId];
    }
    [self.viewModel setDps:dps];
    [self.tableView reloadData];
}
@end
