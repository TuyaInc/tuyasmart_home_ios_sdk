//
//  TYMemberListLayout.m
//  TuyaSmart
//
//  Created by 冯晓 on 16/1/7.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TYMemberListLayout.h"
#import "TYMemberListView.h"

@interface TYMemberListLayout()


@end

@implementation TYMemberListLayout

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        _memberListView = [[TYMemberListView alloc] initWithFrame:CGRectMake(0, APP_TOP_BAR_HEIGHT, APP_CONTENT_WIDTH, APP_VISIBLE_HEIGHT)];
        [self addSubview:_memberListView];
        
        self.topBarView.centerItem.title = NSLocalizedString(@"shared_title", @"");
        self.topBarView.bottomLineHidden = YES;
        
        [self addSubview:self.topBarView];
    }
    return self;
}

- (void)setDelegate:(id<TYMemberListViewDelegate>)delegate {
    self.memberListView.delegate = delegate;
}

- (void)setDataSource:(id<TYMemberListViewDataSource>)dataSource {
    self.memberListView.dataSource = dataSource;
}

- (void)reloadData {
    [self.memberListView reloadData];
}

- (void)setCurrentSelectIndex:(NSInteger)index {
    [self.memberListView setCurrentSelectIndex:index];
}
@end
