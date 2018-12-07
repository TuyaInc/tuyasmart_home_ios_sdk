//
//  TPViewCellItem.h
//  TuyaSmart
//
//  Created by fengyu on 15/9/8.
//  Copyright (c) 2015年 TP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TPCellViewItem : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UIColor  *textColor;
@property (nonatomic, assign) float    fontSize;

@property (nonatomic, strong) UIImage *image;

@property (nonatomic, strong) UIView *customView;

+ (TPCellViewItem *)cellItemWithTitle:(NSString *)title image:(UIImage *)image;
+ (TPCellViewItem *)cellItemWithArrowImage:(NSString *)title;

@end