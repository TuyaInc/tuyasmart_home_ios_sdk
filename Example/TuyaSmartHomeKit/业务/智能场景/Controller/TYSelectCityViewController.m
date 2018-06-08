//
//  TYSelectCityViewController.m
//  TuyaSmartPublic
//
//  Created by 冯晓 on 2016/10/26.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TYSelectCityViewController.h"
#import "TYLocationCityViewCell.h"
#import "TYSelectCityViewCell.h"
#import "TPScheduledLocationManager.h"
#import <MapKit/MapKit.h>
#import "TYSceneMapPoint.h"


#define TYSelectCityViewCellIdentifier @"TYSelectCityViewCellIdentifier"
#define TYLocationCityViewCellIdentifier @"TYLocationCityViewCellIdentifier"

@interface TYSelectCityViewController () <TPScheduledLocationManagerDelegate,MKMapViewDelegate>

@property (nonatomic, strong) TPScheduledLocationManager *locationManager;
@property (nonatomic, strong) TuyaSmartCityModel *selectedCity;
@property (nonatomic, strong) TuyaSmartCityModel *locationedCity;
@property (nonatomic, strong) TYSceneMapPoint *myPoint;
@property (nonatomic, assign) BOOL isLoading;
@property (strong, nonatomic) MKMapView *mapView;
@property (nonatomic, strong) UILabel   *tipsLabel;

@end

@implementation TYSelectCityViewController

- (void)dealloc {
    [self.locationManager stopAllLocation];
    _mapView.delegate = nil;
}

- (TPScheduledLocationManager *)locationManager {
    if (!_locationManager) {
        _locationManager = [TPScheduledLocationManager new];
        _locationManager.delegate = self;
    }
    return _locationManager;
}


- (MKMapView *)mapView {
    if (!_mapView) {
        
        _mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 111, APP_CONTENT_WIDTH, APP_SCREEN_HEIGHT - 111)];
        _mapView.delegate = self;
        [_mapView setShowsUserLocation:NO];
    }
    return _mapView;
}

- (UILabel *)tipsLabel {
    
    if (!_tipsLabel) {
        _tipsLabel = [TPViewUtil simpleLabel:CGRectMake(0, APP_TOP_BAR_HEIGHT, APP_CONTENT_WIDTH, 111 - APP_TOP_BAR_HEIGHT) f:16 tc:HEXCOLOR(0x999999) t:NSLocalizedString(@"getting_location", nil)];
        _tipsLabel.textAlignment = NSTextAlignmentCenter;
        _tipsLabel.backgroundColor = TOP_BAR_BACKGROUND_COLOR;
    }
    return _tipsLabel;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self initView];
    
    [self initData];
}

- (void)initData {
    
    _selectedCity = [TuyaSmartCityModel modelWithJSON:@{@"city":NSLocalizedString(@"ty_smart_positioning", nil),@"cityId":@(0)}];
    _locationedCity = [TuyaSmartCityModel modelWithJSON:@{@"city":NSLocalizedString(@"ty_smart_positioning", nil),@"cityId":@(0)}];

    
    self.dataSource = [NSMutableArray new];
    
    [self.locationManager getUserLocationWithInterval:300];
    
    [self.tableView reloadData];
    
    WEAKSELF_AT
    NSString *countryCode = [TPUtils getISOcountryCode];
    [[TuyaSmartSceneManager sharedInstance] getCityListWithCountryCode:countryCode success:^(NSArray<TuyaSmartCityModel *> *list) {
        if (list.count == 0)
        {
            [[TuyaSmartSceneManager sharedInstance] getCityListWithCountryCode:@"CN" success:^(NSArray<TuyaSmartCityModel *> *list) {
                weakSelf_AT.dataSource = [NSMutableArray arrayWithArray:list];
                [weakSelf_AT.tableView reloadData];
            } failure:^(NSError *error) {
                
            }];
        }
        else
        {
            weakSelf_AT.dataSource = [NSMutableArray arrayWithArray:list];
            [weakSelf_AT.tableView reloadData];
        }
    } failure:^(NSError *error) {
        
    }];
}

- (BOOL)isChineseAccount {
    return [[TuyaSmartUser sharedInstance].countryCode isEqualToString:@"86"];
}

- (void)initView {
    
    self.view.backgroundColor = MAIN_BACKGROUND_COLOR;
    
    
    if ([self isChineseAccount]) {
        
        self.tableViewStyle = UITableViewStylePlain;
        self.tableView.backgroundColor = [UIColor clearColor];
        self.tableView.frame = CGRectMake(0, APP_TOP_BAR_HEIGHT, APP_CONTENT_WIDTH, APP_VISIBLE_HEIGHT);
        [self.tableView registerClass:[TYSelectCityViewCell class] forCellReuseIdentifier:TYSelectCityViewCellIdentifier];
        [self.tableView registerClass:[TYLocationCityViewCell class] forCellReuseIdentifier:TYLocationCityViewCellIdentifier];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        self.tableView.separatorColor = LIST_LINE_COLOR;
        [self.view addSubview:self.tableView];
        
    } else {
        
        [self.view addSubview:self.tipsLabel];
        [self.view addSubview:self.mapView];
        
    }
}

- (void)rightBtnAction {
    if (_locationedCity.cityId == 0) {
        return;
    }
    if ((self.delegate && [self.delegate respondsToSelector:@selector(viewController:didSelectCity:)])) {
        [self.delegate viewController:self didSelectCity:_locationedCity];
    }
    [self backButtonTap];
}

- (NSString *)titleForRightItem {
    if ([self isChineseAccount]) {
        return @"";
    } else {
        return NSLocalizedString(@"ty_alert_confirm", nil);
    }
}

- (NSString *)titleForCenterItem {
    return NSLocalizedString(@"ty_smart_positioning_selectcity", nil);
}

#pragma mark - 子类继承
//是否显示下拉刷新
- (BOOL)showPullToRefresh {
    return NO;
}
//是否显示上拉刷新
- (BOOL)showInfinite {
    return NO;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else {
        return self.dataSource.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        TYLocationCityViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TYLocationCityViewCellIdentifier forIndexPath:indexPath];
        
        if (_locationedCity) {
            [cell setItem:_locationedCity.city];
        }
        
        return cell;
    } else {
    
        
        TuyaSmartCityModel *city = self.dataSource[indexPath.row];
        
        TYSelectCityViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TYSelectCityViewCellIdentifier forIndexPath:indexPath];
        
        
        [cell setItem:city.city isSelect:city.cityId == _selectedCity.cityId];
        
        return cell;
        
    }

}


- (NSString *)sectionTitle:(NSInteger)section {
    if (section == 0) {
        return NSLocalizedString(@"ty_smart_positioning_address", nil);
    } else {
        return NSLocalizedString(@"ty_smart_city", nil);
    }
    
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self sectionTitle:section];
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 48;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = MAIN_BACKGROUND_COLOR;
    
    
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 24, 200, 16)];
    textLabel.backgroundColor = [UIColor clearColor];
    textLabel.font = [UIFont systemFontOfSize:12];
    textLabel.textColor = LIST_LIGHT_TEXT_COLOR;
    textLabel.text = [self sectionTitle:section];
    [view addSubview:textLabel];
    
    return view;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight = 48;
    if (scrollView.contentOffset.y <= sectionHeaderHeight && scrollView.contentOffset.y >= 0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y >= sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        if (_locationedCity.cityId == 0)
        {
            return;
        }
        if ((self.delegate && [self.delegate respondsToSelector:@selector(viewController:didSelectCity:)])) {
            [self.delegate viewController:self didSelectCity:_locationedCity];
        }
    }
    else
    {
        TuyaSmartCityModel *city = self.dataSource[indexPath.row];
        _selectedCity = city;
      
        if ((self.delegate && [self.delegate respondsToSelector:@selector(viewController:didSelectCity:)])) {
            [self.delegate viewController:self didSelectCity:_selectedCity];
        }
    }
    [self backButtonTap];
}

#pragma mark - TPScheduledLocationManagerDelegate

- (void)scheduledLocationManageDidFailWithError:(NSError *)error {
    _selectedCity = [TuyaSmartCityModel modelWithJSON:@{@"city":NSLocalizedString(@"ty_smart_nopositioning", nil),@"cityId":@(0)}];
    
    [self.tableView reloadData];
}

- (void)scheduledLocationManageDidUpdateLocations:(CLLocation *)location {
    [self.locationManager stopAllLocation];
    
    //放大到标注的位
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(location.coordinate, 400, 400);
    [self.mapView setRegion:region animated:NO];
    
    WEAKSELF_AT

    [[TuyaSmartSceneManager sharedInstance] getCityInfoWithLatitude:[NSString stringWithFormat:@"%f",location.coordinate.latitude] longitude:[NSString stringWithFormat:@"%f",location.coordinate.longitude] success:^(TuyaSmartCityModel *city) {
        if (city.city.length > 0 && city.cityId > 0) {
            weakSelf_AT.locationedCity = city;
            [weakSelf_AT.tableView reloadData];
        } else {
            weakSelf_AT.locationedCity = [TuyaSmartCityModel modelWithJSON:@{@"city":NSLocalizedString(@"ty_smart_nopositioning", nil),@"cityId":@(0)}];
            [weakSelf_AT.tableView reloadData];
        }
    } failure:^(NSError *error) {
        weakSelf_AT.locationedCity = [TuyaSmartCityModel modelWithJSON:@{@"city":NSLocalizedString(@"ty_smart_nopositioning", nil),@"cityId":@(0)}];
        [weakSelf_AT.tableView reloadData];
    }];
}


#pragma mark - MKMapViewDelegate
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    
}


- (void)addAnnotation:(double)latitude longitude:(double)longitude {
    
    CLLocation *loc = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
    CLLocationCoordinate2D coord = [loc coordinate];
    
    [self.mapView removeAnnotation:_myPoint];
    
    
    TYSceneMapPoint *myPoint = [[TYSceneMapPoint alloc] initWithCoordinate:coord];
    //添加标注
    [self.mapView addAnnotation:myPoint];

    
    _myPoint = myPoint;
    
}

- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated {

}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    
    if (_isLoading) {
        return;
    }
    
    _isLoading = YES;
    
    CLLocationCoordinate2D coord = [self.mapView centerCoordinate];

    [TPProgressUtils showMessagBelowTopbarView:NSLocalizedString(@"getting_location", nil) toView:self.view];
    
    WEAKSELF_AT
    [[TuyaSmartSceneManager sharedInstance] getCityInfoWithLatitude:[NSString stringWithFormat:@"%f",coord.latitude] longitude:[NSString stringWithFormat:@"%f",coord.longitude] success:^(id result) {
        [TPProgressUtils hideHUDForView:weakSelf_AT.view animated:YES];
        TuyaSmartCityModel *city = (TuyaSmartCityModel *)result;
        if (city.city.length > 0)
        {
            weakSelf_AT.locationedCity = city;
            weakSelf_AT.tipsLabel.text = city.city;
            CLLocationCoordinate2D coord = [weakSelf_AT.mapView centerCoordinate];
            [weakSelf_AT addAnnotation:coord.latitude longitude:coord.longitude];
        }
        else
        {
            if ([weakSelf_AT.tipsLabel.text isEqualToString:NSLocalizedString(@"getting_location", nil)])
            {
                weakSelf_AT.tipsLabel.text = NSLocalizedString(@"can_not_locate", nil);
            }
            [TPProgressUtils showError:NSLocalizedString(@"can_not_locate", nil)];
        }
        weakSelf_AT.isLoading = NO;
    } failure:^(NSError *error) {
        [TPProgressUtils hideHUDForView:weakSelf_AT.view animated:YES];
        [TPProgressUtils showError:error];
        weakSelf_AT.isLoading = NO;
    }];
}

@end
