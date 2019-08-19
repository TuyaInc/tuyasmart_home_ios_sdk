//
//  TYTodayViewController.m
//  TuyaWidget
//
//  Created by lan on 2018/9/10.
//  Copyright © 2018年 Tuya. All rights reserved.
//

#import "TYTodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>
#import "TYWidgetDeviceModel.h"
#import "TYWidgetDeviceCell.h"

@interface TYTodayViewController () <NCWidgetProviding, TuyaSmartHomeDelegate, UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) TuyaSmartHome *home;
@property (nonatomic, strong) NSUserDefaults *groupUserDefault;
@property (nonatomic, strong) NSMutableArray *deviceList;
@property (nonatomic, assign) CGSize maxSize;
@property (nonatomic, strong) NSString *currentSid;
@property (nonatomic, assign) long long currentHome;
@property (nonatomic, assign) BOOL firstAppear;

@property (nonatomic, strong) UILabel *loadingLabel;
@property (nonatomic, strong) UICollectionView *deviceListView;
@end

@implementation TYTodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.firstAppear = YES;
    
    [self initView];
    [self initSDK];
    
    if ([TuyaSmartUser sharedInstance].isLogin) {
        [self initData];
    } else {
        [self reloadView];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (self.firstAppear) {
        self.firstAppear = NO;
        return;
    }
    
    if ([TuyaSmartUser sharedInstance].isLogin) {
        if (![[TuyaSmartUser sharedInstance].sid isEqualToString:self.currentSid]) {
            // widget's account is different with main app
            [self initData];
        } else if ([[self.groupUserDefault objectForKey:@"kCurrentHomeIdKey"] longLongValue] != self.currentHome) {
            // widget's home is different with main app
            [self initData];
        }
    } else {
        [self reloadView];
    }
}

- (void)initView {
    [self.view addSubview:self.loadingLabel];
    [self.view addSubview:self.deviceListView];
    
    if (!IOS10) {
        self.deviceListView.size = [self getCompactSize];
        self.loadingLabel.size = [self getCompactSize];
    }
}

- (void)initSDK {
    // TodayViewController may be created mant times, but SDK only need initialize once.
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
#if DEBUG
        [[TuyaSmartSDK sharedInstance] setDebugMode:YES];
#endif
        
        [TuyaSmartSDK sharedInstance].appGroupId = APP_GROUP_NAME;
        [[TuyaSmartSDK sharedInstance] startWithAppKey:SDK_APPKEY secretKey:SDK_APPSECRET];
    });
}

- (void)initData {
    [self showLoadingLabel:@"loading"];
    
    self.currentSid = [TuyaSmartUser sharedInstance].sid;
    if (![self.groupUserDefault objectForKey:@"kCurrentHomeIdKey"]) {
        self.home = nil;
        [self reloadData];
        return;
    }
    
    self.currentHome = [[self.groupUserDefault objectForKey:@"kCurrentHomeIdKey"] longLongValue];
    self.home = [TuyaSmartHome homeWithHomeId:self.currentHome];
    self.home.delegate = self;
    
    [self reloadData];
    
    WEAKSELF_AT
    [self.home getHomeDetailWithSuccess:^(TuyaSmartHomeModel *homeModel) {
        [weakSelf_AT reloadData];
    } failure:^(NSError *error) {
        [weakSelf_AT showLoadingLabel:@"No controllable devices"];
    }];
}

#pragma mark - method

- (void)showLoadingLabel:(id)content {
    
    NSString *text;
    if ([content isKindOfClass:[NSError class]]) {
        text = ((NSError *)content).localizedDescription;
    } else if ([content isKindOfClass:[NSString class]]) {
        text = content;
    }

    self.loadingLabel.text = text;
    self.loadingLabel.hidden = NO;
    self.deviceListView.hidden = YES;
}

- (void)hideLoadingLabel {
    self.loadingLabel.hidden = YES;
    self.deviceListView.hidden = NO;
}

- (void)widgetCanExpand:(BOOL)expand {
    if (@available(iOS 10.0, *)) {
        if (expand) {
            self.extensionContext.widgetLargestAvailableDisplayMode = NCWidgetDisplayModeExpanded;
        } else {
            self.extensionContext.widgetLargestAvailableDisplayMode = NCWidgetDisplayModeCompact;
        }
    } else {
        self.preferredContentSize = [self getCompactSize];
    }
    
    [self.deviceListView reloadData];
}

- (void)reloadData {
    self.deviceList = [TYWidgetDeviceModel deviceModelListWithHome:self.home];
    
    [self reloadView];
}

- (void)reloadView {
    [self resetListViewSize];
    
    if (self.deviceList.count) {
        [self widgetCanExpand:self.deviceList.count > 4];
        
        [self hideLoadingLabel];
        [self.deviceListView reloadData];
    } else {
        [self widgetCanExpand:NO];
        
        if ([TuyaSmartUser sharedInstance].isLogin && self.currentHome) {
            [self showLoadingLabel:@"No controllable devices"];
        } else if ([TuyaSmartUser sharedInstance].isLogin && !self.currentHome){
            // Create a TapGesture that jumps to the main app when gesture is triggered, guiding the user to create a family
            [self showLoadingLabel:@"Create a family and add devices to it before using shortcuts to control the devices."];
        } else if (![TuyaSmartUser sharedInstance].isLogin) {
            // Create a TapGesture that jumps to the main app when gesture is triggered, guiding the user to login
            [self showLoadingLabel:@"Log in to use widgets"];
        }
    }
}

- (void)resetListViewSize {
    if (@available(iOS 10.0, *)) {
        if (self.extensionContext.widgetActiveDisplayMode == NCWidgetDisplayModeCompact) {
            self.deviceListView.size = [self getCompactSize];
        } else {
            CGSize size = [self getExpandSize];
            
            self.preferredContentSize = size;
            self.loadingLabel.size = size;
            self.deviceListView.size = size;
        }
    } else {
        self.deviceListView.size = [self getCompactSize];
    }
}

- (CGSize)getCompactSize {
    return CGSizeMake(self.view.width, 110);
}

- (CGSize)getExpandSize {
    NSInteger line = ((NSInteger)self.deviceList.count - 1) / 4 + 1;

    CGFloat height = line * 100 + 10;
    if (height <= self.maxSize.height) return CGSizeMake(self.view.width, height);
    
    NSInteger maxLine = (self.maxSize.height - 10) / 100;
    return CGSizeMake(self.view.width, maxLine * 100 + 10);
}

#pragma mark - UICollectionViewDataSource, UICollectionViewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.deviceListView.height == 110) {
        return self.deviceList.count >= 4 ? 4 : self.deviceList.count;
    } else {
        return self.deviceList.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TYWidgetDeviceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DeviceListCellIdentifier" forIndexPath:indexPath];
    
    cell.model = self.deviceList[indexPath.row];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    TYWidgetDeviceCell *cell = (TYWidgetDeviceCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    [cell switchStatus];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.view.width / 4 - 3, 100);
}

#pragma mark - TuyaSmartHomeDelegate

- (void)home:(TuyaSmartHome *)home device:(TuyaSmartDeviceModel *)device dpsUpdate:(NSDictionary *)dps {
    [self reloadData];
}

- (void)home:(TuyaSmartHome *)home group:(TuyaSmartGroupModel *)group dpsUpdate:(NSDictionary *)dps {
    [self reloadData];
}

- (void)home:(TuyaSmartHome *)home didAddDeivice:(TuyaSmartDeviceModel *)device {
    [self reloadData];
}

- (void)home:(TuyaSmartHome *)home didRemoveDeivice:(NSString *)devId {
    [self reloadData];
}

- (void)home:(TuyaSmartHome *)home didAddGroup:(TuyaSmartGroupModel *)group {
    [self reloadData];
}

- (void)home:(TuyaSmartHome *)home didRemoveGroup:(NSString *)groupId {
    [self reloadData];
}

- (void)home:(TuyaSmartHome *)home deviceInfoUpdate:(TuyaSmartDeviceModel *)device {
    [self reloadData];
}

- (void)home:(TuyaSmartHome *)home groupInfoUpdate:(TuyaSmartGroupModel *)group {
    [self reloadData];
}

#pragma mark - NCWidgetProviding

- (void)widgetActiveDisplayModeDidChange:(NCWidgetDisplayMode)activeDisplayMode withMaximumSize:(CGSize)maxSize {
    if (activeDisplayMode == NCWidgetDisplayModeCompact) {
        CGSize size = [self getCompactSize];
        
        self.preferredContentSize = size;
        self.loadingLabel.size = size;
        
    } else {
        self.maxSize = maxSize;
        CGSize size = [self getExpandSize];
        
        self.preferredContentSize = size;
        self.loadingLabel.size = size;
        self.deviceListView.size = size;
        
    }
    
    [self.deviceListView reloadData];
}

- (UIEdgeInsets)widgetMarginInsetsForProposedMarginInsets:(UIEdgeInsets)defaultMarginInsets {
    return UIEdgeInsetsZero;
}

#pragma mark - getter

- (UILabel *)loadingLabel {
    if (!_loadingLabel) {
        _loadingLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _loadingLabel.textAlignment = NSTextAlignmentCenter;
        _loadingLabel.numberOfLines = 0;
        if (IOS10) {
            _loadingLabel.textColor = HEXCOLORA(0x030303, 0.5);
        } else {
            _loadingLabel.textColor = HEXCOLORA(0xFFFFFF, 0.5);
        }
        _loadingLabel.hidden = YES;
        _loadingLabel.userInteractionEnabled = YES;
    }
    return _loadingLabel;
}

- (UICollectionView *)deviceListView {
    if (!_deviceListView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        flowLayout.itemSize = CGSizeZero;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 0;
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
        _deviceListView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _deviceListView.top = 5;
        _deviceListView.dataSource = self;
        _deviceListView.delegate = self;
        _deviceListView.pagingEnabled = NO;
        _deviceListView.backgroundColor = [UIColor clearColor];
        _deviceListView.showsHorizontalScrollIndicator = NO;
        _deviceListView.showsVerticalScrollIndicator = NO;
        [_deviceListView registerClass:[TYWidgetDeviceCell class] forCellWithReuseIdentifier:@"DeviceListCellIdentifier"];
    }
    return _deviceListView;
}

- (NSUserDefaults *)groupUserDefault {
    if (!_groupUserDefault) {
        _groupUserDefault = [[NSUserDefaults alloc] initWithSuiteName:APP_GROUP_NAME];
    }
    return _groupUserDefault;
}
@end
