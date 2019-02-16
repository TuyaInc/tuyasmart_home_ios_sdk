//
//  TPBaseTableViewController.h
//  TYLibraryExample
//
//  Created by XuChengcheng on 2017/4/11.
//  Copyright © 2017年 Tuya. All rights reserved.
//

#import "TPBaseViewController.h"

@class MJRefreshHeader;

@interface TPBaseTableViewController : TPBaseViewController <UITableViewDataSource,UITableViewDelegate>


@property (nonatomic, assign) UITableViewStyle       tableViewStyle;
@property (nonatomic, strong) UITableView            *tableView;
@property (nonatomic, strong) NSMutableArray         *dataSource;

/**
 *  刷新数据
 */
- (void)reloadTable;

@end
