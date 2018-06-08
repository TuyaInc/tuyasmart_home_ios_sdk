//
//  TYMemberListLayout.h
//  TuyaSmart
//
//  Created by 冯晓 on 16/1/7.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TPBaseLayout.h"
#import "TYMemberListView.h"

@interface TYMemberListLayout : TPBaseLayout


@property (nonatomic, weak) id <TYMemberListViewDelegate> delegate;
@property (nonatomic, weak) id <TYMemberListViewDataSource> dataSource;

@property (nonatomic,strong) TYMemberListView *memberListView;

- (void)setCurrentSelectIndex:(NSInteger)index;
@end
