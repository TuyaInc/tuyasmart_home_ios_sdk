//
//  ATBarButtonItem.m
//  AirTake
//
//  Created by fisher on 14-6-20.
//  Copyright (c) 2014年 hanbolong. All rights reserved.
//

#import "TPBarButtonItem.h"
#import "TPBaseView.h"

@implementation TPBarButtonItem

// < 返回
+ (UIBarButtonItem *)backItem:(id)target action:(SEL)action {
    UIBarButtonItem *leftBackItem = [[UIBarButtonItem alloc] initWithTitle:UIKitLocalizedString(@"Back") style:UIBarButtonItemStylePlain target:target action:action];
    leftBackItem.image = [UIImage imageNamed:@"tp_top_bar_back"];
    return leftBackItem;
}

// 取消
+ (UIBarButtonItem *)cancelItem:(id)target action:(SEL)action {
    return [[UIBarButtonItem alloc] initWithTitle:UIKitLocalizedString(@"Cancel") style:UIBarButtonItemStylePlain target:target action:action];
}

// 完成
+ (UIBarButtonItem *)doneItem:(id)target action:(SEL)action {
    return [[UIBarButtonItem alloc] initWithTitle:UIKitLocalizedString(@"Done") style:UIBarButtonItemStyleDone target:target action:action];
}

// 文字
+ (UIBarButtonItem *)titleItem:(NSString *)title target:(id)target action:(SEL)action {
    return [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:target action:action];
}

// 图片
+ (UIBarButtonItem *)logoItem:(UIImage *)image terget:(id)target action:(SEL)action {
    return [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:target action:action];
}

// deprecated
// --------------------------------

+ (TPBarButtonItem *)rightTitleItem:(id)target action:(SEL)action {
    return [TPBarButtonItem titleItem:UIKitLocalizedString(@"Done") target:target action:action];
}

+ (TPBarButtonItem *)leftBackItem:(id)target action:(SEL)action {
    return [TPBarButtonItem backItem:target action:action];
}

+ (TPBarButtonItem *)leftCancelItem:(id)target action:(SEL)action {
    return [TPBarButtonItem cancelItem:target action:action];
}

+ (TPBarButtonItem *)rightCancelItem:(id)target action:(SEL)action {
    return [TPBarButtonItem cancelItem:target action:action];
}

+ (TPBarButtonItem *)centerTitleItem:(id)target action:(SEL)action {
    return [TPBarButtonItem titleItem:@"Title" target:target action:action];
}

+ (TPBarButtonItem *)centerLogoItem:(id)target action:(SEL)action {
    return [TPBarButtonItem logoItem:[UIImage imageNamed:@"logo"] terget:target action:action];
}

@end
