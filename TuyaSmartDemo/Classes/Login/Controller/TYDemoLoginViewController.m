//
//  TYLoginViewController.m
//  TuyaSmartHomeKit_Example
//
//  Created by 盖剑秋 on 2018/11/5.
//  Copyright © 2018 xuchengcheng. All rights reserved.
//

#import "TYDemoLoginViewController.h"
#import "TYDemoLoginAndRegisterView.h"
#import "TYDemoLoginAndRegisterUtils.h"
#import "TYDemoConfiguration.h"
#import "TYDemoApplicationImpl.h"
#import "TYDemoTabBarViewController.h"

#import "TPDemoProgressUtils.h"

#import <TuyaSmartBaseKit/TuyaSmartBaseKit.h>

@interface TYDemoLoginViewController () <TYLoginAndRegisterViewDelegate>

@property (nonatomic, strong) TYDemoLoginAndRegisterView *rootView;

@end

/*
 doc link
 
 en:https://tuyainc.github.io/tuyasmart_home_ios_sdk_doc/en/resource/User.html#user-management
 zh-hans:https://tuyainc.github.io/tuyasmart_home_ios_sdk_doc/zh-hans/resource/User.html#%E7%94%A8%E6%88%B7%E7%AE%A1%E7%90%86
 */

@implementation TYDemoLoginViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTopBarView];
    self.rootView = [[TYDemoLoginAndRegisterView alloc] initWithType:TYLoginAndRegisterViewTypeLogin];
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
    
    TYDemoRegisterViewController *registerViewController = [TYDemoRegisterViewController new];
    [self.navigationController pushViewController:registerViewController animated:YES];
}

- (void)autoFillCountryCode {
    
    NSString *code = [TYDemoLoginAndRegisterUtils getDefaultCountryCode];
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
        [TPDemoProgressUtils showError:@"Account cannot be empty."];
        return;
    }
    
    if (self.rootView.countryCodeField.text.length == 0) {
        [TPDemoProgressUtils showError:@"Country code cannot be empty."];
        return;
    }
    
    if (self.rootView.passwordField.text.length < 6) {
        [TPDemoProgressUtils showError:@"Password length cannot be less than 6."];
        return;
    }
    
    if ([TYDemoLoginAndRegisterUtils isValidateEmail:self.rootView.accountField.text]) {
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
    
    WEAKSELF_TYSDK
    [[TuyaSmartUser sharedInstance] loginByEmail:countryCode email:email password:password success:^{
        [weakSelf_TYSDK hideProgressView];

        [[TYDemoApplicationImpl sharedInstance] resetRootViewController:[TYDemoTabBarViewController class]];
        
    } failure:^(NSError *error) {
        [TPDemoProgressUtils showError:error.localizedDescription];
        [weakSelf_TYSDK hideProgressView];
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
    WEAKSELF_TYSDK
    
    [[TuyaSmartUser sharedInstance] loginByPhone:countryCode phoneNumber:phoneNumber password:password success:^{
        [weakSelf_TYSDK hideProgressView];
        
        [[TYDemoApplicationImpl sharedInstance] resetRootViewController:[TYDemoTabBarViewController class]];
        
    } failure:^(NSError *error) {
        [weakSelf_TYSDK hideProgressView];
        [TPDemoProgressUtils showError:error.localizedDescription];
    }];
}


@end
