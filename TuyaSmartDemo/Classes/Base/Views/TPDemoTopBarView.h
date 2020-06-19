//
//  TPTopBarView.h
//  AirTake
//
//  Created by fisher on 14-6-20.
//  Copyright (c) 2014年 hanbolong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPDemoBaseView.h"
#import "TPDemoBarButtonItem.h"

#define TP_LEFT_VIEW_TAG 1200
#define TP_RIGHT_VIEW_TAG 1201
#define TP_CENTER_VIEW_TAG 1202

#define TPTopBarViewTag 35739

@interface TPDemoTopBarView : TPDemoBaseView

@property (nonatomic, strong) TPDemoBarButtonItem *leftItem;
@property (nonatomic, strong) TPDemoBarButtonItem *centerItem;
@property (nonatomic, strong) TPDemoBarButtonItem *rightItem;

@property (nonatomic, strong) UIColor           *lineColor;
@property (nonatomic, strong) UIColor           *textColor;

- (void)setTopBarBackgroundColor:(NSArray *)backgroundColorArray;
- (void)setTopBarTextColor:(NSArray *)color;
- (void)setTopBarSubTextColor:(NSArray *)color;
- (void)setTopBarSubTextSelectedColor:(NSArray *)color;

@end
