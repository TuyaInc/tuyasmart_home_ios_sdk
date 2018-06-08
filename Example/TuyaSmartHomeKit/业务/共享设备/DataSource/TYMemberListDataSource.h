//
//  TYMemberListDataSource.h
//  TuyaSmart
//
//  Created by 冯晓 on 16/1/7.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TYMemberListView.h"


@interface TYMemberListDataSource : NSObject <TYMemberListViewDataSource>

@property (nonatomic,strong) NSArray *memberList;
@property (nonatomic,strong) NSArray *receiveMemberList;

@end
