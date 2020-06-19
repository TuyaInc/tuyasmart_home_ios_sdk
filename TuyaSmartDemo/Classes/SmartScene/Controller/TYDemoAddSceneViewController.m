//
//  TYAddSceneViewController.m
//  TuyaSmartPublic
//
//  Created by TuyaInc on 19/1/30.
//  Copyright © 2019年 Tuya. All rights reserved.
//

#import "TYDemoAddSceneViewController.h"
#import "TYDemoTextFieldTableViewCell.h"
#import "TYDemoEditActionTableViewCell.h"
#import "TYDemoEditActionTitleTableViewCell.h"
#import "TYDemoEditActionNoDataTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "TYDemoConfiguration.h"

#import <TuyaSmartSceneKit/TuyaSmartSceneKit.h>
#import "TPDemoUtils.h"
#import "TPDemoProgressUtils.h"

@interface TYDemoAddSceneViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) TuyaSmartSceneModel *model;

@property (nonatomic, strong) TuyaSmartScene *smartScene;

@property (nonatomic, strong) UITextField *activeTextField;

@property (nonatomic, strong) NSString *textFieldText;

@property (nonatomic, strong) NSMutableArray *conditionArray;

@property (nonatomic, strong) NSString *backImageUrl;

@property (nonatomic, assign) TuyaSmartConditionMatchType matchType;

@end

#define AddSceneTableViewCellIdentifier @"AddSceneTableViewCellIdentifier"

@implementation TYDemoAddSceneViewController

#pragma mark - init & UI

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    _smartScene = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initView];
    [self initData];
}

- (void)initView
{
    [self.view addSubview:self.tableView];
    self.topBarView.leftItem = [[TPDemoBarButtonItem alloc] initWithTitle:NSLocalizedString(@"cancel", @"") style:UIBarButtonItemStylePlain target:self action:@selector(CancelButtonTap)];
    WEAKSELF_AT
    [self.tableView tysdkDemo_whenTapped:^{
        if ([weakSelf_AT.activeTextField isFirstResponder]) {
            [weakSelf_AT.activeTextField resignFirstResponder];
        }
    }];
    self.tableView.frame = CGRectMake(0, APP_TOP_BAR_HEIGHT, APP_CONTENT_WIDTH, APP_VISIBLE_HEIGHT);
}

- (void)initData
{
    _backImageUrl = @"https://images.tuyacn.com/smart/rule/cover/starry.png";
    _matchType = TuyaSmartConditionMatchAny;
    [self simulateSceneConditions];
    [self simulateSceneActions];
    [self.tableView reloadData];
}

- (void)simulateSceneConditions {
    //1.weather condition
    //1.1 Temperature : Smaller than -25°F
    TuyaSmartSceneConditionModel *condition1 = [[TuyaSmartSceneConditionModel alloc] init];
    condition1.entityType = 3;                                      //3 represent whether conditon type.
    condition1.cityName = @"city name";                             //show to user
    condition1.entityId = @"1085519087003893822";                   //cityId, achieve with latitude and longitude.
    condition1.exprDisplay = @"Temperature : Smaller than -25°F";   //show to user, when you create a new condition,this property should be created by yourself.
    condition1.expr = @[@[@"$temp",@"<",@(-25)]];                   //expression to describe the condition
    condition1.entitySubIds = @"temp";                              //entitySubIds
    //1.2 Humidity : Comfortable
    TuyaSmartSceneConditionModel *condition2 = [[TuyaSmartSceneConditionModel alloc] init];
    condition2.entityType = 3;
    condition2.cityName = @"city name";
    condition2.entityId = @"1085519087003893822";
    condition2.exprDisplay = @"Humidity : Comfortable";
    condition2.expr = @[@[@"$humidity",@"==",@"comfort"]];
    condition2.entitySubIds = @"humidity";
    //1.3 Weather : Rainy day
    TuyaSmartSceneConditionModel *condition3 = [[TuyaSmartSceneConditionModel alloc] init];
    condition3.entityType = 3;
    condition3.cityName = @"city name";
    condition3.entityId = @"1085519087003893822";
    condition3.exprDisplay = @"Weather : Rainy day";
    condition3.expr = @[@[@"$condition",@"==",@"rainy"]];
    condition3.entitySubIds = @"condition";
    //1.4 PM2.5 : Good
    TuyaSmartSceneConditionModel *condition4 = [[TuyaSmartSceneConditionModel alloc] init];
    condition4.entityType = 3;
    condition4.cityName = @"city name";
    condition4.entityId = @"1085519087003893822";
    condition4.exprDisplay = @"PM2.5 : Good";
    condition4.expr = @[@[@"$pm25",@"==",@"fine"]];
    condition4.entitySubIds = @"pm25";
    //1.5 AQI : Good
    TuyaSmartSceneConditionModel *condition5 = [[TuyaSmartSceneConditionModel alloc] init];
    condition5.entityType = 3;
    condition5.cityName = @"city name";
    condition5.entityId = @"1085519087003893822";
    condition5.exprDisplay = @"AQI : Good";
    condition5.expr = @[@[@"$aqi",@"==",@"fine"]];
    condition5.entitySubIds = @"aqi";
    //1.6 Sunrise and sunset : Sunset
    TuyaSmartSceneConditionModel *condition6 = [[TuyaSmartSceneConditionModel alloc] init];
    condition6.entityType = 3;
    condition6.cityName = @"city name";
    condition6.entityId = @"1085519087003893822";
    condition6.exprDisplay = @"Sunrise and sunset : Sunset";
    condition6.expr = @[@[@"$sunsetrise",@"==",@"sunset"]];
    condition6.entitySubIds = @"sunsetrise";
    
    //2.timer condition
    TuyaSmartSceneConditionModel *condition7 = [[TuyaSmartSceneConditionModel alloc] init];
    condition7.entityType = 6;
    condition7.entityId = @"timer";
    condition7.entityName = @"Timer";
    condition7.exprDisplay = @"The timer description";
    condition7.expr = @[@{
                            @"date" : @"20190230",
                            @"loops" : @"0000000",
                            @"time" : @"15:40",
                            @"timeZoneId" : @"Asia/Shanghai",
                            }];
    condition7.entitySubIds = @"timer";
    
    //3.device dp conditon
//    TuyaSmartSceneConditionModel *condition8 = [[TuyaSmartSceneConditionModel alloc] init];
//    condition8.entityType = 1;  //Device dp as a condition, entityType is 1.
//    condition8.entityName = @"device name";
//    condition8.entityId = @"6c1231332d13c35e14rmof";    //devId, device Id.
//    condition8.exprDisplay = @"Switch : ON";
//    condition8.expr = @[@[@"$dp1",@"==",@(YES)]];
//    condition8.entitySubIds = @"1";                 //dpId
    
    [self.conditionArray addObject:condition1];
    [self.conditionArray addObject:condition2];
    [self.conditionArray addObject:condition3];
    [self.conditionArray addObject:condition4];
    [self.conditionArray addObject:condition5];
    [self.conditionArray addObject:condition6];
    [self.conditionArray addObject:condition7];
//    [self.conditionArray addObject:condition8];
}

- (void)simulateSceneActions {
    //1.ruleTrigger
//    TuyaSmartSceneActionModel *action1 = [[TuyaSmartSceneActionModel alloc] init];
//    action1.actionExecutor = @"ruleTrigger";
//    action1.entityName = @"rule name";
//    action1.entityId = @"the sceneId to execute";
    //2.ruleEnable
//    TuyaSmartSceneActionModel *action2 = [[TuyaSmartSceneActionModel alloc] init];
//    action2.actionExecutor = @"ruleEnable";
//    action2.entityName = @"auto name";
//    action2.entityId = @"the auto to enable";
    //3.ruleDisable
//    TuyaSmartSceneActionModel *action3 = [[TuyaSmartSceneActionModel alloc] init];
//    action3.actionExecutor = @"ruleDisable";
//    action3.entityName = @"auto name";
//    action3.entityId = @"the auto to disable";
    //4.appPushTrigger
    TuyaSmartSceneActionModel *action4 = [[TuyaSmartSceneActionModel alloc] init];
    action4.actionExecutor = @"appPushTrigger";
    action4.entityName = @"Message center";
    //5.delay
    TuyaSmartSceneActionModel *action5 = [[TuyaSmartSceneActionModel alloc] init];
    action5.entityId = @"delay";
    action5.entityName = @"delay for a while";
    action5.actionExecutor = @"delay";
    action5.executorProperty = @{@"minutes":@"1",@"seconds":@"30"};
    //6.deviceGroupDpIssue
//    TuyaSmartSceneActionModel *action6 = [[TuyaSmartSceneActionModel alloc] init];
//    action6.entityId = @"the groupId to excuted";
//    action6.actionExecutor = @"deviceGroupDpIssue";
//    action6.executorProperty = @{@"1":@(YES)};
    //7.dpIssue ,device action
//    TuyaSmartSceneActionModel *action7 = [[TuyaSmartSceneActionModel alloc] init];
//    action7.actionExecutor = @"dpIssue";
//    action7.entityId = @"6c1231332d13c35e14rmof";
//    action7.entityName = @"device name";
//    action7.executorProperty = @{@"1":@(YES)};
//    action7.actionDisplay = @"Switch:Open";
    
//    [self.dataSource addObject:action1];
//    [self.dataSource addObject:action2];
//    [self.dataSource addObject:action3];
    [self.dataSource addObject:action4];
    [self.dataSource addObject:action5];
//    [self.dataSource addObject:action6];
//    [self.dataSource addObject:action7];
}

- (NSString *)titleForCenterItem
{
    return NSLocalizedString(@"ty_smart_scene_add_new_scene", @"");
}

- (NSString *)titleForRightItem
{
    return NSLocalizedString(@"ty_smart_scene_save", @"");
}

- (TuyaSmartScene *)smartScene
{
    if (_smartScene == nil) {
        if (self.model.sceneId.length > 0)
        {
            _smartScene = [TuyaSmartScene sceneWithSceneModel:self.model];
        }
    }
    return _smartScene;
}

- (NSMutableArray *)conditionArray
{
    if (!_conditionArray)
    {
        _conditionArray = [NSMutableArray new];
        if (_model.conditions.count > 0)
        {
            for (TuyaSmartSceneConditionModel *model in _model.conditions)
            {
                if (model.entityType == 3)
                {
                    [_conditionArray addObject:model];
                }
                else
                {
                    TuyaSmartDevice *smartDevice = [TuyaSmartDevice deviceWithDeviceId:model.entityId];
                    if (smartDevice != nil)
                    {
                        [_conditionArray addObject:model];
                    }
                }
            }
        }
    }
    return _conditionArray;
}

#pragma mark - Common Events

- (void)rightBtnAction
{
    if ([self.activeTextField isFirstResponder]) {
        [self.activeTextField resignFirstResponder];
    }
    [self saveSmartScene];
}

- (void)CancelButtonTap
{
    [super CancelButtonTap];
}

#pragma mark - API

- (void)saveSmartScene
{
    NSString *title = [_activeTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (title.length == 0 && _model.code.length == 0)
    {
        [TPDemoProgressUtils showError:NSLocalizedString(@"ty_smart_scene_name_enter", @"")];
        return;
    }
    
    //默认场景：有code无id，自定义场景：有id无code
    
    if (self.dataSource.count == 0)
    {
        [TPDemoProgressUtils showError:NSLocalizedString(@"ty_smart_scene_error_add_work", @"")];
        return;
    }
    NSString *sceneName = @"";
    if (self.model.code.length == 0)//添加或编辑自定义场景
    {
        sceneName = self.activeTextField.text;
    }
    else//编辑默认场景
    {
        sceneName = self.model.name;
    }

    [self addSmartSceneWithName:sceneName];
}

// Create scene
- (void)addSmartSceneWithName:(NSString *)name
{
    [TPDemoProgressUtils showMessag:NSLocalizedString(@"loading", nil) toView:self.view];
    id<TYDemoDeviceListModuleProtocol> impl = [[TYDemoConfiguration sharedInstance] serviceOfProtocol:@protocol(TYDemoDeviceListModuleProtocol)];
    long long homeId = [impl currentHomeId];
    WEAKSELF_AT
    [TuyaSmartScene addNewSceneWithName:name homeId:homeId background:_backImageUrl showFirstPage:YES preConditionList:nil conditionList:self.conditionArray actionList:self.dataSource matchType:_matchType success:^(TuyaSmartSceneModel *sceneModel) {
        [TPDemoProgressUtils hideHUDForView:weakSelf_AT.view animated:NO];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"kNotificationSmartSceneListUpdate" object:nil];
        [weakSelf_AT dismissViewControllerAnimated:YES completion:^{
            
        }];
    } failure:^(NSError *error) {
        [TPDemoProgressUtils hideHUDForView:weakSelf_AT.view animated:YES];
        [TPDemoProgressUtils showError:error];
    }];
}

// Edit scene, similar to create scene.
- (void)editSmartSceneWithName:(NSString *)name
{
    [TPDemoProgressUtils showMessag:NSLocalizedString(@"loading", nil) toView:self.view];
    WEAKSELF_AT
    [self.smartScene modifySceneWithName:name background:_backImageUrl showFirstPage:YES preConditionList:nil conditionList:self.conditionArray actionList:self.dataSource matchType:_matchType success:^{
        [TPDemoProgressUtils hideHUDForView:weakSelf_AT.view animated:NO];
        [weakSelf_AT dismissViewControllerAnimated:YES completion:^{
            
        }];
    } failure:^(NSError *error) {
        [TPDemoProgressUtils hideHUDForView:weakSelf_AT.view animated:YES];
        [TPDemoProgressUtils showError:error];
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        if (self.conditionArray.count == 0) {
            return 2;
        } else {
            return self.conditionArray.count + 1;
        }
    } else if (section == 2) {
        if (self.dataSource.count == 0) {
            return 2;
        } else {
            return self.dataSource.count + 1;
        }
    } else {
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 60;
    } else {
        if (indexPath.row == 0) {
            return 48;
        } else {
            if (indexPath.section == 1) {
                if (self.conditionArray.count == 0) {
                    return 76;
                } else {
                    return 64;
                }
            } else {
                if (self.dataSource.count == 0) {
                    return 76;
                } else {
                    return 64;
                }
            }
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        NSString *cellIdentifier = @"textFieldCell";
        TYDemoTextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[TYDemoTextFieldTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        cell.textField.attributedText = [[NSAttributedString alloc] initWithString:@"" attributes:@{NSForegroundColorAttributeName : HEXCOLOR(0x303030)}];
        cell.textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"ty_smart_scene_name_enter", @"") attributes:@{NSForegroundColorAttributeName : HEXCOLOR(0x9b9b9b)}];
        cell.textField.delegate = self;
        if (self.activeTextField == nil) {
            self.activeTextField = cell.textField;
            _textFieldText = nil;
        }
        [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:_backImageUrl]];
        cell.textField.text = _textFieldText;
        if (_model.code.length > 0) {
            cell.textField.text = @"";
            cell.textField.placeholder = _model.name;
            cell.textField.enabled = NO;
        }
        return cell;
    } else {
        if (indexPath.row == 0) {
            NSString *cellIdentifier = @"titleSceneCell";
            TYDemoEditActionTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil) {
                cell = [[TYDemoEditActionTitleTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            }
            
            if (indexPath.section == 1) {
                
                if (_matchType == TuyaSmartConditionMatchAll) {
                    cell.titleLabel.text = NSLocalizedString(@"scene_condition_type_and", @"");
                } else {
                    cell.titleLabel.text = NSLocalizedString(@"scene_condition_type_or", @"");
                }
                
            } else {
                cell.titleLabel.text = NSLocalizedString(@"ty_smart_scene_start", @"");
            }
            
            return cell;
            
        } else {
            if ((indexPath.section == 1 && self.conditionArray.count == 0) || (indexPath.section == 2 && self.dataSource.count == 0)) {
                NSString *cellIdentifier = @"noDataSceneCell";
                TYDemoEditActionNoDataTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                if (cell == nil) {
                    cell = [[TYDemoEditActionNoDataTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
                }
                if (indexPath.section == 1) {
                    cell.titleLabel.text = NSLocalizedString(@"ty_smart_scene_add_notadded", @"");
                } else {
                    cell.titleLabel.text = NSLocalizedString(@"ty_smart_scene_add_notaddedwork", @"");
                }
                return cell;
            } else {
                NSString *cellIdentifier = @"SceneCell";
                TYDemoEditActionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                if (cell == nil) {
                    cell = [[TYDemoEditActionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
                }
                if (indexPath.section == 1) {
                    TuyaSmartSceneConditionModel *model = self.conditionArray[indexPath.row - 1];
                    if (model.entityType == 3) {
                        cell.offlineLabel.hidden = YES;
                        cell.titleLable.text = model.cityName;
                        cell.subTitleLabel.text = model.exprDisplay;
                    } else if (model.entityType == 6) {
                        cell.offlineLabel.hidden = YES;
                        cell.titleLable.text = model.entityName;
                        cell.subTitleLabel.text = model.exprDisplay;
                    } else {
                        TuyaSmartDevice *smartDevice = [TuyaSmartDevice deviceWithDeviceId:model.entityId];
                        cell.offlineLabel.hidden = smartDevice.deviceModel.isOnline;
                        cell.titleLable.text = model.entityName;
                        cell.subTitleLabel.text = model.exprDisplay;
                    }
                } else {
                    TuyaSmartSceneActionModel *model = self.dataSource[indexPath.row - 1];
                    if ([model.actionExecutor isEqualToString:@"dpIssue"]) {
                        TuyaSmartDevice *smartDevice = [TuyaSmartDevice deviceWithDeviceId:model.entityId];
                        cell.titleLable.text = smartDevice.deviceModel.name;
                        cell.subTitleLabel.text = model.actionDisplay;
                    }else if ([model.actionExecutor isEqualToString:@"appPushTrigger"]){
                        cell.titleLable.text = model.entityName;
                        cell.subTitleLabel.text = @"push message to message center";
                    }else if ([model.actionExecutor isEqualToString:@"delay"]) {
                        cell.titleLable.text = model.entityName;
                        cell.subTitleLabel.text = [NSString stringWithFormat:@"%@:%@",model.executorProperty[@"minutes"],model.executorProperty[@"seconds"]];
                    }
                }
                
                return cell;
            }
        }
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_CONTENT_WIDTH, 20)];
    view.backgroundColor = HEXCOLOR(0xf2f2f2);
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (self.dataSource.count == 0 && section == 2 && self.conditionArray.count == 0) {
        return 0;
    }
    if (section == 1) {
        return 30;
    }
    return 20;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    self.activeTextField = textField;
    _textFieldText = textField.text;
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {

    if (string.length == 0)
        return YES;
    
    NSInteger strLength = textField.text.length - range.length + string.length;
    if (strLength > 25) {
        return NO;
    }
    
    return YES;
}

@end
