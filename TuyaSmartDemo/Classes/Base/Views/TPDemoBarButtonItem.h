//
//  TPBarButtonItem.h
//  AirTake
//
//  Created by fisher on 14-6-20.
//  Copyright (c) 2014年 hanbolong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface TPDemoBarButtonItem : UIBarButtonItem

// < 返回
+ (TPDemoBarButtonItem *)backItem:(id)target action:(SEL)action;

// 取消
+ (TPDemoBarButtonItem *)cancelItem:(id)target action:(SEL)action;

// 完成
+ (TPDemoBarButtonItem *)doneItem:(id)target action:(SEL)action;

// 文字
+ (TPDemoBarButtonItem *)titleItem:(NSString *)title target:(id)target action:(SEL)action;

// 图片
+ (TPDemoBarButtonItem *)logoItem:(UIImage *)image terget:(id)target action:(SEL)action;


// deprecated
// --------------------------------

+ (TPDemoBarButtonItem *)rightTitleItem:(id)target action:(SEL)action;
+ (TPDemoBarButtonItem *)leftBackItem:(id)target action:(SEL)action;
+ (TPDemoBarButtonItem *)leftCancelItem:(id)target action:(SEL)action;
+ (TPDemoBarButtonItem *)rightCancelItem:(id)target action:(SEL)action;
+ (TPDemoBarButtonItem *)centerTitleItem:(id)target action:(SEL)action;
+ (TPDemoBarButtonItem *)centerLogoItem:(id)target action:(SEL)action;




@end
