//
//  TYSelectDPViewController.m
//  TuyaSmartPublic
//
//  Created by XuChengcheng on 16/7/6.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TYSelectDPViewController.h"
#import "TYSelectDPTableViewCell.h"
#import "TYSelectDPLocationView.h"
#import "TYLocationItem.h"
#import "TYSelectCityViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface TYSelectDPViewController () <UIPickerViewDelegate, UIPickerViewDataSource, TYSelectCityViewControllerDelegate>

@property (nonatomic, strong) UIPickerView *onTimePickerView;
@property (nonatomic, assign) NSInteger selectedRow;
@property (nonatomic, strong) TYSelectDPLocationView *locationView;
@property (nonatomic, strong) TuyaSmartCityModel *currentCity;
@property (nonatomic, assign) BOOL isWeather;//是否是气象数据

@end

@implementation TYSelectDPViewController

- (void)viewDidLoad {
    _isWeather = _model.entityType == 3;
    [super viewDidLoad];
    
    if ([self titleForRightItem].length > 0) {
        
        if (_model.selectedOperationRow < 0) {
            _model.selectedOperationRow = 0;
        }
        
        if (_model.selectedRow < 0) {
            _model.selectedRow = 0;
        }
    }
    [self initView];
}

- (void)initView {
    self.view.backgroundColor = MAIN_BACKGROUND_COLOR;
    
    if (_model.valueRangeJson.count > 0) {
        [self.view addSubview:self.tableView];
        self.tableView.frame = CGRectMake(0, APP_TOP_BAR_HEIGHT, APP_CONTENT_WIDTH, APP_VISIBLE_HEIGHT);
        self.tableView.tableHeaderView = [self headerView];
        [self initData];
    } else {
        [self initPickerView];
    }
    
    [self getCityInfo];
}

- (UIView *)headerView {
    
    if (_isWeather) {
        //气象数据
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_SCREEN_WIDTH, 92)];
        _locationView = [[TYSelectDPLocationView alloc] initWithFrame:CGRectMake(0, 20, APP_CONTENT_WIDTH, 48)];
        [_locationView setCity:NSLocalizedString(@"ty_smart_positioning", nil)];
        [headerView addSubview:_locationView];
        
        WEAKSELF_AT
        [_locationView bk_whenTapped:^{
            [weakSelf_AT gotoCityList];
        }];
        return headerView;
    } else {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_SCREEN_WIDTH, 20)];
        return headerView;
    }
}

- (void)gotoCityList {
    if (![[TuyaSmartUser sharedInstance].countryCode isEqualToString:@"86"]) {
        //国外账号，是使用地图选择城市的，如果定位没开，需要提示
        if (![self isLocationEnable]) {
            
            [UIAlertView bk_showAlertViewWithTitle:NSLocalizedString(@"location_permission", nil) message:nil cancelButtonTitle:NSLocalizedString(@"cancel", nil) otherButtonTitles:@[NSLocalizedString(@"open_permisions", nil)] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
                if (buttonIndex == 1) {
                    [self gotoSystemLocationSetting];
                }
            }];
            return;
        }
    }
    TYSelectCityViewController *vc = [TYSelectCityViewController new];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)initPickerView
{
    UIView *headerView = [self headerView];
    headerView.top = APP_TOP_BAR_HEIGHT;
    [self.view addSubview:headerView];
    
    UIView *onTimeView = [TPViewUtil viewWithFrame:CGRectMake(0, headerView.bottom, APP_SCREEN_WIDTH, 200) color:[UIColor whiteColor]];
    _onTimePickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(15, 10, APP_SCREEN_WIDTH - 30, 200)];
    _onTimePickerView.showsSelectionIndicator = YES;
    _onTimePickerView.dataSource = self;
    _onTimePickerView.delegate = self;
    
    if (_isCondition)
    {
        int i = 0;
        if (_model.expr.count > 0)
        {
            NSArray *value = _model.expr[0];
            NSString *condition = value[1];
            NSArray *operations = [_model.operators tp_objectFromJSONString];
            
            for (NSString *operation in operations)
            {
                if ([operation isEqualToString:condition])
                {
                    break;
                }
                i++;
            }
        }
        [_onTimePickerView selectRow:i inComponent:0 animated:YES];
        [_onTimePickerView selectRow:_model.selectedRow inComponent:1 animated:NO];
        _model.selectedOperationRow = i;
    }
    else
    {
        [_onTimePickerView selectRow:_model.selectedRow inComponent:0 animated:NO];
        if (_model.selectedRow == -1)
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationSmartSceneDPChange object:@{@"row" : @(_row), @"selectedRow" : @(0)}];
        }
    }
    
    [onTimeView addSubview:_onTimePickerView];
    [onTimeView addSubview:[TPViewUtil viewWithFrame:CGRectMake(0, 199.5, APP_SCREEN_WIDTH, 0.5) color:SEPARATOR_LINE_COLOR]];
    [self.view addSubview:onTimeView];
}


- (NSString *)titleForCenterItem {
    return _model.entityName;
}

- (NSString *)titleForRightItem {
    if ((_model.valueRangeJson.count == 0 && _isCondition) || _isWeather) {
        return NSLocalizedString(@"ty_smart_scene_save", @"");
    } else {
        return nil;
    }
}

- (void)rightBtnAction {
    if (_isWeather)
    {
        if (_currentCity.cityId <= 0) {
            [TPProgressUtils showError:NSLocalizedString(@"ty_smart_scene_nocity", nil)];
            return;
        }
        _model.entityId = [NSString stringWithFormat:@"%lu",(long)_currentCity.cityId];
        _model.cityId = _model.entityId;
        _model.cityName = _currentCity.city;
        _model.entityName = _model.entityName;
    }
    if (_isCondition)
    {
        NSString *expr1 = _isWeather ? [NSString stringWithFormat:@"$%@",_model.entitySubId] : [NSString stringWithFormat:@"$dp%ld",(long)_model.dpId];
        
        if ([_model.dpModel.property.type isEqualToString:@"enum"]) {
            _model.expr = @[@[expr1, @"==", _model.dpModel.property.range[_model.selectedRow]]];
        } else if ([_model.dpModel.property.type isEqualToString:@"bool"]) {
            if (_model.selectedRow == 0) {
                _model.expr = @[@[expr1, @"==", @(YES)]];
            } else {
                _model.expr = @[@[expr1, @"==", @(NO)]];
            }
        } else if ([_model.dpModel.property.type isEqualToString:@"value"]) {
            _model.dpModel.property.scale = _model.dpModel.property.min + _model.selectedRow * _model.dpModel.property.step;
            NSArray *operations = [_model.operators tp_objectFromJSONString];
            _model.expr = @[@[expr1, operations[_model.selectedOperationRow], @(_model.dpModel.property.scale)]];
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationSmartSceneDPSave object:@{@"model" : @[_model], @"selectedItem" : @(_selectedItem), @"isCondition":@(_isCondition)}];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

//是否显示下拉刷新
- (BOOL)showPullToRefresh {
    return NO;
}
//是否显示上拉刷新
- (BOOL)showInfinite {
    return NO;
}


- (void)getCityInfo
{
    WEAKSELF_AT
    if (_isWeather) {
        
        if (_selectedItem == -1)
        {
            //新增
            TYLocationItem *locationItem = [TYLocationItem getLocationInfo];

            [[TuyaSmartSceneManager sharedInstance] getCityInfoWithLatitude:locationItem.latitude longitude:locationItem.longitude success:^(TuyaSmartCityModel *city) {
                if (city.cityId > 0 && city.city.length > 0)
                {
                    weakSelf_AT.currentCity = city;
                    [weakSelf_AT.locationView setCity:city.city];
                }
                else
                {
                    [weakSelf_AT.locationView setCity:NSLocalizedString(@"ty_smart_nopositioning", nil)];
                }
            } failure:^(NSError *error) {
                [weakSelf_AT.locationView setCity:NSLocalizedString(@"ty_smart_nopositioning", nil)];
            }];
        }
        else
        {
            if (_model.entityId.length == 0)
            {
                [weakSelf_AT.locationView setCity:NSLocalizedString(@"ty_smart_nopositioning", nil)];
                return;
            }
            
            [[TuyaSmartSceneManager sharedInstance] getCityInfoWithCityId:_model.entityId success:^(TuyaSmartCityModel *city) {
                if (city.cityId > 0 && city.city.length > 0)
                {
                    weakSelf_AT.currentCity = city;
                    [weakSelf_AT.locationView setCity:city.city];
                }
                else
                {
                    [weakSelf_AT.locationView setCity:NSLocalizedString(@"ty_smart_nopositioning", nil)];
                }
            } failure:^(NSError *error) {
                [weakSelf_AT.locationView setCity:NSLocalizedString(@"ty_smart_nopositioning", nil)];
            }];
        }
    }
}


- (void)initData {
    for (NSArray *array in _model.valueRangeJson) {
        [self.dataSource addObject:array];
    }
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
    TYSelectDPTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[TYSelectDPTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.titleLabel.text = self.dataSource[indexPath.row][1];
    cell.selectedImageView.hidden = YES;
    if (_model.selectedRow == indexPath.row) {
        cell.selectedImageView.hidden = NO;
    }
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (_isCondition) {
        _model.selectedRow = indexPath.row;
        if (!_isWeather) {
            [self rightBtnAction];
        } else {
            [self.tableView reloadData];
        }
    } else {
        if (_model.selectedRow == indexPath.row) {
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationSmartSceneDPChange object:@{@"row" : @(_row), @"selectedRow" : @(-1)}];
        } else {
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationSmartSceneDPChange object:@{@"row" : @(_row), @"selectedRow" : @(indexPath.row)}];
        }
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    if (_isCondition) {
        return 2;
    } else {
        return 1;
    }
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (_isCondition) {
        if (component == 1) {
            return (_model.dpModel.property.max - _model.dpModel.property.min) / _model.dpModel.property.step + 1;
        } else {
            NSArray *operations = [_model.operators tp_objectFromJSONString];
            return operations.count;
        }
    } else {
        return (_model.dpModel.property.max - _model.dpModel.property.min) / _model.dpModel.property.step + 1;
    }
}

- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *text = [self pickerView:pickerView titleForRow:row forComponent:component];
    NSMutableAttributedString *attributed = [[NSMutableAttributedString alloc] initWithString:text];
    [attributed addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(0, text.length)];
    
    return attributed;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    if (_isCondition) {
        if (component == 0) {
            return 120;
        }
        return 200;
    } else {
        return 200;
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 40;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    NSString *text = [NSString string];
    if (_isCondition) {
        if (component == 1) {
            text = [NSString stringWithFormat:@"%ld%@", (NSInteger)(_model.dpModel.property.min + row * _model.dpModel.property.step), _model.dpModel.property.unit];
        } else {
            NSArray *operations = [_model.operators tp_objectFromJSONString];
            if ([operations[row] isEqualToString:@"<"]) {
                text = NSLocalizedString(@"ty_smart_scene_edit_lessthan", @"");
            } else if ([operations[row] isEqualToString:@">"]) {
                text = NSLocalizedString(@"ty_smart_scene_edit_morethan", @"");
            } else if ([operations[row] isEqualToString:@"=="]) {
                text = NSLocalizedString(@"ty_smart_scene_edit_equal", @"");
            }
        }
        
        return text;
    } else {
        text = [NSString stringWithFormat:@"%ld%@", (NSInteger)(_model.dpModel.property.min + row * _model.dpModel.property.step), _model.dpModel.property.unit];
    }
    
    return text;
}

#pragma mark - UIPickerViewDelegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (_isCondition)
    {
        if (component == 0)
        {
            _model.selectedOperationRow = row;
        }
        else
        {
            _model.dpModel.property.scale = _model.dpModel.property.min + row * _model.dpModel.property.step;
            _model.selectedRow = row;
        }
    }
    else
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationSmartSceneDPChange object:@{@"row" : @(_row), @"selectedRow" : @(row)}];
    }
}

#pragma mark - TYSelectCityViewControllerDelegate
- (void)viewController:(TYSelectCityViewController *)vc didSelectCity:(TuyaSmartCityModel *)city {
    if (city.cityId > 0) {
        self.currentCity = city;
        [_locationView setCity:city.city];
    }
}

//判断是否开启定位服务
- (BOOL)isLocationEnable {
    
    if ([CLLocationManager locationServicesEnabled] == NO ||
        [CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied ||
        [CLLocationManager authorizationStatus] == kCLAuthorizationStatusRestricted){
        return NO;
    } else {
        return YES;
    }
}

- (void)gotoSystemLocationSetting {
    
    NSURL *url = [NSURL URLWithString:@"App-Prefs:root=Privacy&path=LOCATION"];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 10.0) {
        [[UIApplication sharedApplication] openURL:url];
    } else {
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL success) {
            ;
        }];
    }
    
}

@end
