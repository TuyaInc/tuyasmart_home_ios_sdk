//
//  UserView.m
//  TuyaSmart
//
//  Created by fengyu on 15/2/28.
//  Copyright (c) 2015年 Tuya. All rights reserved.
//

#import "UserView.h"

@implementation UserView

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];

    [self setBackgroundColor:[UIColor whiteColor]];
    [self addUserTableView];

    return self;
}

-(void)addUserTableView {
    _userTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height) style:UITableViewStylePlain];
    _userTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _userTableView.allowsSelection = NO;
    _userTableView.backgroundColor = MAIN_BACKGROUND_COLOR;
    
    [self addSubview:_userTableView];
}

@end
