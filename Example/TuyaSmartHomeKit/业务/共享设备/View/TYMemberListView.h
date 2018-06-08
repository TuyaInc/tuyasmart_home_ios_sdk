//
//  TYMemberListView.h
//  TuyaSmart
//
//  Created by 冯晓 on 16/1/7.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TYMemberListCell.h"

typedef enum : NSUInteger {
    TYMemberSend = 1,
    TYMemberReceive,
} TYMemberCurrentType;

@class TYMemberListView;

@protocol TYMemberListViewDataSource <NSObject>

@property (nonatomic, strong) NSArray *memberList;
@property (nonatomic, strong) NSArray *receiveMemberList;

@end

@protocol TYMemberListViewDelegate <NSObject>

@required

- (void)memberListView:(TYMemberListView *)memberListView didSelectRowAtModel:(TuyaSmartShareMemberModel *)member currentType:(TYMemberCurrentType)currentType indexPath:(NSIndexPath *)indexPath;

- (void)memberListView:(TYMemberListView *)memberListView deleteRowWithMember:(TuyaSmartShareMemberModel *)member currentType:(TYMemberCurrentType)currentType success:(TYSuccessHandler)success failure:(TYFailureError)failure;

- (void)addNewMember:(TYMemberListView *)memberListView;

@end

@interface TYMemberListView : UIView

@property (nonatomic, weak) id <TYMemberListViewDelegate> delegate;
@property (nonatomic, weak) id <TYMemberListViewDataSource> dataSource;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) NSInteger currentIndex;

- (void)reloadData;
- (void)setCurrentSelectIndex:(NSInteger)index;

@end
