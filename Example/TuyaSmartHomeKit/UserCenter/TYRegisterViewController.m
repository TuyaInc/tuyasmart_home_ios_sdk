//
//  TYRegisterViewController.m
//  TuyaSmartHomeKit_Example
//
//  Created by 盖剑秋 on 2018/11/6.
//  Copyright © 2018 xuchengcheng. All rights reserved.
//

#import "TYRegisterViewController.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import "TYLoginAndRegisterView.h"
#import "TYLoginAndRegisterUtils.h"

@interface TYRegisterViewController () <TYLoginAndRegisterViewDelegate>

@property (nonatomic, strong) TYLoginAndRegisterView *rootView;

@end

/*
 doc link
 
 en:https://tuyainc.github.io/tuyasmart_home_ios_sdk_doc/en/resource/User.html#user-management
 zh-hans:https://tuyainc.github.io/tuyasmart_home_ios_sdk_doc/zh-hans/resource/User.html#%E7%94%A8%E6%88%B7%E7%AE%A1%E7%90%86
 */

@implementation TYRegisterViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.rootView = [[TYLoginAndRegisterView alloc] initWithType:TYLoginAndRegisterViewTypeRegister];
    self.rootView.delegate = self;
    [self.view addSubview:self.rootView];
    self.view.backgroundColor = [UIColor whiteColor];
    self.topBarView.leftItem = self.leftBackItem;
    [self.view addSubview:self.topBarView];
    [self autoFillCountryCodeWithDeviceInfo];
}

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
        self.rootView.tipsLabel.text = @"Account can't be nil";
        return;
    }
    if ([TYLoginAndRegisterUtils isValidateEmail:self.rootView.accountField.text]) {
        [self sendVerifyCodeToEmail];
    } else {
        [self sendVerifyCodeToPhone];
    }
}

- (void)sendVerifyCodeToPhone {
    
    WEAKSELF_AT
    [[TuyaSmartUser sharedInstance] sendVerifyCode:self.rootView.countryCodeField.text phoneNumber:self.rootView.accountField.text type:1 success:^{
        weakSelf_AT.rootView.tipsLabel.text = @"Verify code has been sent to your phone.";
    } failure:^(NSError *error) {
        weakSelf_AT.rootView.tipsLabel.text = error.localizedDescription;
    }];
}

- (void)sendVerifyCodeToEmail {
    
    WEAKSELF_AT
    [[TuyaSmartUser sharedInstance] sendVerifyCodeByRegisterEmail:self.rootView.countryCodeField.text email:self.rootView.accountField.text success:^{
        
        weakSelf_AT.rootView.tipsLabel.text = @"Verify code has been sent to your email.";
    } failure:^(NSError *error) {
        
        weakSelf_AT.rootView.tipsLabel.text = error.localizedDescription;
        
    }];
}

- (void)registerAction {
    
    [self.view endEditing:YES];
    if (!self.rootView.accountField.text.length ||
        !self.rootView.passwordField.text.length ||
        !self.rootView.countryCodeField.text.length) {
        self.rootView.tipsLabel.text = @"Account or password or verify code can't be nil.";
        return;
    }
    if ([TYLoginAndRegisterUtils isValidateEmail:self.rootView.accountField.text]) {
        [self registerByEmail];
    } else {
        [self registerByPhone];
    }
}

- (void)registerByPhone {
    
    WEAKSELF_AT
    [[TuyaSmartUser sharedInstance] registerByPhone:self.rootView.countryCodeField.text phoneNumber:self.rootView.accountField.text password:self.rootView.passwordField.text code:self.rootView.verifyCodeField.text success:^{

        if (weakSelf_AT.registerResultBlock) {
            weakSelf_AT.registerResultBlock(@"Register and login with phone number success.");
        }
        [weakSelf_AT.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        
        weakSelf_AT.rootView.tipsLabel.text = error.localizedDescription;
    }];
}

- (void)registerByEmail {
    
    WEAKSELF_AT
    [[TuyaSmartUser sharedInstance] registerByEmail:self.rootView.countryCodeField.text email:self.rootView.accountField.text password:self.rootView.passwordField.text code:self.rootView.verifyCodeField.text success:^{
        
        if (weakSelf_AT.registerResultBlock) {
            weakSelf_AT.registerResultBlock(@"Register and login with email success.");
        }
        [weakSelf_AT.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        weakSelf_AT.rootView.tipsLabel.text = error.localizedDescription;
    }];
}

- (void)autoFillCountryCodeWithDeviceInfo {
    
    NSString *code = [TYLoginAndRegisterUtils getDefaultCountryCode];
    if (code.length) {
        self.rootView.countryCodeField.text = code;
    }
}

- (NSString *)titleForCenterItem {
    return @"Register";
}

@end
