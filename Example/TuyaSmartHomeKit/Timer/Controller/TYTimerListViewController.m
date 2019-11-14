//
//  TYTimerListViewController.m
//  TuyaSmartHomeKit_Example
//
//  Created by Sakata Gintoki on 2019/11/11.
//  Copyright © 2019 xuchengcheng. All rights reserved.
//

#import "TYTimerListViewController.h"
#import "TYDeviceProperty.h"
#import "TPDeviceTimerListCell.h"
#import "TPDeviceTimerPeriodView.h"
#import "TYTimerDetailViewController.h"
#import "Masonry.h"

@interface TYTimerListViewController () <UITableViewDelegate, UITableViewDataSource,TPTimerListDelagate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) TuyaSmartTimer *timerService;
@property (nonatomic, strong) NSMutableArray *list;
@property (nonatomic, strong) NSMutableDictionary *propertyDic;
@property (nonatomic, strong) UIButton *addButton;
@end

@implementation TYTimerListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.topBarView.leftItem = self.leftBackItem;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, TY_ScreenWidth(), self.view.height - 200)];
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.addButton setTitle:@"Add Timer" forState:UIControlStateNormal];
    [self.addButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [self.addButton setBackgroundColor:UIColor.orangeColor];
    [self.addButton addTarget:self action:@selector(addButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.addButton];
    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(90);
    }];
//    [self reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self reloadData];
}

- (void)addButtonPressed {
    TYTimerDetailViewController *vc = [[TYTimerDetailViewController alloc] initWithDevId:self.devId category:self.category propertyDic:self.propertyDic timerModel:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

- (TuyaSmartTimer *)timerService {
    if (!_timerService) {
        _timerService = [TuyaSmartTimer new];
    }
    return _timerService;
}

- (NSMutableDictionary *)propertyDic {
    if (!_propertyDic) {
        NSDictionary *dic = @{
            @"dpId":@"1",
            @"dpName":@"Switch",
            @"rangeKeys":@[
                @"1",
                @"0"
            ],
            @"rangeValues":@[
                @"ON",
                @"OFF"
            ],
            @"selected":@(0),
        };
        TYDeviceProperty *property = [TYDeviceProperty propertyWithDict:dic];
        _propertyDic = @{@"1":property}.mutableCopy;
    }
    
    return _propertyDic;
}

- (void)reloadData {
    [TPProgressUtils showMessag:nil toView:nil];
    WEAKSELF_AT
    [self.timerService getTimerWithTask:self.category devId:self.devId success:^(NSArray<TYTimerModel *> *list) {
        [TPProgressUtils hideHUDForView:nil animated:NO];
        weakSelf_AT.list = list.mutableCopy;
        [weakSelf_AT.tableView reloadData];
    } failure:^(NSError *error) {
        [TPProgressUtils hideHUDForView:nil animated:NO];
    }];
}

#pragma Timer SDK Demo functions
- (void)removeDeviceTimer:(TYTimerModel *)model indexPath:(NSIndexPath *)indexPath {
    [TPProgressUtils showMessag:nil toView:nil];
    WEAKSELF_AT
    [self.timerService removeTimerWithTask:self.category devId:self.devId timerId:model.timerId success:^{

        [TPProgressUtils hideHUDForView:nil animated:NO];
        for (int i = 0; i < weakSelf_AT.list.count; i++) {
            TYTimerModel *group = [weakSelf_AT.list objectAtIndex:i];
            if ([group.timerId isEqualToString:model.timerId]) {
                [weakSelf_AT.list removeObjectAtIndex:i];
                break;
            }
        }
        if (weakSelf_AT.list.count > 0) {
            [weakSelf_AT.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        } else {
            [weakSelf_AT.tableView reloadData];
        }
        [weakSelf_AT reloadData];
    } failure:^(NSError *error) {
        [weakSelf_AT.tableView reloadData];
        [TPProgressUtils showError:error];
    }];
}

#pragma mark UITableViewDataSource

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        TYTimerModel *model = [self.list objectAtIndex:indexPath.row];
        [self removeDeviceTimer:model indexPath:indexPath];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TPDeviceTimerListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DeviceTimerListViewCellReuseIdentifier"];
    if (!cell) {
        cell = [[TPDeviceTimerListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DeviceTimerListViewCellReuseIdentifier"];
        cell.delegate = self;

    }
    
    TYTimerModel *model = [self.list objectAtIndex:indexPath.row];
    
    __block NSString *modeString = @"";
    
    [self.propertyDic enumerateKeysAndObjectsUsingBlock:^(id key, TYDeviceProperty *property, BOOL *stop) {
        id dpValue = [model.dps objectForKey:property.dpId];
        if (dpValue != nil) {
            modeString = [modeString stringByAppendingString:[NSString stringWithFormat:@"%@:%@ ",property.name,[property valueForKey:dpValue]]];
        } else {
            modeString = [modeString stringByAppendingString:[NSString stringWithFormat:@"%@:%@ ",property.name,[property valueAtIndex:0]]];
        }
    }];
    
    [cell setItem:model modeText:modeString];
//    cell.bottomLineView.hidden = YES;
    return cell;
}

#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    TYTimerModel *model = [self.list objectAtIndex:indexPath.row];
    NSString *appendixStr = model.aliasName;
    NSString *loopStr = ([model.loops isEqualToString:TIMER_LOOPS_NEVER])?NSLocalizedString(@"clock_timer_once", @""):[TPDeviceTimerPeriodView repeatStringWeek:model.loops];
    if (appendixStr.length) {
        appendixStr = [appendixStr stringByAppendingString:[NSString stringWithFormat:@"\n%@",loopStr]];
    } else {
        appendixStr = loopStr;
    }
    __block NSString *modeString = @"";
    
    [self.propertyDic enumerateKeysAndObjectsUsingBlock:^(id key, TYDeviceProperty *property, BOOL *stop) {
        id dpValue = [model.dps objectForKey:property.dpId];
        if (dpValue != nil) {
            modeString = [modeString stringByAppendingString:[NSString stringWithFormat:@"%@:%@ ",property.name,[property valueForKey:dpValue]]];
        } else {
            modeString = [modeString stringByAppendingString:[NSString stringWithFormat:@"%@:%@ ",property.name,[property valueAtIndex:0]]];
        }
    }];
    if (modeString.length) {
        appendixStr = [appendixStr stringByAppendingString:[NSString stringWithFormat:@"\n%@",modeString]];
    }
    CGFloat height = [TPDeviceTimerListCell heightWithString:appendixStr];
    return 40 + height + 15;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (_list.count >= 30) {
        UIAlertView *alert = [UIAlertView bk_showAlertViewWithTitle:@"" message:NSLocalizedString(@"timer_add_out_limited", @"") cancelButtonTitle:NSLocalizedString(@"cancel_tip", @"") otherButtonTitles:nil handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
            
        }];
        [alert show];
        return;
    }
    TYTimerModel *model = [self.list objectAtIndex:indexPath.row];
    TYTimerDetailViewController *vc = [[TYTimerDetailViewController alloc] initWithDevId:self.devId category:self.category propertyDic:self.propertyDic timerModel:model];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
