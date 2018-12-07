//
//  TPViewCellItem.m
//  TuyaSmart
//
//  Created by fengyu on 15/9/8.
//  Copyright (c) 2015年 TP. All rights reserved.
//

#import "TPCellViewItem.h"

@implementation TPCellViewItem

+ (TPCellViewItem *)cellItemWithTitle:(NSString *)title image:(UIImage *)image {
    TPCellViewItem *cellitem = [[TPCellViewItem alloc] init];
    cellitem.title = title;
    cellitem.image = image;
    return cellitem;
}

+ (TPCellViewItem *)cellItemWithArrowImage:(NSString *)title {
    TPCellViewItem *cellitem = [[TPCellViewItem alloc] init];
    cellitem.title = title;
    cellitem.image = [UIImage imageNamed:@"tp_list_arrow_goto"];
    return cellitem;
}

@end
