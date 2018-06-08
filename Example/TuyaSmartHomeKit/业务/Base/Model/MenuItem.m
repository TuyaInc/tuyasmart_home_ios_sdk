//
//  MenuItem.m
//  TuyaSmart
//
//  Created by fengyu on 15/2/28.
//  Copyright (c) 2015年 Tuya. All rights reserved.
//

#import "MenuItem.h"

@implementation MenuItem

+ (MenuItem *)normalItem:(UIImage *)icon title:(NSString *)title action:(SEL)action {
    MenuItem *item = [[MenuItem alloc] init];
    item.type = MenuItemTypeNormal;
    item.icon = icon;
    item.title = title;
    item.action = action;
    return item;
}

+ (MenuItem *)firstItem:(UIImage *)icon title:(NSString *)title action:(SEL)action {
    MenuItem *item = [[MenuItem alloc] init];
    item.type = MenuItemTypeFirst;
    item.icon = icon;
    item.title = title;
    item.action = action;
    return item;
}

+ (MenuItem *)lastItem:(UIImage *)icon title:(NSString *)title action:(SEL)action {
    MenuItem *item = [[MenuItem alloc] init];
    item.type = MenuItemTypeLast;
    item.icon = icon;
    item.title = title;
    item.action = action;
    
    return item;
}

+ (MenuItem *)separatorItem:(float)height {
    MenuItem *item = [[MenuItem alloc] init];
    item.type = MenuItemTypeSeparator;
    item.height = height;
    
    return item;
}

+ (MenuItem *)signOutItem {
    MenuItem *item = [[MenuItem alloc] init];
    item.type = MenuItemTypeSignOut;
    return item;
}

@end
