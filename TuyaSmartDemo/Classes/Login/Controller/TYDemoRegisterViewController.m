//
//  TYRegisterViewController.m
//  TuyaSmartHomeKit_Example
//
//  Created by 盖剑秋 on 2018/11/6.
//  Copyright © 2018 xuchengcheng. All rights reserved.
//

#import "TYDemoRegisterViewController.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import "TYDemoLoginAndRegisterView.h"
#import "TYDemoLoginAndRegisterUtils.h"
#import "TYDemoApplicationImpl.h"
#import "TYDemoTabBarViewController.h"

#import "TPDemoProgressUtils.h"
#import <TuyaSmartBaseKit/TuyaSmartBaseKit.h>

@interface TYDemoRegisterViewController () <TYLoginAndRegisterViewDelegate>

@property (nonatomic, strong) TYDemoLoginAndRegisterView *rootView;

@end

/*
 doc link
 
 en:https://tuyainc.github.io/tuyasmart_home_ios_sdk_doc/en/resource/User.html#user-management
 zh-hans:https://tuyainc.github.io/tuyasmart_home_ios_sdk_doc/zh-hans/resource/User.html#%E7%94%A8%E6%88%B7%E7%AE%A1%E7%90%86
 */

@implementation TYDemoRegisterViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.rootView = [[TYDemoLoginAndRegisterView alloc] initWithType:TYLoginAndRegisterViewTypeRegister];
    self.rootView.delegate = self;
    [self.view addSubview:self.rootView];
    self.view.backgroundColor = [UIColor whiteColor];
    self.topBarView.leftItem = self.leftBackItem;
    [self.view addSubview:self.topBarView];
    [self autoFillCountryCodeWithDeviceInfo];
}

#pragma mark - TYLoginAndRegisterViewDelegate

- (void)loginAndRegisterViewTrigerredAction:(TYLoginAndRegisterViewActionType)actionType {
    
    if (actionType == TYLoginAndRegisterViewActionTypeSendVerifyCode) {
        [self sendVerifyCode];
    } else if (actionType == TYLoginAndRegisterViewActionTypeRegister) {
        [self registerAction];
    }
}

- (void)sendVerifyCode {
    
    [self.view endEditing:YES];
    if (!self.rootView.accountField.text.length) {
        [TPDemoProgressUtils showError:@"Account can't be nil"];
        return;
    }
    if ([TYDemoLoginAndRegisterUtils isValidateEmail:self.rootView.accountField.text]) {
        [self sendVerifyCodeToEmail];
    } else {
        [self sendVerifyCodeToPhone];
    }
}

- (void)sendVerifyCodeToPhone {
    
    [[TuyaSmartUser sharedInstance] sendVerifyCode:self.rootView.countryCodeField.text phoneNumber:self.rootView.accountField.text type:1 success:^{
        [TPDemoProgressUtils showSuccess:@"Verification code sent successfully" toView:nil];
    } failure:^(NSError *error) {
        [TPDemoProgressUtils showError:error.localizedDescription];
    }];
}

- (void)sendVerifyCodeToEmail {
    
    [[TuyaSmartUser sharedInstance] sendVerifyCodeByRegisterEmail:self.rootView.countryCodeField.text email:self.rootView.accountField.text success:^{
        [TPDemoProgressUtils showSuccess:@"Verification code sent successfully" toView:nil];
    } failure:^(NSError *error) {
        [TPDemoProgressUtils showError:error.localizedDescription];
    }];
}

- (void)registerAction {
    
    [self.view endEditing:YES];
    if (!self.rootView.accountField.text.length ||
        !self.rootView.passwordField.text.length ||
        !self.rootView.countryCodeField.text.length) {
        [TPDemoProgressUtils showError:@"Account or password or verify code can't be nil."];
        return;
    }
    if ([TYDemoLoginAndRegisterUtils isValidateEmail:self.rootView.accountField.text]) {
        [self registerByEmail];
    } else {
        [self registerByPhone];
    }
}

- (void)registerByPhone {
    
    [[TuyaSmartUser sharedInstance] registerByPhone:self.rootView.countryCodeField.text phoneNumber:self.rootView.accountField.text password:self.rootView.passwordField.text code:self.rootView.verifyCodeField.text success:^{
        
        [[TYDemoApplicationImpl sharedInstance] resetRootViewController:[TYDemoTabBarViewController class]];
    } failure:^(NSError *error) {
        [TPDemoProgressUtils showError:error.localizedDescription];
    }];
}

- (void)registerByEmail {
    
    [[TuyaSmartUser sharedInstance] registerByEmail:self.rootView.countryCodeField.text email:self.rootView.accountField.text password:self.rootView.passwordField.text code:self.rootView.verifyCodeField.text success:^{
        [[TYDemoApplicationImpl sharedInstance] resetRootViewController:[TYDemoTabBarViewController class]];
    } failure:^(NSError *error) {
        [TPDemoProgressUtils showError:error.localizedDescription];
    }];
}

- (void)autoFillCountryCodeWithDeviceInfo {
    
    NSString *code = [TYDemoLoginAndRegisterUtils getDefaultCountryCode];
    if (code.length) {
        self.rootView.countryCodeField.text = code;
    }
}

- (NSString *)titleForCenterItem {
    return NSLocalizedString(@"login_register", @"");
}

@end
