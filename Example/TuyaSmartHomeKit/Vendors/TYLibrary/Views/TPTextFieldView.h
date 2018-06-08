//
//  TPTextFieldView.h
//  TuyaSmart
//
//  Created by fengyu on 15/9/8.
//  Copyright (c) 2015年 TP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPBaseView.h"

@protocol TPTextFieldViewDelegate <NSObject>

- (void)textFieldRightItemViewTap;

@end

@interface TPTextFieldView : TPBaseView

@property(nonatomic,weak) id<TPTextFieldViewDelegate> delegate;

@property(nonatomic,assign) BOOL roundCorner;

@property(nonatomic,strong) UIImage *leftImage;

@property(nonatomic,strong) UIImage *rightImage;
@property(nonatomic,strong) UIImage *rightImageSelected;

@property(nonatomic,strong) UITextField *textField;
@property(nonatomic,strong) NSString *text;
@property(nonatomic,retain) UIColor  *textColor;
@property(nonatomic,copy)   NSString *placeholder;

@end
