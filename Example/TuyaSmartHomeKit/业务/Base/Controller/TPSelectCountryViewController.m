//
//  ATSelectCountryViewController.m
//  Airtake
//
//  Created by fisher on 14/12/11.
//  Copyright (c) 2014年 hanbolong. All rights reserved.
//

#import "TPSelectCountryViewController.h"
#import "NSMutableDictionary+TPCategory.h"
#import "NSMutableArray+TPCategory.h"


@interface TPSelectCountryViewController() <UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate,UISearchDisplayDelegate>

@property (nonatomic, strong) UISearchBar               *searchBar;
@property (nonatomic, strong) UITableView               *tableView;
@property (nonatomic, strong) NSDictionary              *dataSource;
@property (nonatomic, strong) NSArray                   *letterList;
@property (nonatomic, strong) NSMutableArray            *searchResults;
@property (nonatomic, strong) NSMutableArray            *allDataList;
@property (nonatomic, strong) UISearchDisplayController *searchDisplayController;
@property (nonatomic, strong) TPCountryService          *countryService;
@end

@implementation TPSelectCountryViewController

- (TPCountryService *)countryService {
    if (!_countryService) {
        _countryService = [TPCountryService new];
    }
    return _countryService;
}

- (void)viewDidLoad {
    
    [self initView];
    [self loadData];
    [super viewDidLoad];

}

- (void)loadData {
    _searchResults  = [NSMutableArray new];
    _letterList     = [NSArray new];
    _allDataList    = [NSMutableArray new];
    
    
    
    [TPProgressUtils showMessagBelowTopbarView:NSLocalizedString(@"loading", nil) toView:self.view];
    
    
    WEAKSELF_AT
    [self.countryService getCountryList:^(NSArray<TPCountryModel *> *list) {
        
        at_dispatch_async_on_default_global_thread(^{

            
            NSMutableDictionary *countryCodeDict = [[NSMutableDictionary alloc] init];
            
            for (TPCountryModel *model in list) {
                
                NSString *letter = model.firstLetter;
                
                NSMutableArray *mutableList;
                if ([countryCodeDict objectForKey:letter]) {
                    mutableList = [countryCodeDict objectForKey:letter];
                    [mutableList tp_safeAddObject:model];
                } else {
                    mutableList = [NSMutableArray arrayWithArray:@[model]];
                }
                
                [countryCodeDict tp_safeSetObject:mutableList forKey:letter];
                
            }
            
            weakSelf_AT.dataSource = countryCodeDict;
            
            at_dispatch_async_on_main_thread(^{
               
                [TPProgressUtils hideHUDForView:weakSelf_AT.view animated:YES];
                [weakSelf_AT reloadData];

            });
            

        });
    } failure:^(NSError *error) {
        [TPProgressUtils hideHUDForView:weakSelf_AT.view animated:YES];
        [TPProgressUtils showError:error];
        
    }];

}


- (void)reloadData {
    NSArray *keys   = [_dataSource allKeys];
    NSArray *sortKeys = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSLiteralSearch];
    }];
    
    [[_dataSource allValues] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [_allDataList addObjectsFromArray:obj];
    }];
    
    _letterList = sortKeys;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
    
}

- (void)initView {
    
    _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, APP_CONTENT_WIDTH, 40)];
    _searchBar.delegate = self;
    [_searchBar setPlaceholder:NSLocalizedString(@"search", @"")];
    
    _searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:_searchBar contentsController:self];
    _searchDisplayController.searchResultsTableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_CONTENT_WIDTH, 44)];
    _searchDisplayController.active = NO;
    _searchDisplayController.searchResultsDataSource = self;
    _searchDisplayController.searchResultsDelegate = self;
    _searchDisplayController.delegate = self;
    
    
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = _searchBar;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
}


- (NSString *)titleForCenterItem {
    return NSLocalizedString(@"please_choose_country_first", @"");
}


- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, APP_TOP_BAR_HEIGHT, APP_SCREEN_WIDTH, APP_VISIBLE_HEIGHT) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.separatorColor = HEXCOLOR(0xdddddd);
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

#pragma mark - TableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == _searchDisplayController.searchResultsTableView) {
        return self.searchResults.count;
    } else {
        NSArray *array = [self.dataSource objectForKey:[self.letterList objectAtIndex:section]];
        return array.count;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == _searchDisplayController.searchResultsTableView) {
        return 1;
    } else {
        return _letterList.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if (tableView == _searchDisplayController.searchResultsTableView) {
        TPCountryModel *model = _searchResults[indexPath.row];
        cell.textLabel.text = model.countryName;
    }
    else {
        TPCountryModel *model = [[self.dataSource objectForKey:[self.letterList objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
        cell.textLabel.text = model.countryName;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    TPCountryModel *model;
    if (tableView == _searchDisplayController.searchResultsTableView) {
        model = _searchResults[indexPath.row];
    } else {
        model = [[self.dataSource objectForKey:[self.letterList objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
    }
    [self.delegate didSelectCountry:self model:model];
}


- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    if (tableView == _searchDisplayController.searchResultsTableView) {
        return nil;
    } else {
        return self.letterList.count > 1 ? self.letterList : nil;
    }
}

- (NSString *)titleForHeaderInSection:(NSInteger)section {
    return [[self.letterList objectAtIndex:section] uppercaseString];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self titleForHeaderInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (tableView == _searchDisplayController.searchResultsTableView) {
        return 0;
    } else {
        return 25;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (tableView == _searchDisplayController.searchResultsTableView) {
        return nil;
    }
        
        
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = HEXCOLOR(0xf1f3f5);
    
    UIView *border1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, view.width, 0.5)];
    border1.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    border1.backgroundColor = HEXCOLOR(0xdddddd);
    [view addSubview:border1];
    
    
    UIView *border2 = [[UIView alloc] initWithFrame:CGRectMake(0, 25-0.5, view.width, 0.5)];
    border2.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    border2.backgroundColor = HEXCOLOR(0xdddddd);
    [view addSubview:border2];
    
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, view.width, view.height)];
    textLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    textLabel.backgroundColor = [UIColor clearColor];
    textLabel.font = [UIFont boldSystemFontOfSize:12];
    textLabel.textColor = RGBCOLOR(0x99, 0x99, 0x99);
    textLabel.text = [self titleForHeaderInSection:section];
    textLabel.shadowColor = RGBCOLOR(0xfa, 0xfa, 0xfa);
    textLabel.shadowOffset = CGSizeMake(0, 1);
    [view addSubview:textLabel];
    
    return view;
}

#pragma UISearchDisplayDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    _searchResults = [[NSMutableArray alloc] init];
    
    if (searchText.length > 0) {
        for (TPCountryModel *model in _allDataList) {
            
            NSRange result1 = [model.countryName rangeOfString:searchBar.text options:NSCaseInsensitiveSearch];
            NSRange result2 = [model.countryCode rangeOfString:searchBar.text options:NSCaseInsensitiveSearch];
            NSRange result3 = [model.countryAbb rangeOfString:searchBar.text options:NSCaseInsensitiveSearch];
            
            
            if (result1.length > 0 || result2.length > 0  || result3.length > 0) {
                
                [_searchResults tp_safeAddObject:model];
            }
        }
    }
}

@end
