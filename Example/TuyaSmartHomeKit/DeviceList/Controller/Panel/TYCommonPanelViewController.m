//
//  TYCommonPanelViewController.m
//  TuyaSmartKitDemo
//
//  Created by 冯晓 on 16/8/27.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TYCommonPanelViewController.h"



@interface TYCommonPanelViewController() <UIActionSheetDelegate>

@end

@implementation TYCommonPanelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)initView {
    [self updateOfflineView];
}


@end
