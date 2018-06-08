//
//  TYBaseTableViewCell.h
//  TuyaSmart
//
//  Created by fengyu on 15/2/28.
//  Copyright (c) 2015年 Tuya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPItemView.h"
#import "MenuItem.h"

@interface TYBaseTableViewCell : UITableViewCell

@property(nonatomic,strong) TPItemView *itemView;

- (void)setUp:(MenuItem *)item;

@end
