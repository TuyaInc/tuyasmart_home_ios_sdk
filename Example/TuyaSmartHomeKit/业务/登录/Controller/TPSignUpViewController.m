//
//  TPSignUpViewController.m
//  fishNurse
//
//  Created by 高森 on 16/2/23.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TPSignUpViewController.h"
#import "TPSignUpView.h"
#import "TYAppDelegate.h"
#import "TPSignInViewController.h"
#import "TabBarViewController.h"

@interface TPSignUpViewController() <TPSignUpViewDelegate, TPTopBarViewDelegate>

@property (nonatomic, strong) TPSignUpView      *signUpView;

@property (nonatomic, strong) NSTimer            *identifyTimer;
@property (nonatomic, assign) int                identifyTimes;

@property (nonatomic, assign) BOOL               needVerifyCode;
@property (nonatomic, assign) BOOL               resetSuccess;

@end

@implementation TPSignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //只有邮箱注册不需要验证码.手机号注册/重置,邮箱重置都需要验证码
    _needVerifyCode = (_type != TPVerifyTypeSignUp) || ([_userAccount rangeOfString:@"@"].length == 0);
    
    [self initView];
    
    //注册和忘记密码,进入页面自动发送验证码
    if (_type != TPVerifyTypeModify && _needVerifyCode == YES) {
        [self sendIdentCode];
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self disableTimer];
}

- (void)initView {

    _signUpView = [[TPSignUpView alloc] initWithFrame:self.view.bounds needVerifyCode:_needVerifyCode type:_type];
    _signUpView.countryCode = _countryCode;
    _signUpView.userAccount = _userAccount;
    _signUpView.delegate = self;
    _signUpView.topBarDelegate = self;
    [self.view addSubview:_signUpView];
    
    NSString *title;
    if (_type == TPVerifyTypeSignUp) {
        title = NSLocalizedString(@"login_register", @"");
    } else if (_type == TPVerifyTypeReset) {
        title = NSLocalizedString(@"login_find_password", @"");
    } else if (_type == TPVerifyTypeModify) {
        title = NSLocalizedString(@"ty_login_modify_password", @"");
    }
    _signUpView.topBarView.centerItem.title = title;
}

- (void)sendIdentCode {
    [TPProgressUtils showMessag:NSLocalizedString(@"loading", nil) toView:nil];
    
    WEAKSELF_AT
    
    TYSuccessHandler successHandler = ^{
        [TPProgressUtils hideHUDForView:nil animated:YES];
        [weakSelf_AT.signUpView disableSendVerifyCodeButton:NSLocalizedString(@"retry_after_60", @"")];
        weakSelf_AT.identifyTimes = 60;
        weakSelf_AT.identifyTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:weakSelf_AT selector:@selector(resendIdentifyCode:) userInfo:nil repeats:YES];
    };
    
    TYFailureError failureHandler = ^(NSError *error) {
        [TPProgressUtils hideHUDForView:nil animated:YES];
        [TPProgressUtils showError:error.localizedDescription];
    };
    
    if ([_userAccount rangeOfString:@"@"].length > 0) {
        [[TuyaSmartUser sharedInstance] sendVerifyCodeByEmail:_countryCode email:_userAccount success:successHandler failure:failureHandler];
    } else {
        [[TuyaSmartUser sharedInstance] sendVerifyCode:_countryCode phoneNumber:_userAccount type:1 success:successHandler failure:failureHandler];
    }
}

- (void)resendIdentifyCode:(id)userInfo {
    self.identifyTimes--;
    [_signUpView disableSendVerifyCodeButton:[NSString stringWithFormat:NSLocalizedString(@"retry_later", @""),self.identifyTimes]];
    
    if (self.identifyTimes == 0) {
        [_signUpView enableSendVerifyCodeButton:NSLocalizedString(@"login_get_code", @"")];
        [self disableTimer];
    }
}

- (void)disableTimer {
    if (_identifyTimer) {
        [_identifyTimer invalidate];
        _identifyTimer = nil;
    }
}

- (void)confirmAction {
    
    [self.view endEditing:YES];
    
    NSString *code            = _signUpView.verifyCode;
    NSString *password        = _signUpView.password;
    
    if (password.length == 0) {
        [TPProgressUtils showError:NSLocalizedString(@"login_password", @"")];
        return;
    } else if (_type != TPVerifyTypeLogin && [password rangeOfString:@"^[A-Za-z\\d!@#$%*&_\\-.,:;+=\\[\\]{}~()^]{6,20}$" options:NSRegularExpressionSearch].location == NSNotFound) {
        [TPProgressUtils showError:NSLocalizedString(@"ty_enter_keyword_tip", @"")];
        return;
    }
    
    [TPProgressUtils showMessag:NSLocalizedString(@"loading", nil) toView:nil];
    
    WEAKSELF_AT
    
    TYFailureError failureHandler = ^(NSError *error) {
        [TPProgressUtils hideHUDForView:nil animated:YES];
        [TPProgressUtils showError:error.localizedDescription];
    };
    
    
    if (_type == TPVerifyTypeSignUp) {
        
        // 注册,成功即为登录,不用再调用登录接口
        TYSuccessHandler successSignUpHandler = ^{
            [TPProgressUtils hideHUDForView:nil animated:YES];
            TYAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
            [appDelegate resetRootViewController:[TabBarViewController class]];
        };

        
        if ([_userAccount rangeOfString:@"@"].length > 0) {
            [[TuyaSmartUser sharedInstance] registerByEmail:_countryCode email:_userAccount password:password success:successSignUpHandler failure:failureHandler];
        } else {
            [[TuyaSmartUser sharedInstance] registerByPhone:_countryCode phoneNumber:_userAccount password:password code:code success:successSignUpHandler failure:failureHandler];
        }
    } else if (_type == TPVerifyTypeReset) {
        
        // 重置密码,登录页面进入的,成功后调登录接口登录
        TYSuccessHandler successResetHandler = ^{
            [TPProgressUtils hideHUDForView:nil animated:YES];
            
            weakSelf_AT.type = TPVerifyTypeLogin;
            weakSelf_AT.resetSuccess = YES;
            [weakSelf_AT confirmAction];
        };
        
        if ([_userAccount rangeOfString:@"@"].length > 0) {
            [[TuyaSmartUser sharedInstance] resetPasswordByEmail:_countryCode email:_userAccount newPassword:password code:code success:successResetHandler failure:failureHandler];
        } else {
            [[TuyaSmartUser sharedInstance] resetPasswordByPhone:_countryCode phoneNumber:_userAccount newPassword:password code:code success:successResetHandler failure:failureHandler];
        }
    } else if (_type == TPVerifyTypeModify) {
        
        // 修改密码,是从个人中心进入的,成功后退出登录(因为session过期了)
        TYSuccessHandler successModifyHandler = ^{
            [TPProgressUtils hideHUDForView:nil animated:YES];
            [[TuyaSmartUser sharedInstance] loginOut:nil failure:nil];
            
            TYAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
            [appDelegate resetRootViewController:[TPSignInViewController class]];
            //alert 修改密码成功，请重新登录
            [TPProgressUtils showError:NSLocalizedString(@"modify_password_success", nil)];
        };
        
        if ([_userAccount rangeOfString:@"@"].length > 0) {
            [[TuyaSmartUser sharedInstance] resetPasswordByEmail:_countryCode email:_userAccount newPassword:password code:code success:successModifyHandler failure:failureHandler];
        } else {
            [[TuyaSmartUser sharedInstance] resetPasswordByPhone:_countryCode phoneNumber:_userAccount newPassword:password code:code success:successModifyHandler failure:failureHandler];
        }
    } else if (_type == TPVerifyTypeLogin) {
        
        // 登录
        TYSuccessHandler successLoginHandler = ^{
            [TPProgressUtils hideHUDForView:nil animated:YES];
            TYAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
            [appDelegate resetRootViewController:[TabBarViewController class]];
        };
        
        if ([_userAccount rangeOfString:@"@"].length > 0) {
            [[TuyaSmartUser sharedInstance] loginByEmail:_countryCode email:_userAccount password:password success:successLoginHandler failure:failureHandler];
        } else {
            if (_resetSuccess) { // 重置密码后登录,用的是新密码(验证码失效)
                [[TuyaSmartUser sharedInstance] loginByPhone:_countryCode phoneNumber:_userAccount password:password success:successLoginHandler failure:failureHandler];
            } else { // 用户已注册,直接登录,用的是验证码登录
                [[TuyaSmartUser sharedInstance] login:_countryCode phoneNumber:_userAccount code:code success:successLoginHandler failure:failureHandler];
            }
        }
    }
}

#pragma mark - TPSignUpViewDelegate

- (void)signUpViewSendVerifyCodeButtonTap:(TPSignUpView *)signUpView {
    [self sendIdentCode];
}

- (void)signUpViewConfirmButtonTap:(TPSignUpView *)signUpView {
    [self confirmAction];
}

- (BOOL)getCountStatus {
    if (self.identifyTimes == 0) {
        return NO;
    }
    return YES;
}

#pragma mark TuyaTopBarViewDelegate

- (void)topBarLeftItemTap {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
