//
//  TPInputPhoneViewController.m
//  fishNurse
//
//  Created by 高森 on 16/2/23.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TPInputUserAccountController.h"
#import "TPInputUserAccountView.h"
#import "TPSelectCountryViewController.h"
#import "TPSignUpViewController.h"
#import "TPCountryCodeUtils.h"

@interface TPInputUserAccountController() <TPInputPhoneViewDelegate, TPTopBarViewDelegate, ATSelectCountryDelegate>

@property (nonatomic, strong) TPInputUserAccountView *inputUserAccountView;
@property (nonatomic, strong) TPCountryModel *countryCodeModel;

@end

@implementation TPInputUserAccountController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self initView];
    [self initCountryCode];
}


- (void)initView {
    _inputUserAccountView = [[TPInputUserAccountView alloc] initWithFrame:self.view.bounds];
    _inputUserAccountView.delegate = self;
    _inputUserAccountView.topBarDelegate = self;
    [self.view addSubview:_inputUserAccountView];

    NSString *title;
    if (_type == TPVerifyTypeSignUp) {
        title = NSLocalizedString(@"login_register", @"");
    } else if (_type == TPVerifyTypeReset) {
        title = NSLocalizedString(@"login_find_password", @"");
    } else if (_type == TPVerifyTypeModify) {
        title = NSLocalizedString(@"ty_login_modify_password", @"");
    }
    _inputUserAccountView.topBarView.centerItem.title = title;
}


- (void)initCountryCode {
    TPCountryModel *model = [TPCountryService getCurrentCountryModel];
    
    [self setCountryCode:model];
}

- (void)selectCountryCode {
    TPSelectCountryViewController *vc = [[TPSelectCountryViewController alloc] init];
    vc.delegate = self;
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)setCountryCode:(TPCountryModel *)model {
    _countryCodeModel = model;
    [_inputUserAccountView setCountryCode:model];
}

- (void)gotoNextViewController {
    
    [self.view endEditing:YES];
    
    TPSignUpViewController *vc = [TPSignUpViewController new];
    vc.type = _type;
    vc.countryCode = _countryCodeModel.countryCode;
    vc.userAccount = _inputUserAccountView.userAccount;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - TPInputPhoneViewDelegate

- (void)inputPhoneViewCountrySelectViewTap:(TPInputUserAccountView *)inputPhoneView {
    [self selectCountryCode];
}

- (void)inputPhoneViewNextButtonTap:(TPInputUserAccountView *)inputPhoneView {
    [self gotoNextViewController];
}

#pragma mark TuyaTopBarViewDelegate

- (void)topBarLeftItemTap {
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark ATSelectCountryDelegate

- (void)didSelectCountry:(TPSelectCountryViewController *)controller model:(TPCountryModel *)model {
    [self setCountryCode:model];
    [controller tp_dismissModalViewController];
}

@end
