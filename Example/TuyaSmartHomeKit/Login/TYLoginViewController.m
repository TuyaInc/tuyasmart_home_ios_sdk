//
//  TYLoginViewController.m
//  TuyaSmartHomeKit_Example
//
//  Created by Tuya.Inc on 2018/11/5.
//  Copyright © 2018 xuchengcheng. All rights reserved.
//

#import "TYLoginViewController.h"
#import "TYLoginAndRegisterView.h"
#import "TYLoginAndRegisterUtils.h"
#import "TYSmartHomeManager.h"
#import "TYAppDelegate.h"
#import "TYTabBarViewController.h"

@interface TYLoginViewController () <TYLoginAndRegisterViewDelegate>

@property (nonatomic, strong) TYLoginAndRegisterView *rootView;

@end

/*
 doc link
 
 en:https://tuyainc.github.io/tuyasmart_home_ios_sdk_doc/en/resource/User.html#user-management
 zh-hans:https://tuyainc.github.io/tuyasmart_home_ios_sdk_doc/zh-hans/resource/User.html#%E7%94%A8%E6%88%B7%E7%AE%A1%E7%90%86
 */

@implementation TYLoginViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTopBarView];
    self.rootView = [[TYLoginAndRegisterView alloc] initWithType:TYLoginAndRegisterViewTypeLogin];
    self.rootView.delegate = self;
    [self.view addSubview:self.rootView];
    self.view.backgroundColor = [UIColor whiteColor];
    [self autoFillCountryCode];
}

- (void)initTopBarView {
    
    self.centerTitleItem.title = NSLocalizedString(@"login", @"");
    self.topBarView.centerItem = self.centerTitleItem;
    self.rightTitleItem.title = NSLocalizedString(@"login_register", @"");
    self.topBarView.rightItem = self.rightTitleItem;
    [self.view addSubview:self.topBarView];
}

- (void)rightBtnAction {
    
    TYRegisterViewController *registerViewController = [TYRegisterViewController new];
    [self.navigationController pushViewController:registerViewController animated:YES];
}

- (void)autoFillCountryCode {
    
    NSString *code = [TYLoginAndRegisterUtils getDefaultCountryCode];
    if (code.length > 0) {
        self.rootView.countryCodeField.text = code;
    }
}

#pragma mark - TYLoginAndRegisterViewDelegate

- (void)loginAndRegisterViewTrigerredAction:(TYLoginAndRegisterViewActionType)actionType {
    if (actionType == TYLoginAndRegisterViewActionTypeLogin) {
        [self passwordLogin];
    }
}

- (void)passwordLogin {
    [self.view endEditing:YES];
    if (self.rootView.accountField.text.length == 0) {
        [TPProgressUtils showError:@"Account cannot be empty."];
        return;
    }
    
    if (self.rootView.countryCodeField.text.length == 0) {
        [TPProgressUtils showError:@"Country code cannot be empty."];
        return;
    }
    
    if (self.rootView.passwordField.text.length < 6) {
        [TPProgressUtils showError:@"Password length cannot be less than 6."];
        return;
    }
    
    if ([TYLoginAndRegisterUtils isValidateEmail:self.rootView.accountField.text]) {
        [self loginWithEmailAndPassword];
    } else {
        [self loginWithPhoneNumberAndPassword];
    }
}

/**
 @brief Email login
 */
- (void)loginWithEmailAndPassword {
    
    NSString *countryCode   = self.rootView.countryCodeField.text;
    NSString *email         = self.rootView.accountField.text;
    NSString *password      = self.rootView.passwordField.text;
    
    [self showProgressView];
    
    WEAKSELF_AT
    [[TuyaSmartUser sharedInstance] loginByEmail:countryCode email:email password:password success:^{
        [weakSelf_AT hideProgressView];
        // 跳转到设备列表页
        TYAppDelegate *appDelegate = (TYAppDelegate*) [[UIApplication sharedApplication] delegate];
        [appDelegate resetRootViewController:[TYTabBarViewController class]];
        
    } failure:^(NSError *error) {
        [TPProgressUtils showError:error.localizedDescription];
        [weakSelf_AT hideProgressView];
    }];
}


/**
 @brief Mobile phone login
 */
- (void)loginWithPhoneNumberAndPassword {
    NSString *countryCode   = self.rootView.countryCodeField.text;
    NSString *phoneNumber   = self.rootView.accountField.text;
    NSString *password      = self.rootView.passwordField.text;
    
    [self showProgressView];
    WEAKSELF_AT
    
    [[TuyaSmartUser sharedInstance] loginByPhone:countryCode phoneNumber:phoneNumber password:password success:^{
        [weakSelf_AT hideProgressView];
        // 跳转到设备列表页
        TYAppDelegate *appDelegate = (TYAppDelegate*) [[UIApplication sharedApplication] delegate];
        [appDelegate resetRootViewController:[TYTabBarViewController class]];
        
    } failure:^(NSError *error) {
        [weakSelf_AT hideProgressView];
        [TPProgressUtils showError:error.localizedDescription];
    }];
}


@end
