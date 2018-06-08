//
//  TPBaseView.h
//  TuyaSmart
//
//  Created by fengyu on 15/9/8.
//  Copyright (c) 2015年 Tuya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+TPCategory.h"
#import "UIView+TPAdditions.h"
#import "UIImage+TPAlpha.h"

#import "TPViewUtil.h"
#import "TPViewConstants.h"

@interface TPBaseView : UIView

@property (nonatomic, assign) BOOL    topLineHidden;
@property (nonatomic, assign) float   topLineWidth;
@property (nonatomic, assign) float   topLineIndent;
@property (nonatomic, strong) UIColor *topLineColor;

@property (nonatomic, assign) BOOL    bottomLineHidden;
@property (nonatomic, assign) float   bottomLineWidth;
@property (nonatomic, assign) float   bottomLineIndent;
@property (nonatomic, strong) UIColor *bottomLineColor;

@end

NSString *UIKitLocalizedString(NSString *string);
