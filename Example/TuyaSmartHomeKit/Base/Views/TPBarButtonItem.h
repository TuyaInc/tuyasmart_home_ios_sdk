//
//  TPBarButtonItem.h
//  AirTake
//
//  Created by fisher on 14-6-20.
//  Copyright (c) 2014年 hanbolong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface TPBarButtonItem : UIBarButtonItem

// < 返回
+ (TPBarButtonItem *)backItem:(id)target action:(SEL)action;

// 取消
+ (TPBarButtonItem *)cancelItem:(id)target action:(SEL)action;

// 完成
+ (TPBarButtonItem *)doneItem:(id)target action:(SEL)action;

// 文字
+ (TPBarButtonItem *)titleItem:(NSString *)title target:(id)target action:(SEL)action;

// 图片
+ (TPBarButtonItem *)logoItem:(UIImage *)image terget:(id)target action:(SEL)action;


// deprecated
// --------------------------------

+ (TPBarButtonItem *)rightTitleItem:(id)target action:(SEL)action;
+ (TPBarButtonItem *)leftBackItem:(id)target action:(SEL)action;
+ (TPBarButtonItem *)leftCancelItem:(id)target action:(SEL)action;
+ (TPBarButtonItem *)rightCancelItem:(id)target action:(SEL)action;
+ (TPBarButtonItem *)centerTitleItem:(id)target action:(SEL)action;
+ (TPBarButtonItem *)centerLogoItem:(id)target action:(SEL)action;




@end
