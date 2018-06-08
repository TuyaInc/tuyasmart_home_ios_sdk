//
//  TYSelectCityViewController.h
//  TuyaSmartPublic
//
//  Created by 冯晓 on 2016/10/26.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TPBaseTableViewController.h"

@class TuyaSmartCityModel;
@class TYSelectCityViewController;

@protocol TYSelectCityViewControllerDelegate <NSObject>

- (void)viewController:(TYSelectCityViewController *)vc didSelectCity:(TuyaSmartCityModel *)city;

@end

@interface TYSelectCityViewController : TPBaseTableViewController

@property (nonatomic, weak) id <TYSelectCityViewControllerDelegate> delegate;

@end
