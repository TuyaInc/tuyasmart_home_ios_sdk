//
//  TYLoginViewController.m
//  TuyaSmartHomeKit_Example
//
//  Created by 盖剑秋 on 2018/11/5.
//  Copyright © 2018 xuchengcheng. All rights reserved.
//

#import "TYLoginViewController.h"
#import "TYLoginAndRegisterView.h"
#import "TYLoginAndRegisterUtils.h"
#import "TYSmartHomeManager.h"

@interface TYLoginViewController () <TYLoginAndRegisterViewDelegate>

@property (nonatomic, strong) TYLoginAndRegisterView *rootView;
@property (nonatomic, strong) TYRegisterViewController *registerViewController;
@property (nonatomic, strong) TuyaSmartHomeManager *homeManager;

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
    // session invalid
    [self loadNotification];
    [self loadHomeData];
    [self autoFillCountryCode];
}

- (void)initTopBarView {
    
    self.topBarView.leftItem = self.leftCancelItem;
    self.centerTitleItem.title = @"Login";
    self.topBarView.centerItem = self.centerTitleItem;
    self.rightTitleItem.title = @"Register";
    self.topBarView.rightItem = self.rightTitleItem;
    self.leftCancelItem.title = @"Logout";
    [self.view addSubview:self.topBarView];
}

- (void)rightBtnAction {
    
    self.registerViewController = [TYRegisterViewController new];
    
    WEAKSELF_AT
    [self.registerViewController setRegisterResultBlock:^(NSString * _Nonnull resultInfoStr) {
        weakSelf_AT.rootView.tipsLabel.text = resultInfoStr;
        [weakSelf_AT loadHomeData];
    }];
    [self.navigationController pushViewController:self.registerViewController animated:YES];
}

- (void)autoFillCountryCode {
    
    NSString *code = [TYLoginAndRegisterUtils getDefaultCountryCode];
    if (code.length > 0) {
        self.rootView.countryCodeField.text = code;
    }
}

- (void)loadHomeData {
    
    if (![TuyaSmartUser sharedInstance].isLogin) return;
    
    WEAKSELF_AT
    [self.homeManager getHomeListWithSuccess:^(NSArray<TuyaSmartHomeModel *> *homes) {

        if (homes.count > 0) {
            // If homes are already exist, choose the first one as current home.
            TuyaSmartHomeModel *model = [homes firstObject];
            [TYSmartHomeManager sharedInstance].currentHomeModel = model;
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationLogin object:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationSwitchHome object:nil];
        } else {
            // Or else, add a default home named "hangzhou's home" and choose it as current home.
            [weakSelf_AT.homeManager addHomeWithName:@"hangzhou's home" geoName:@"hangzhou" rooms:@[@"bedroom"] latitude:0 longitude:0 success:^(long long homeId) {
                TuyaSmartHome *home = [TuyaSmartHome homeWithHomeId:homeId];
                [TYSmartHomeManager sharedInstance].currentHomeModel = home.homeModel;
                [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationLogin object:nil];
                [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationSwitchHome object:nil];
            } failure:^(NSError *error) {
                
            }];
        }
    } failure:^(NSError *error) {
        
    }];
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
        self.rootView.tipsLabel.text = @"Account number cannot be empty.";
        return;
    }
    
    if (self.rootView.countryCodeField.text.length == 0) {
        self.rootView.tipsLabel.text = @"Country code cannot be empty.";
        return;
    }
    
    if (self.rootView.passwordField.text.length < 6) {
        self.rootView.tipsLabel.text = @"Password length cannot be less than 6";
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
        weakSelf_AT.rootView.tipsLabel.text = @"Login with email and password success！";
        [weakSelf_AT hideProgressView];
        [weakSelf_AT loadHomeData];
    } failure:^(NSError *error) {
        weakSelf_AT.rootView.tipsLabel.text = error.localizedDescription;
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
        weakSelf_AT.rootView.tipsLabel.text = @"Login with phone number and password success！";
        [weakSelf_AT hideProgressView];
        [weakSelf_AT loadHomeData];
    } failure:^(NSError *error) {
        weakSelf_AT.rootView.tipsLabel.text = error.localizedDescription;
        [weakSelf_AT hideProgressView];
    }];
}

/**
 @brief Log out
 */
- (void)CancelButtonTap {
    WEAKSELF_AT;
    [[TuyaSmartUser sharedInstance] loginOut:^{
        weakSelf_AT.rootView.tipsLabel.text = @"Logout success!";
        [TYSmartHomeManager sharedInstance].currentHomeModel = nil;
    } failure:^(NSError *error) {
        weakSelf_AT.rootView.tipsLabel.text = error.localizedDescription;
    }];
}

#pragma mark - Session invalid

- (void)loadNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sessionInvalid) name:TuyaSmartUserNotificationUserSessionInvalid object:nil];
}

- (void)sessionInvalid {
    if ([[TuyaSmartUser sharedInstance] isLogin]) {
        // Log out.
        [[TuyaSmartUser sharedInstance] loginOut:nil failure:nil];
        [TYSmartHomeManager sharedInstance].currentHomeModel = nil;
        
        self.rootView.tipsLabel.text = @"Session expired，you need to login again.";
    }
}

#pragma mark - Getters

- (TuyaSmartHomeManager *)homeManager {
    if (!_homeManager) {
        _homeManager = [TuyaSmartHomeManager new];
    }
    return _homeManager;
}
@end
