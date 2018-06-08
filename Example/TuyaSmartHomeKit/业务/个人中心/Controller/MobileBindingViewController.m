//
//  MobileBindingViewController.m
//  TuyaSmartPublic
//
//  Created by remy on 16/3/29.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "MobileBindingViewController.h"
#import "TPSelectCountryViewController.h"
#import "MobileBindingView.h"
#import "TPCountryCodeUtils.h"

@interface MobileBindingViewController () <TPTopBarViewDelegate,ATSelectCountryDelegate,UITextFieldDelegate,MobileBindingViewDelegate>

@property (nonatomic, strong) MobileBindingView  *bindingView;
@property (nonatomic, strong) NSTimer            *identifyTimer;
@property (nonatomic, strong) TPCountryModel *countryCodeModel;
@property (nonatomic, assign) int                identifyTimes;

@end

@implementation MobileBindingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    [self initCountryCode];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [(TPNavigationController *)self.navigationController disablePopGesture];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [(TPNavigationController *)self.navigationController enablePopGesture];
}


- (void)disableTimer {
    if (_identifyTimer) {
        [_identifyTimer invalidate];
        _identifyTimer = nil;
    }
}

- (void)initView {
    _bindingView = [[MobileBindingView alloc] initWithFrame:self.view.bounds];
    _bindingView.delegate = self;
    _bindingView.topBarDelegate = self;
    [self.view addSubview:_bindingView];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[TuyaSmartUser sharedInstance] cancelRequest];
}

- (void)initCountryCode {
    TPCountryModel *model = [TPCountryService getCurrentCountryModel];
    
    [self setCountryCode:model];
}


- (void)selectCountryCode {
    TPSelectCountryViewController *selectCountryViewController = [[TPSelectCountryViewController alloc] init];
    selectCountryViewController.delegate = self;
    [self presentViewController:selectCountryViewController animated:YES completion:nil];
}

- (void)setCountryCode:(TPCountryModel *)model {
    _countryCodeModel = model;
    [_bindingView setCountryCode:model];
}

- (void)binding {
    [self.view endEditing:YES];
    
    NSString *countryCode   = _countryCodeModel.countryCode;
    NSString *phoneNumber   = _bindingView.phoneNumber;
    NSString *code          = _bindingView.verifyCode;
    
    [self showProgressView];
    
    WEAKSELF_AT
    [[TuyaSmartUser sharedInstance] mobileBinding:countryCode phoneNumber:phoneNumber code:code success:^{
        [weakSelf_AT hideProgressView];
        
        [weakSelf_AT disableTimer];
        
        [weakSelf_AT topBarLeftItemTap];
    } failure:^(NSError *error) {
        [weakSelf_AT hideProgressView];
        [TPProgressUtils showError:error.localizedDescription];
    }];
}

- (void)sendIdentCode {
    [TPProgressUtils showMessag:NSLocalizedString(@"loading", nil) toView:nil];
    
    WEAKSELF_AT
    [[TuyaSmartUser sharedInstance] sendBindVerifyCode:_countryCodeModel.countryCode phoneNumber:_bindingView.phoneNumber success:^{
        [TPProgressUtils hideHUDForView:nil animated:YES];
        [weakSelf_AT.bindingView disableSendVerifyCodeButton:NSLocalizedString(@"retry_after_60", @"")];
        weakSelf_AT.identifyTimes = 60;
        weakSelf_AT.identifyTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:weakSelf_AT selector:@selector(resendIdentifyCode:) userInfo:nil repeats:YES];
        
    } failure:^(NSError *error) {
        
        [TPProgressUtils hideHUDForView:nil animated:YES];
        [TPProgressUtils showError:error.localizedDescription];
    }];
}

- (void)resendIdentifyCode:(id)userInfo {
    self.identifyTimes--;
    [_bindingView disableSendVerifyCodeButton:[NSString stringWithFormat:NSLocalizedString(@"retry_later", @""),self.identifyTimes]];
    
    if (self.identifyTimes == 0) {
        [_bindingView enableSendVerifyCodeButton:NSLocalizedString(@"login_get_code", @"")];
        [self disableTimer];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

#pragma mark - TuyaTopBarViewDelegate

- (void)topBarLeftItemTap {
    [self disableTimer];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - MobileBindingViewDelegate

- (void)bindingViewCountrySelectViewTap:(MobileBindingView *)bindingView {
    [self selectCountryCode];
}

- (void)bindingViewSendVerifyCodeButtonTap:(MobileBindingView *)bindingView {
    [self sendIdentCode];
}

- (void)bindingViewBindingButtonTap:(MobileBindingView *)bindingView {
    [self binding];
}

- (BOOL)getCountStatus {
    if (self.identifyTimes == 0) {
        return NO;
    }
    return YES;
}

#pragma mark - ATSelectCountryDelegate
- (void)didSelectCountry:(TPSelectCountryViewController *)controller model:(TPCountryModel *)model {
    [self setCountryCode:model];
    [controller tp_dismissModalViewController];
}

@end
