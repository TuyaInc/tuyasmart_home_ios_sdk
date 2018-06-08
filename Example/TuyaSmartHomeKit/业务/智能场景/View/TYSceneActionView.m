//
//  TYSceneActionView.m
//  TYSmartSceneLibrary
//
//  Created by XuChengcheng on 2017/4/30.
//  Copyright © 2017年 xcc. All rights reserved.
//

#import "TYSceneActionView.h"
#import "TYActionTableViewCell.h"

@interface TYSceneActionView() <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, strong) UIControl *touchLayer;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray *devIdArray;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSTimer *timeout;


@end

@implementation TYSceneActionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.timeout = [NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(resendTimeout) userInfo:nil repeats:NO];
    }
    
    return self;
}

- (void)showWithTitle:(NSString *)title actList:(NSArray *)actList{
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.windowLevel = UIWindowLevelAlert;
    self.window.backgroundColor = [UIColor clearColor];
    
    self.touchLayer = [[UIControl alloc] initWithFrame:self.window.bounds];
    self.touchLayer.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    [self.window addSubview:self.touchLayer];
    
    [self.window makeKeyAndVisible];
    [self.touchLayer addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchDown];
    
    [self.window addSubview:self];
    self.window.alpha = 0.0;
    [UIView animateWithDuration:0.3 animations:^{
        self.window.alpha = 1.0;
    } completion:^(BOOL finished) {
    }];
    
    float height = 0.0;
    if (actList.count == 1) {
        height = 40 * 2 + 56 * 2;
    } else if (actList.count == 2) {
        height = 40 * 2 + 56 * 3;
    } else {
        height = 40 * 2 + 56 * 4;
    }
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake((APP_SCREEN_WIDTH - 270) / 2.0, (APP_SCREEN_HEIGHT - height) / 2.0, 270, height)];
    view.layer.cornerRadius = 12;
    view.backgroundColor = [UIColor whiteColor];
    [self.window addSubview:view];
    
    UILabel *titleLabel = [TPViewUtil simpleLabel:CGRectMake(0, 0, 270, 40) f:16 tc:HEXCOLOR(0x303030) t:title];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [view addSubview:titleLabel];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 39.5, 270, 0.5)];
    lineView.backgroundColor = HEXCOLOR(0xdbdbdb);
    [view addSubview:lineView];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, 270, height - 40 * 2) style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _dataSource = [NSMutableArray arrayWithArray:actList];
    _tableView = tableView;
    [view addSubview:tableView];
    _devIdArray = [NSMutableArray array];
    for (TuyaSmartSceneActionModel *model in _dataSource) {
        [_devIdArray addObject:model.entityId];
    }
    
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(0, height - 40.5, 270, 0.5)];
    lineView1.backgroundColor = HEXCOLOR(0xdbdbdb);
    [view addSubview:lineView1];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, height - 40, 270, 40)];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn setTitle:NSLocalizedString(@"ty_smart_scene_pop_know", @"") forState:UIControlStateNormal];
    [btn setTitleColor:HEXCOLOR(0x02bb00) forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(IKnowBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
}

- (void)updateCellStateWithDevId:(NSString *)devId dps:(NSDictionary *)dps {
    
    NSLog(@"dps : %@, actions : %@", dps, devId);
    
    if ([_devIdArray containsObject:devId] && dps.count > 0) {
        
        for (TuyaSmartSceneActionModel *model in _dataSource) {
            
            if ([model.entityId isEqualToString:devId]) {
                
                model.status = TYSceneActionStatusSuccess;
            }
        }
        [_tableView reloadData];
    }
}

- (void)resendTimeout {
    
    BOOL hasTimeout = NO;
    for (TuyaSmartSceneActionModel *model in _dataSource) {
        if (model.status == TYSceneActionStatusLoading) {
            model.status = TYSceneActionStatusTimeout;
            hasTimeout = YES;
        }
    }
    
    if (hasTimeout) {
        [_tableView reloadData];
    }
}

- (IBAction)IKnowBtnClicked:(id)sender {
    [self hide];
}

- (void)hide {
    if (self.timeout) {
        [self.timeout invalidate];
        self.timeout = nil;
    }
    [UIView animateWithDuration:0.3 animations:^{
        self.window.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self.touchLayer removeFromSuperview];
        self.touchLayer = nil;
        self.window.hidden = YES;
        self.window = nil;
        if ([self.delegate respondsToSelector:@selector(TYSceneActionViewDidDismiss)]) {
            [self.delegate TYSceneActionViewDidDismiss];
        }
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 56;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"addSceneCell";
    TYActionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[TYActionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    TuyaSmartSceneActionModel *model= _dataSource[indexPath.row];
    TuyaSmartDevice *smartDevice = [TuyaSmartDevice deviceWithDeviceId:model.entityId];
    if (!smartDevice.deviceModel.isOnline) {
        model.status = TYSceneActionStatusOffline;
    }
    [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:smartDevice.deviceModel.iconUrl]];
    cell.model = model;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}




@end
