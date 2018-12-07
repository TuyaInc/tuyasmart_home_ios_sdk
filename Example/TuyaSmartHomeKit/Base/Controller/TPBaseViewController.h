//
//  TYBaseViewController.h
//  TuyaSmart
//
//  Created by 冯晓 on 16/1/4.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPLoadingView.h"
#import "TPTopBarView.h"
#import "TPEmptyView.h"

@interface TPBaseViewController : UIViewController

@property (nonatomic, strong) TPTopBarView    *topBarView;

@property (nonatomic, strong) TPBarButtonItem *rightTitleItem;

@property (nonatomic, strong) TPBarButtonItem *leftBackItem;

@property (nonatomic, strong) TPBarButtonItem *leftCancelItem;

@property (nonatomic, strong) TPBarButtonItem *rightCancelItem;

@property (nonatomic, strong) TPBarButtonItem *centerTitleItem;

@property (nonatomic, strong) TPBarButtonItem *centerLogoItem;

@property (nonatomic, strong) TPLoadingView   *loadingView;

@property (nonatomic, assign) BOOL             statusBarHidden;
@property (nonatomic, strong) TPEmptyView    *emptyView;



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
