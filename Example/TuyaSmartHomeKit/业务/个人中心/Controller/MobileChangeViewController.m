//
//  MobileChangeViewController.m
//  TuyaSmartPublic
//
//  Created by remy on 16/3/29.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "MobileChangeViewController.h"
#import "MobileBindingViewController.h"
#import "MobileChangeView.h"
#import "TPCountryCodeUtils.h"

@interface MobileChangeViewController () <TPTopBarViewDelegate>

@property (nonatomic, strong) MobileChangeView *changeView;

@end

@implementation MobileChangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
}

- (void)initView {
    _changeView = [[MobileChangeView alloc] initWithFrame:self.view.bounds];
    _changeView.topBarDelegate = self;
    [self.view addSubview:_changeView];
    
    _changeView.title.text = [NSString stringWithFormat:@"%@:   +%@", NSLocalizedString(@"ty_mobile_change_phone", @""), [TuyaSmartUser sharedInstance].phoneNumber];
    [_changeView.changeButton addTarget:self action:@selector(changeButtonTap) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - action

- (void)changeButtonTap {
    MobileBindingViewController *newVC = [[MobileBindingViewController alloc] init];
    NSMutableArray *viewControllers = [NSMutableArray arrayWithArray:[self.navigationController viewControllers]];
    [viewControllers removeLastObject];
    [viewControllers tp_safeAddObject:newVC];
    [self.navigationController setViewControllers:viewControllers animated:YES];
}

#pragma mark - TuyaTopBarViewDelegate

- (void)topBarLeftItemTap {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
