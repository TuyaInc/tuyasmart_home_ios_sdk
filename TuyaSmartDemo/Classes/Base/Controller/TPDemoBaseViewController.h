//
//  TYBaseViewController.h
//  TuyaSmart
//
//  Created by 冯晓 on 16/1/4.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPDemoLoadingView.h"
#import "TPDemoTopBarView.h"
#import "TPDemoEmptyView.h"

@interface TPDemoBaseViewController : UIViewController

@property (nonatomic, strong) TPDemoTopBarView    *topBarView;

@property (nonatomic, strong) TPDemoBarButtonItem *rightTitleItem;

@property (nonatomic, strong) TPDemoBarButtonItem *leftBackItem;

@property (nonatomic, strong) TPDemoBarButtonItem *leftCancelItem;

@property (nonatomic, strong) TPDemoBarButtonItem *rightCancelItem;

@property (nonatomic, strong) TPDemoBarButtonItem *centerTitleItem;

@property (nonatomic, strong) TPDemoBarButtonItem *centerLogoItem;

@property (nonatomic, strong) TPDemoLoadingView   *loadingView;

@property (nonatomic, assign) BOOL             statusBarHidden;
@property (nonatomic, strong) TPDemoEmptyView    *emptyView;



- (instancetype)initWithQuery:(NSDictionary *)query;

- (void)viewDidAppearAtFirstTime:(BOOL)animated;

- (void)viewDidAppearNotAtFirstTime:(BOOL)animated;

- (void)backButtonTap;

- (void)rightBtnAction;

- (void)CancelButtonTap;

- (void)cancelService;

#pragma mark - 小菊花 加载中

- (void)showLoadingView;

- (void)hideLoadingView;

#pragma mark - 黑色的大菊花
- (void)showProgressView;

- (void)showProgressView:(NSString *)message;

- (void)hideProgressView;

#pragma mark - 导航栏

- (NSString *)titleForCenterItem;

- (NSString *)titleForRightItem;

- (UIView *)customViewForCenterItem;

- (UIView *)customViewForRightItem;

#pragma mark - 空页面
- (NSString *)titleForEmptyView;

- (NSString *)subTitleForEmptyView;

- (NSString *)imageNameForEmptyView;

- (void)showEmptyView;

- (void)hideEmptyView;


@end
