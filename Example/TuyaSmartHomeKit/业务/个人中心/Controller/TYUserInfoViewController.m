//
//  TYUserInfoViewController.m
//  TuyaSmartPublic
//
//  Created by 高森 on 16/5/16.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TYUserInfoViewController.h"
#import "TYUserInfoHeadViewCell.h"
#import "TYUserInfoNickViewCell.h"
#import "TYUserInfoPhoneViewCell.h"
#import "TYAppDelegate.h"
#import "MobileChangeViewController.h"
#import "MobileBindingViewController.h"
#import "TYUserInfoPassCell.h"
#import "TPSignUpViewController.h"

@interface TYUserInfoViewController() <UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate, TPItemViewDelegate>

@property (nonatomic, strong) UITableView   *tableView;

@end

@implementation TYUserInfoViewController

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[TuyaSmartUser sharedInstance] cancelRequest];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reloadData)
                                                 name:TPNotificationUpdateUserInfo
                                               object:nil];
    
    
    [[TuyaSmartUser sharedInstance] updateUserInfo:nil failure:nil];
    
}

- (void)reloadData {
    [_tableView reloadData];
}


- (void)initView {
    
    self.centerTitleItem.title = NSLocalizedString(@"personal_center", @"");
    self.topBarView.centerItem = self.centerTitleItem;
    self.topBarView.leftItem = self.leftBackItem;
    self.topBarView.rightItem = nil;
    
    [self.view addSubview:self.topBarView];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, APP_TOP_BAR_HEIGHT, APP_CONTENT_WIDTH, APP_VISIBLE_HEIGHT) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = MAIN_BACKGROUND_COLOR;
    [self.view addSubview:_tableView];
    
    TPItemView *signoutItemView = [TPItemView itemViewWithFrame:CGRectMake(0, 0, APP_SCREEN_WIDTH, 50)];
    signoutItemView.topLine.hidden = NO;
    signoutItemView.bottomLine.hidden = NO;
    signoutItemView.centerLabel.textColor = SUB_BUTTON_TEXT_COLOR;
    signoutItemView.centerLabel.text = NSLocalizedString(@"logout", @"");
    signoutItemView.delegate = self;
    _tableView.tableFooterView = signoutItemView;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 3;
    } else {
        
        return 1;
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0 && indexPath.section == 0) {
        return 100;
    } else {
        return 50;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 18;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            TYUserInfoHeadViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"head"];
            if (!cell) {
                cell = [[TYUserInfoHeadViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"head"];
            }
            return cell;
        } else if (indexPath.row == 1) {
            TYUserInfoNickViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"nick"];
            if (!cell) {
                cell = [[TYUserInfoNickViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"nick"];
            }
            
            NSString *nickName;
            
            if ([TuyaSmartUser sharedInstance].nickname.length > 0) {
                nickName = [TuyaSmartUser sharedInstance].nickname;
            } else {
                nickName = NSLocalizedString(@"click_set_neekname", nil);
            }
            
            [cell setNickName:nickName];
            
            return cell;
        } else {
            TYUserInfoPhoneViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"phone"];
            if (!cell) {
                cell = [[TYUserInfoPhoneViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"phone"];
            }
            
            
            [cell setPhoneNumber:[TuyaSmartUser sharedInstance].phoneNumber showArrow:![[TuyaSmartUser sharedInstance].phoneNumber isEqualToString:[TuyaSmartUser sharedInstance].userName]];
            return cell;
        }
        
    } else {
    
        TYUserInfoPassCell *cell = [tableView dequeueReusableCellWithIdentifier:@"passwd"];
        if (!cell) {
            cell = [[TYUserInfoPassCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"passwd"];
        }
        
        [cell setTitle:NSLocalizedString(@"ty_change_login_keyword", nil) content:@""];
        return cell;
        
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.section == 0) {
    
        if (indexPath.row == 1) {
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"edit_nickname", @"") message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"cancel", @"") otherButtonTitles:NSLocalizedString(@"save", @""),nil];
            alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
            [[alertView textFieldAtIndex:0] setText:[TuyaSmartUser sharedInstance].nickname];
            alertView.delegate = self;
            [alertView show];
        } else if (indexPath.row == 2) {
            [self gotoBindingViewController];
        }
    } else {
        
        if (indexPath.row == 0) {
            
            //修改登录密码
            
            if ([TuyaSmartUser sharedInstance].phoneNumber.length > 0 || [TuyaSmartUser sharedInstance].email.length > 0) {
                [self gotoChangePasswordViewController];
            } else {
                WEAKSELF_AT
                [UIAlertView bk_showAlertViewWithTitle:NSLocalizedString(@"ty_bind_phone_num", @"") message:NSLocalizedString(@"ty_not_bind_phone_num", @"") cancelButtonTitle:NSLocalizedString(@"action_cancel", nil) otherButtonTitles:@[NSLocalizedString(@"ty_bind_phone_num_now", nil)] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
                    
                    if (buttonIndex == 1) {
                        [weakSelf_AT gotoBindingViewController];
                    } else {
                    }
                }];
                
            }
            
            return;
        }
        
        WEAKSELF_AT
        [UIAlertView bk_showAlertViewWithTitle:NSLocalizedString(@"ty_bind_phone_num", @"") message:NSLocalizedString(@"ty_not_bind_phone_num", @"") cancelButtonTitle:NSLocalizedString(@"action_cancel", nil) otherButtonTitles:@[NSLocalizedString(@"ty_bind_phone_num_now", nil)] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
            
            if (buttonIndex == 1) {
                [weakSelf_AT gotoBindingViewController];
            }
        }];
    }
}

- (void)gotoBindingViewController {
    
    if ([[TuyaSmartUser sharedInstance].phoneNumber isEqualToString:[TuyaSmartUser sharedInstance].userName]) {
        return;
    }
    
    if ([TuyaSmartUser sharedInstance].phoneNumber.length > 0) {
        MobileChangeViewController *vc = [[MobileChangeViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        MobileBindingViewController *vc = [[MobileBindingViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)gotoChangePasswordViewController {
    
    NSString *userAccount;
    if ([TuyaSmartUser sharedInstance].phoneNumber.length > 0) {
        //86-150xxxxxxxx
        NSArray *array = [[TuyaSmartUser sharedInstance].phoneNumber componentsSeparatedByString:@"-"];
        userAccount = [array lastObject];
    } else if ([TuyaSmartUser sharedInstance].email.length > 0) {
        userAccount = [TuyaSmartUser sharedInstance].email;
    }
    
    if (userAccount.length > 0) {
        TPSignUpViewController *vc = [TPSignUpViewController new];
        vc.countryCode = [TuyaSmartUser sharedInstance].countryCode;
        vc.userAccount = userAccount;
        vc.type = TPVerifyTypeModify;
        [self.navigationController pushViewController:vc animated:YES];
    }

}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        NSString *nickname = [[alertView textFieldAtIndex:0] text];
        if (nickname.length > 0) {
            [self doModifyNickname:nickname];
        } else {
            [TPProgressUtils showError:NSLocalizedString(@"nickname_is_null", @"")];
        }
    }
}

- (void)doModifyNickname:(NSString *)nickname {
    
    [self showProgressView];
    WEAKSELF_AT
    [[TuyaSmartUser sharedInstance] updateNickname:nickname success:^{
        [weakSelf_AT hideProgressView];
        [weakSelf_AT.tableView reloadData];
        [[NSNotificationCenter defaultCenter] postNotificationName:TPNotificationUpdateUserInfo object:nil];
        [TPProgressUtils showError:NSLocalizedString(@"nickname_edit_success", @"")];
    } failure:^(NSError *error) {
        [weakSelf_AT hideProgressView];
        [TPProgressUtils showError:NSLocalizedString(@"nickname_edit_failure", @"")];
    }];
}


#pragma mark - TPItemViewDelegate

- (void)itemViewTap:(TPItemView *)itemView {
    [self signout];
}

- (void)signout {
    TYAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    [appDelegate signOut];
}

@end
