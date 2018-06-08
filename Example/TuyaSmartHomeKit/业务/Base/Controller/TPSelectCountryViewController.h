//
//  ATSelectCountryViewController.h
//  Airtake
//
//  Created by fisher on 14/12/11.
//  Copyright (c) 2014年 hanbolong. All rights reserved.
//

#import "TPBaseTableViewController.h"
#import "TPCountryService.h"


@class TPSelectCountryViewController;

@protocol ATSelectCountryDelegate <NSObject>

- (void)didSelectCountry:(TPSelectCountryViewController *)controller model:(TPCountryModel *)model;

@end

@interface TPSelectCountryViewController : TPBaseViewController

@property (nonatomic,weak) id <ATSelectCountryDelegate> delegate;

@end
