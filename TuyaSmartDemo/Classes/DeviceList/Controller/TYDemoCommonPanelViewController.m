//
//  TYCommonPanelViewController.m
//  TuyaSmartKitDemo
//
//  Created by 冯晓 on 16/8/27.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TYDemoCommonPanelViewController.h"
#import "TYDemoPanelBoolViewCell.h"
#import "TYDemoPanelValueViewCell.h"
#import "TYDemoPanelEnumViewCell.h"
#import "TYDemoPanelStringViewCell.h"
#import "TYDemoPanelBitmapViewCell.h"

#import "TPDemoUtils.h"

#import "TPDemoProgressUtils.h"

/*
 doc link
 
 en:https://tuyainc.github.io/tuyasmart_home_ios_sdk_doc/en/resource/Device.html#device-control
 zh-hans:https://tuyainc.github.io/tuyasmart_home_ios_sdk_doc/zh-hans/resource/Activator.html#%E8%AE%BE%E5%A4%87%E9%85%8D%E7%BD%91
 */

@interface TYDemoCommonPanelViewController() <UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation TYDemoCommonPanelViewController


- (void)viewDidLoad {

    [super viewDidLoad];
    [self initView];
}

- (void)initView {
    self.view.backgroundColor = MAIN_BACKGROUND_COLOR;
    
    [self.view addSubview:self.tableView];
    
    if (self.device) {
        [self updateOfflineView];
    }
}

- (UITableView *)tableView {
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, APP_TOP_BAR_HEIGHT, APP_SCREEN_WIDTH,APP_VISIBLE_HEIGHT)
                                                  style:UITableViewStylePlain];
        _tableView.backgroundColor = MAIN_BACKGROUND_COLOR;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = NO;
    }
    return _tableView;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.device) {
        return self.device.deviceModel.schemaArray.count;
    } else {
        return self.group.groupModel.schemaArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TuyaSmartSchemaModel *schemaModel = self.device.deviceModel.schemaArray[indexPath.row];
    
    NSDictionary *dps = [NSDictionary dictionary];
    if (self.device) {
        schemaModel = self.device.deviceModel.schemaArray[indexPath.row];
        dps = self.device.deviceModel.dps;
    } else {
        schemaModel = self.group.groupModel.schemaArray[indexPath.row];
        dps = self.group.groupModel.dps;
    }
    
    NSString *dpId = schemaModel.dpId;
    
    if ([schemaModel.type isEqualToString:@"obj"]) {
        
        if ([schemaModel.property.type isEqualToString:@"bool"]) {
            
            static NSString *CellIdentifier = @"CellBool";
            TYDemoPanelBoolViewCell *cell = (TYDemoPanelBoolViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            if (cell == nil) {
                cell = [[TYDemoPanelBoolViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                [cell.switchButton addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventTouchUpInside];
            }
            
            BOOL isOn = [[dps objectForKey:dpId] boolValue];
            
            [cell.switchButton setOn:isOn];
            
            [cell.titleView setItem:(indexPath.row + 1) title:schemaModel.name subTitle:[self getDpDesc:schemaModel]];
            
            return cell;
        } else if ([schemaModel.property.type isEqualToString:@"enum"]) {
            
            static NSString *CellIdentifier = @"CellEnum";
            TYDemoPanelEnumViewCell *cell = (TYDemoPanelEnumViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            if (cell == nil) {
                cell = [[TYDemoPanelEnumViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                
                WEAKSELF_AT
                [cell.switchLabel tysdkDemo_whenTapped:^{
                    
                    [weakSelf_AT modeAction:cell.switchLabel];
                }];
            }
            
            cell.switchLabel.text = [dps objectForKey:dpId];
        
            [cell.titleView setItem:(indexPath.row + 1) title:schemaModel.name subTitle:[self getDpDesc:schemaModel]];
            
            return cell;
        } else if ([schemaModel.property.type isEqualToString:@"value"]) {
            
            static NSString *CellIdentifier = @"CellValue";
            TYDemoPanelValueViewCell *cell = (TYDemoPanelValueViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            if (cell == nil) {
                cell = [[TYDemoPanelValueViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                
                [cell.minButton addTarget:self action:@selector(minAction:) forControlEvents:UIControlEventTouchUpInside];
                [cell.plusButton addTarget:self action:@selector(plusAction:) forControlEvents:UIControlEventTouchUpInside];
                
            }
            
            cell.titleLabel.text = [NSString stringWithFormat:@"%lu",(long)[[dps objectForKey:dpId] integerValue]];
            [cell.titleView setItem:(indexPath.row + 1) title:schemaModel.name subTitle:[self getDpDesc:schemaModel]];
            
            return cell;
        } else if ([schemaModel.property.type isEqualToString:@"bitmap"]) {
            
            static NSString *CellIdentifier = @"cellBitmap";
            
            TYDemoPanelBitmapViewCell *cell = (TYDemoPanelBitmapViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            if (cell == nil) {
                cell = [[TYDemoPanelBitmapViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            
            if ([[dps objectForKey:dpId] integerValue] < schemaModel.property.label.count) {
                
                cell.textLabel.text = [schemaModel.property.label objectAtIndex:[[dps objectForKey:dpId] integerValue]];
            }
            
            [cell.titleView setItem:(indexPath.row + 1) title:schemaModel.name subTitle:[self getDpDesc:schemaModel]];
            
            return cell;
        } else if ([schemaModel.property.type isEqualToString:@"string"]) {
            
            static NSString *CellIdentifier = @"CellString";
            TYDemoPanelStringViewCell *cell = (TYDemoPanelStringViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            if (cell == nil) {
                cell = [[TYDemoPanelStringViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                
                WEAKSELF_AT
                [cell.textField.rightView tysdkDemo_whenTapped:^{
                    
                    [weakSelf_AT textFieldAction:cell.textField];
                }];
            }
            
            cell.textField.text = [dps objectForKey:dpId];
            
            [cell.titleView setItem:(indexPath.row + 1) title:schemaModel.name subTitle:[self getDpDesc:schemaModel]];
            
            return cell;
        } else {
            return nil;
        }
    } else if ([schemaModel.type isEqualToString:@"raw"]) {

        static NSString *CellIdentifier = @"CellRaw";
        TYDemoPanelStringViewCell *cell = (TYDemoPanelStringViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            cell = [[TYDemoPanelStringViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            
            WEAKSELF_AT
            [cell.textField.rightView tysdkDemo_whenTapped:^{
                
                [weakSelf_AT textFieldAction:cell.textField];
            }];
        }

        cell.textField.text = [dps objectForKey:dpId];
        
        [cell.titleView setItem:(indexPath.row + 1) title:schemaModel.name subTitle:[self getDpDesc:schemaModel]];
        
        return cell;
    } else {
        return nil;
    }
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 74;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - TuyaSmartDeviceDelegate

/// dp数据更新
- (void)device:(TuyaSmartDevice *)device dpsUpdate:(NSDictionary *)dps {
    [self.tableView reloadData];
}

/// 设备信息更新
- (void)deviceInfoUpdate:(TuyaSmartDevice *)device {
    
}

/// 设备被移除
- (void)deviceRemoved:(TuyaSmartDevice *)device {
    
}

#pragma mark - TuyaSmartGroupDelegate

- (void)group:(TuyaSmartGroup *)group dpsUpdate:(NSDictionary *)dps {
    [self.tableView reloadData];
}

#pragma mark - action

- (void)messagePublishWithDps:(NSDictionary *)dps {
    [TPDemoProgressUtils showMessag:NSLocalizedString(@"loading", @"") toView:nil];
    
    if (self.device) {
        [self.device publishDps:dps success:^{

            [TPDemoProgressUtils hideHUDForView:nil animated:YES];

        } failure:^(NSError *error) {

            [TPDemoProgressUtils hideHUDForView:nil animated:YES];
            [TPDemoProgressUtils showError:error.localizedDescription];
        }];
    } else {
        [self.group publishDps:dps success:^{

            [TPDemoProgressUtils hideHUDForView:nil animated:YES];

        } failure:^(NSError *error) {

            [TPDemoProgressUtils hideHUDForView:nil animated:YES];
            [TPDemoProgressUtils showError:error.localizedDescription];
        }];
    }
}

- (void)switchAction:(UISwitch *)sender {
    
    TuyaSmartSchemaModel *schemaModel = [self getSchemaModelFromSubview:sender];
    NSString *dpId = schemaModel.dpId;
    [self messagePublishWithDps:@{dpId:@(sender.isOn)}];
}

- (void)plusAction:(UIButton *)sender {
    
    TuyaSmartSchemaModel *schemaModel = [self getSchemaModelFromSubview:sender];
    NSString *dpId = schemaModel.dpId;
    
    NSInteger currentValue = [[self.device.deviceModel.dps objectForKey:dpId] integerValue];
    
    currentValue += schemaModel.property.step;
    
    [self messagePublishWithDps:@{dpId:@(currentValue)}];
}

- (void)minAction:(UIButton *)sender {
    TuyaSmartSchemaModel *schemaModel = [self getSchemaModelFromSubview:sender];
    NSString *dpId = schemaModel.dpId;

    NSInteger currentValue = [[self.device.deviceModel.dps objectForKey:dpId] integerValue];

    currentValue -= schemaModel.property.step;
    
    [self messagePublishWithDps:@{dpId: @(currentValue)}];
}

- (void)modeAction:(UILabel *)label {
    
    TuyaSmartSchemaModel *schemaModel = [self getSchemaModelFromSubview:label];
    NSString *dpId = schemaModel.dpId;
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"action_more", @"") message:nil preferredStyle:UIAlertControllerStyleActionSheet];

    WEAKSELF_AT
    
    for (NSString *range in schemaModel.property.range) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:range style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [TPDemoProgressUtils showMessag:NSLocalizedString(@"loading", @"") toView:nil];
            
            [weakSelf_AT.device publishDps:@{dpId:range} success:^{
                
                [TPDemoProgressUtils hideHUDForView:nil animated:YES];
                
            } failure:^(NSError *error) {
                
                [TPDemoProgressUtils hideHUDForView:nil animated:YES];
                [TPDemoProgressUtils showError:error.localizedDescription];
            
            }];
        }];
        
        [alert addAction:action];
    }
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:NSLocalizedString(@"action_cancel", nil) style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)textFieldAction:(UITextField *)textField {
    
    if (textField.text.length == 0) {
        return;
    }
    
    TuyaSmartSchemaModel *schemaModel = [self getSchemaModelFromSubview:textField];
    NSString *dpId = schemaModel.dpId;
    
    [self messagePublishWithDps:@{dpId: textField.text}];
}

- (TuyaSmartSchemaModel *)getSchemaModelFromSubview:(UIView *)view {
    
    CGPoint pointInTable = [view convertPoint:view.bounds.origin toView:_tableView];
    NSIndexPath *indexPath = [_tableView indexPathForRowAtPoint:pointInTable];
    
    TuyaSmartSchemaModel *schemaModel = nil;
    if (self.device) {
        schemaModel = self.device.deviceModel.schemaArray[indexPath.row];
    } else {
        schemaModel = self.group.groupModel.schemaArray[indexPath.row];
    }
    
    return schemaModel;
}


- (NSString *)getDpDesc:(TuyaSmartSchemaModel *)schemaModel {
    
    NSString *string = @"";
    
    //DP 读写属性:
    //1 rw:可读写
    //2 wr:只写
    //3 ro:只读
    
    NSString *rwMode;
    
    
    if ([schemaModel.mode isEqualToString:@"rw"]) {
        rwMode = NSLocalizedString(@"send_report", nil);
    } else if ([schemaModel.mode isEqualToString:@"ro"]) {
        rwMode = NSLocalizedString(@"only_report", nil);
    } else {
        rwMode = NSLocalizedString(@"only_send", nil);
    }

    
    if ([schemaModel.type isEqualToString:@"obj"]) {
        
        if ([schemaModel.property.type isEqualToString:@"bool"]) {
            
            string = [NSString stringWithFormat:@"%@ | %@",NSLocalizedString(@"dp_bool", nil),rwMode];
            
        } else if ([schemaModel.property.type isEqualToString:@"enum"]) {
            
            string = [NSString stringWithFormat:@"%@ | %@",NSLocalizedString(@"dp_enum", nil),rwMode];
            
        } else if ([schemaModel.property.type isEqualToString:@"value"]) {
            
            string = [NSString stringWithFormat:@"%@ | %@",NSLocalizedString(@"dp_value", nil),rwMode];
            
        } else if ([schemaModel.property.type isEqualToString:@"bitmap"]) {
            
            string = [NSString stringWithFormat:@"%@ | %@",NSLocalizedString(@"dp_bitmap", nil),rwMode];
            
        } else if ([schemaModel.property.type isEqualToString:@"string"]) {
            
            string = [NSString stringWithFormat:@"%@ | %@",NSLocalizedString(@"dp_string", nil),rwMode];
            
        }
        
    } else if ([schemaModel.type isEqualToString:@"raw"]) {
        
        string = [NSString stringWithFormat:@"%@ | %@",NSLocalizedString(@"dp_raw", nil),rwMode];
        
    }
    
    return string;
}

@end
