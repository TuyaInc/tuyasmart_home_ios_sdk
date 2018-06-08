//
//  TYCommonPanelViewController.m
//  TuyaSmartKitDemo
//
//  Created by 冯晓 on 16/8/27.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TYCommonPanelViewController.h"
#import "TYPanelBoolViewCell.h"
#import "TYPanelValueViewCell.h"
#import "TYPanelEnumViewCell.h"
#import "TYPanelStringViewCell.h"
#import "TYPanelBitmapViewCell.h"

@interface TYCommonPanelViewController() <UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate>


@property (nonatomic, strong) UITableView *tableView;

@end

@implementation TYCommonPanelViewController


- (void)viewDidLoad {
    
    [self initView];
    
    
    [super viewDidLoad];
}

- (void)initView {
    self.view.backgroundColor = MAIN_BACKGROUND_COLOR;
    
    [self.view addSubview:self.tableView];
    
    [self updateOfflineView];
    
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



#pragma mark UITableViewDataSource  UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.device.deviceModel.schemaArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    TuyaSmartSchemaModel *schemaModel = self.device.deviceModel.schemaArray[indexPath.row];
    
    NSDictionary *dps = self.device.deviceModel.dps;
    
    NSString *dpId = schemaModel.dpId;
    
    
    if ([schemaModel.type isEqualToString:@"obj"]) {
        
        
        if ([schemaModel.property.type isEqualToString:@"bool"]) {
            
        
            static NSString *CellIdentifier = @"CellBool";
            TYPanelBoolViewCell *cell = (TYPanelBoolViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            if (cell == nil) {
                cell = [[TYPanelBoolViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                [cell.switchButton addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventTouchUpInside];
            }
            
            BOOL isOn = [[dps objectForKey:dpId] tp_toBool];
            
            [cell.switchButton setOn:isOn];
            
            [cell.titleView setItem:(indexPath.row + 1) title:schemaModel.name subTitle:[self getDpDesc:schemaModel]];
            
            return cell;
        } else if ([schemaModel.property.type isEqualToString:@"enum"]) {
            
            
            static NSString *CellIdentifier = @"CellEnum";
            TYPanelEnumViewCell *cell = (TYPanelEnumViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            if (cell == nil) {
                cell = [[TYPanelEnumViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                
                WEAKSELF_AT
                [cell.switchLabel bk_whenTapped:^{
                    
                    [weakSelf_AT modeAction:cell.switchLabel];
                }];
            }
            
            cell.switchLabel.text = [dps objectForKey:dpId];
            
            
            [cell.titleView setItem:(indexPath.row + 1) title:schemaModel.name subTitle:[self getDpDesc:schemaModel]];
            
            return cell;

            
            
        } else if ([schemaModel.property.type isEqualToString:@"value"]) {
            
            
            static NSString *CellIdentifier = @"CellValue";
            TYPanelValueViewCell *cell = (TYPanelValueViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            if (cell == nil) {
                cell = [[TYPanelValueViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                
                [cell.minButton addTarget:self action:@selector(minAction:) forControlEvents:UIControlEventTouchUpInside];
                [cell.plusButton addTarget:self action:@selector(plusAction:) forControlEvents:UIControlEventTouchUpInside];
                
            }
            
            cell.titleLabel.text = [NSString stringWithFormat:@"%lu",(long)[[dps objectForKey:dpId] tp_toInt]];
            
            
            [cell.titleView setItem:(indexPath.row + 1) title:schemaModel.name subTitle:[self getDpDesc:schemaModel]];
            
            return cell;
        
            
        } else if ([schemaModel.property.type isEqualToString:@"bitmap"]) {
            
            
            static NSString *CellIdentifier = @"cellBitmap";
            
            TYPanelBitmapViewCell *cell = (TYPanelBitmapViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            if (cell == nil) {
                cell = [[TYPanelBitmapViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            
            if ([[dps objectForKey:dpId] tp_toInt] < schemaModel.property.label.count) {
                
                cell.textLabel.text = [schemaModel.property.label objectAtIndex:[[dps objectForKey:dpId] tp_toInt]];
                
            }
            
            [cell.titleView setItem:(indexPath.row + 1) title:schemaModel.name subTitle:[self getDpDesc:schemaModel]];
            
            return cell;
            
        } else if ([schemaModel.property.type isEqualToString:@"string"]) {
            
            
            
            static NSString *CellIdentifier = @"CellString";
            TYPanelStringViewCell *cell = (TYPanelStringViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            if (cell == nil) {
                cell = [[TYPanelStringViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                
                WEAKSELF_AT
                [cell.textField.rightView bk_whenTapped:^{
                    
                    [weakSelf_AT textFieldAction:cell.textField];
                }];
            }
            
            
            cell.textField.text = [[dps objectForKey:dpId] tp_toString];
            
            [cell.titleView setItem:(indexPath.row + 1) title:schemaModel.name subTitle:[self getDpDesc:schemaModel]];
            
            return cell;
            
        } else {
            return nil;
        }
        
    } else if ([schemaModel.type isEqualToString:@"raw"]) {
        
        
        static NSString *CellIdentifier = @"CellRaw";
        TYPanelStringViewCell *cell = (TYPanelStringViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            cell = [[TYPanelStringViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            
            WEAKSELF_AT
            [cell.textField.rightView bk_whenTapped:^{
                
                [weakSelf_AT textFieldAction:cell.textField];
            }];
        }
        
        
        cell.textField.text = [[dps objectForKey:dpId] tp_toString];
        
        [cell.titleView setItem:(indexPath.row + 1) title:schemaModel.name subTitle:[self getDpDesc:schemaModel]];
        
        return cell;
        
        
    } else {
        
        return nil;
    }
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 74;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - TuyaSmartDeviceDelegate
- (void)device:(TuyaSmartDevice *)device dpsUpdate:(NSDictionary *)dps {
    [self.tableView reloadData];
}

//- (void)deviceDpsUpdate:(NSDictionary *)dps {
//    [self.tableView reloadData];
//}


#pragma mark - action
- (void)switchAction:(UISwitch *)sender {
    
    
    TuyaSmartSchemaModel *schemaModel = [self getSchemaModelFromSubview:sender];
    NSString *dpId = schemaModel.dpId;
    
    
    [TPProgressUtils showMessag:NSLocalizedString(@"loading", @"") toView:nil];
    
    [self.device publishDps:@{dpId:@(sender.isOn)} success:^{
       
        [TPProgressUtils hideHUDForView:nil animated:YES];
        
    } failure:^(NSError *error) {
       
        [TPProgressUtils hideHUDForView:nil animated:YES];
        [TPProgressUtils showError:error.localizedDescription];
        
        
    }];
    
}

- (void)plusAction:(UIButton *)sender {
    
    TuyaSmartSchemaModel *schemaModel = [self getSchemaModelFromSubview:sender];
    NSString *dpId = schemaModel.dpId;
    
    NSInteger currentValue = [[self.device.deviceModel.dps objectForKey:dpId] tp_toInt];
    
    currentValue += schemaModel.property.step;
    
    
    [TPProgressUtils showMessag:NSLocalizedString(@"loading", @"") toView:nil];

    [self.device publishDps:@{dpId:@(currentValue)} success:^{
        
        [TPProgressUtils hideHUDForView:nil animated:YES];
        
    } failure:^(NSError *error) {
        
        [TPProgressUtils hideHUDForView:nil animated:YES];
        [TPProgressUtils showError:error.localizedDescription];
        
    }];
    
}


- (void)minAction:(UIButton *)sender {
    TuyaSmartSchemaModel *schemaModel = [self getSchemaModelFromSubview:sender];
    NSString *dpId = schemaModel.dpId;
    
    
    NSInteger currentValue = [[self.device.deviceModel.dps objectForKey:dpId] tp_toInt];

    currentValue -= schemaModel.property.step;
    
    [TPProgressUtils showMessag:NSLocalizedString(@"loading", @"") toView:nil];
    
    [self.device publishDps:@{dpId:@(currentValue)} success:^{

        [TPProgressUtils hideHUDForView:nil animated:YES];

    } failure:^(NSError *error) {
        
        [TPProgressUtils hideHUDForView:nil animated:YES];
        [TPProgressUtils showError:error.localizedDescription];
        
    }];
}

- (void)modeAction:(UILabel *)label {
    
    TuyaSmartSchemaModel *schemaModel = [self getSchemaModelFromSubview:label];
    NSString *dpId = schemaModel.dpId;
    
    
    UIActionSheet *actionSheet = [UIActionSheet bk_actionSheetWithTitle:NSLocalizedString(@"action_more", @"")];
    
    WEAKSELF_AT
    
    for (NSString *range in schemaModel.property.range) {
        
        [actionSheet bk_addButtonWithTitle:range handler:^{
            
            [TPProgressUtils showMessag:NSLocalizedString(@"loading", @"") toView:nil];
            
            [weakSelf_AT.device publishDps:@{dpId:range} success:^{
                
                [TPProgressUtils hideHUDForView:nil animated:YES];
                
            } failure:^(NSError *error) {
                
                [TPProgressUtils hideHUDForView:nil animated:YES];
                [TPProgressUtils showError:error.localizedDescription];
            
            }];
        }];
    }
    
    [actionSheet bk_setCancelButtonWithTitle:NSLocalizedString(@"action_cancel", nil) handler:nil];
    
    [actionSheet showInView:self.view];
}

- (void)textFieldAction:(UITextField *)textField {
    
    if (textField.text.length == 0) {
        return;
    }
    
    TuyaSmartSchemaModel *schemaModel = [self getSchemaModelFromSubview:textField];
    NSString *dpId = schemaModel.dpId;
    
    
    [TPProgressUtils showMessag:NSLocalizedString(@"loading", @"") toView:nil];
    
    [self.device publishDps:@{dpId:textField.text} success:^{

        [TPProgressUtils hideHUDForView:nil animated:YES];
        
    } failure:^(NSError *error) {
        
        
        [TPProgressUtils hideHUDForView:nil animated:YES];
        [TPProgressUtils showError:error.localizedDescription];
        
    }];
    
}

- (TuyaSmartSchemaModel *)getSchemaModelFromSubview:(UIView *)view {
    
    CGPoint pointInTable = [view convertPoint:view.bounds.origin toView:_tableView];
    NSIndexPath *indexPath = [_tableView indexPathForRowAtPoint:pointInTable];
    
    TuyaSmartSchemaModel *schemaModel = self.device.deviceModel.schemaArray[indexPath.row];
    
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
