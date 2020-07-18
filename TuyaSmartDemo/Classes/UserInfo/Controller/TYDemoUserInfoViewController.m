//
//  TYUserInfoViewController.m
//  TuyaSmartHomeKit_Example
//
//  Created by XuChengcheng on 2020/5/19.
//  Copyright © 2020 xuchengcheng. All rights reserved.
//

#import "TYDemoUserInfoViewController.h"
#import <TuyaSmartBaseKit/TuyaSmartBaseKit.h>
#import "TYDemoRouteManager.h"
#import "TYDemoConfiguration.h"

@interface TYDemoUserInfoViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *userInfo;

@end

@implementation TYDemoUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.centerTitleItem.title = NSLocalizedString(@"用户中心", @"");
    self.topBarView.centerItem = self.centerTitleItem;
    self.rightTitleItem.title = NSLocalizedString(@"logout", @"");
    self.topBarView.rightItem = self.rightTitleItem;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, APP_TOP_BAR_HEIGHT, APP_SCREEN_WIDTH, APP_CONTENT_HEIGHT) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.tableFooterView = [UIView new];
    [self.view addSubview:self.tableView];
    
    _userInfo = @[@"userName", @"phoneNumber", @"email", @"regionCode", @"timezoneId", @"countryCode", @"message center"];
}

- (void)rightBtnAction {
    [[TuyaSmartUser sharedInstance] loginOut:nil failure:nil];
    [[TYDemoRouteManager sharedInstance] openRoute:kTYDemoPopLoginVC withParams:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:TuyaSmartUserNotificationUserSessionInvalid
                                                  object:nil];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kDefaultCurrentHomeId];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _userInfo.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:NSStringFromClass([UITableViewCell class])];
        UIImageView *arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell_view_arrow@2x"]];
        arrow.top = (66 - arrow.height)/2;
        arrow.right = APP_SCREEN_WIDTH - arrow.width - 15;
        [cell.contentView addSubview:arrow];
    }
    
    NSString *text = _userInfo[indexPath.row];
    if (indexPath.row == 0) {
        text = [NSString stringWithFormat:@"%@ : %@", text, [TuyaSmartUser sharedInstance].userName];
    } else if (indexPath.row == 1) {
        text = [NSString stringWithFormat:@"%@ : %@", text, [TuyaSmartUser sharedInstance].phoneNumber];
    } else if (indexPath.row == 2) {
        text = [NSString stringWithFormat:@"%@ : %@", text, [TuyaSmartUser sharedInstance].email];
    } else if (indexPath.row == 3) {
        text = [NSString stringWithFormat:@"%@ : %@", text, [TuyaSmartUser sharedInstance].regionCode];
    } else if (indexPath.row == 4) {
        text = [NSString stringWithFormat:@"%@ : %@", text, [TuyaSmartUser sharedInstance].timezoneId];
    } else if (indexPath.row == 5) {
        text = [NSString stringWithFormat:@"%@ : %@", text, [TuyaSmartUser sharedInstance].countryCode];
    }
    cell.textLabel.text = text;

    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.row == 6) {
        id<TYDemoMessageCenterProtocol> impl = [[TYDemoConfiguration sharedInstance] serviceOfProtocol:@protocol(TYDemoMessageCenterProtocol)];
        if ([impl respondsToSelector:@selector(gotoMessageCenter)]) {
            [impl gotoMessageCenter];
        }
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 66;
}




@end
