//
//  MenuItem.h
//  TuyaSmart
//
//  Created by fengyu on 15/2/28.
//  Copyright (c) 2015年 Tuya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, MenuItemType) {
    MenuItemTypeNormal      = 0,
    MenuItemTypeFirst       = 1,
    MenuItemTypeLast        = 2,
    MenuItemTypeSeparator   = 3,
    MenuItemTypeSignOut     = 4
};

@interface MenuItem : NSObject

@property (nonatomic, assign) MenuItemType type;
@property (nonatomic, assign) float        height;
@property (nonatomic, strong) UIImage      *icon;
@property (nonatomic, strong) NSString     *title;
@property (nonatomic, strong) NSString     *rightTitle;
@property (nonatomic, assign) SEL          action;

+ (MenuItem *)normalItem:(UIImage *)icon title:(NSString *)title action:(SEL)action;
+ (MenuItem *)firstItem:(UIImage *)icon title:(NSString *)title action:(SEL)action;
+ (MenuItem *)lastItem:(UIImage *)icon title:(NSString *)title action:(SEL)action;
+ (MenuItem *)separatorItem:(float)height;
+ (MenuItem *)signOutItem;

@end
