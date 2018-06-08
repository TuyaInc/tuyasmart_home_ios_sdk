//
//  TYDeviceShareView.m
//  TuyaSmart
//
//  Created by 冯晓 on 16/1/7.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TYDeviceShareView.h"

@interface TYDeviceShareView() <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) TPEmptyView *emptyView;
@property (nonatomic, strong) UILabel *title;

@end


@implementation TYDeviceShareView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = MAIN_BACKGROUND_COLOR;
          
        [self initView];
    }
    return self;
}

- (void)initView {
    self.topBarView.leftItem.image = nil;
    self.topBarView.leftItem.title = NSLocalizedString(@"cancel", nil);
    self.topBarView.centerItem.title = NSLocalizedString(@"ty_share_add_device", @"");
    [self addSubview:self.topBarView];
    
    _title = [TPViewUtil simpleLabel:CGRectMake(15, APP_TOP_BAR_HEIGHT + 24, APP_CONTENT_WIDTH - 15, 15) f:12 tc:HEXCOLOR(0x9B9B9B) t:NSLocalizedString(@"ty_add_share_tab1_note", nil)];
    _title.backgroundColor = [UIColor clearColor];
    [self addSubview:_title];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _title.bottom + 8, APP_SCREEN_WIDTH, APP_VISIBLE_HEIGHT - 47 - 55) style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.allowsSelection = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[TYDeviceShareViewListCell class] forCellReuseIdentifier:@"ShareMemberTableViewCell"];
    
    [self addSubview:self.tableView];
    [self addSubview:self.emptyView];
    [self addSubview:self.shareButton];
}

- (TPEmptyView *)emptyView {
    if (!_emptyView) {
        CGRect emptyViewFrame = CGRectMake(0, APP_TOP_BAR_HEIGHT + 44, APP_SCREEN_WIDTH, self.height - 44 - 64 - 40);
        _emptyView = [[TPEmptyView alloc] initWithFrame:emptyViewFrame title:NSLocalizedString(@"no_share", @"") imageName:@"ty_list_no_share"];
    }
    return _emptyView;
}

- (UIButton *)shareButton {
    if (!_shareButton) {
        _shareButton = [TPViewUtil buttonWithFrame:CGRectMake(20, self.height - 52, APP_SCREEN_WIDTH - 40, 40) fontSize:16 bgColor:BUTTON_BACKGROUND_COLOR textColor:[UIColor whiteColor]];
        [_shareButton setTitle:NSLocalizedString(@"new_share", @"") forState:UIControlStateNormal];
    }
    return _shareButton;
}

- (void)reloadData {
    BOOL isEmpty = self.memberList.count == 0;
    self.title.hidden = isEmpty;
    self.emptyView.hidden = !isEmpty;
    [self.tableView reloadData];
}

#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.memberList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TYDeviceShareViewListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShareMemberTableViewCell" forIndexPath:indexPath];
    
    TuyaSmartShareMemberModel *member = [self.memberList objectAtIndex:indexPath.section];
    [cell setUp:member];
    
    return cell;
}

#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        TuyaSmartShareMemberModel *member = [self.memberList objectAtIndex:indexPath.section];
        [self.delegate deleteRowWithMember:member];
    }
}

@end
