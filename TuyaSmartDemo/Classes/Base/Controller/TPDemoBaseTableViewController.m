//
//  TPBaseTableViewController.m
//  TYLibraryExample
//
//  Created by XuChengcheng on 2017/4/11.
//  Copyright © 2017年 Tuya. All rights reserved.
//

#import "TPDemoBaseTableViewController.h"

@interface TPDemoBaseTableViewController()

@end

@implementation TPDemoBaseTableViewController

- (instancetype)init {
    if (self = [super init]) {
        _tableViewStyle = UITableViewStylePlain;
    }
    return self;
}

/**
 *  子类先实现自己的，再[super viewDidLoad];
 */
- (void)viewDidLoad {
    
    [super viewDidLoad];
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray new];
    }
    return _dataSource;
}

- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, APP_SCREEN_WIDTH, 0) style:self.tableViewStyle];
        _tableView.backgroundColor = HEXCOLOR(0xE8E9EF);
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.separatorStyle = NO;
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
    }
    return _tableView;
}

- (void)stopInfiniteAnimation {
    //    [self.tableView.infiniteScrollingView stopAnimating];
}

- (void)reloadTable {
    [self.tableView reloadData];
}

#pragma mark - 子类继承

- (void)reload {
}

- (void)loadMore {
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


@end

