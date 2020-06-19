//
//  TPViewCellItem.m
//  TuyaSmart
//
//  Created by fengyu on 15/9/8.
//  Copyright (c) 2015年 TP. All rights reserved.
//

#import "TPDemoCellViewItem.h"

@implementation TPDemoCellViewItem

+ (TPDemoCellViewItem *)cellItemWithTitle:(NSString *)title image:(UIImage *)image {
    TPDemoCellViewItem *cellitem = [[TPDemoCellViewItem alloc] init];
    cellitem.title = title;
    cellitem.image = image;
    return cellitem;
}

+ (TPDemoCellViewItem *)cellItemWithArrowImage:(NSString *)title {
    TPDemoCellViewItem *cellitem = [[TPDemoCellViewItem alloc] init];
    cellitem.title = title;
    cellitem.image = [UIImage imageNamed:@"tp_list_arrow_goto"];
    return cellitem;
}

@end
