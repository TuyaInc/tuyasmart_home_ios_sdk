//
//  TYBackgroundViewController.m
//  TuyaSmartHomeKit_Example
//
//  Created by XuChengcheng on 2018/6/8.
//  Copyright © 2018年 xuchengcheng. All rights reserved.
//

#import "TYBackgroundViewController.h"
#import "TYBackgroundCollectionViewCell.h"

#define kSmartSceneItemCollectionID @"kSmartSceneItemCollectionID"

@interface TYBackgroundViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) UICollectionView *smartScentCollectionView;
@property (nonatomic, strong) TuyaSmartRequest *request;

@end

@implementation TYBackgroundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    [self getBackgroundList];
}

- (void)initView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(APP_SCREEN_WIDTH / 2.0 - 20, (APP_SCREEN_WIDTH / 2.0 - 16 * 2) * 66 / 163 + 10);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    _smartScentCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, APP_TOP_BAR_HEIGHT, APP_CONTENT_WIDTH, APP_VISIBLE_HEIGHT) collectionViewLayout:flowLayout];
    _smartScentCollectionView.backgroundColor = [UIColor clearColor];
    _smartScentCollectionView.dataSource = self;
    _smartScentCollectionView.delegate = self;
    _smartScentCollectionView.contentInset = UIEdgeInsetsMake(10, 10, 10, 10);
    [_smartScentCollectionView registerClass:[TYBackgroundCollectionViewCell class] forCellWithReuseIdentifier:kSmartSceneItemCollectionID];
    
    [self.view addSubview:_smartScentCollectionView];
}

- (void)getBackgroundList {
    
    [self showProgressView:NSLocalizedString(@"loading", @"")];
    WEAKSELF_AT
    [self.request requestWithApiName:@"tuya.m.linkage.res.cover.list" postData:nil version:@"1.0" success:^(NSArray *result) {
        [weakSelf_AT hideProgressView];
        weakSelf_AT.dataArray  = result;
        [weakSelf_AT.smartScentCollectionView reloadData];
    } failure:^(NSError *error) {
        [weakSelf_AT hideProgressView];
        [TPProgressUtils showError:error.localizedDescription];
    }];
}

- (TuyaSmartRequest *)request {
    if (!_request) {
        _request = [TuyaSmartRequest new];
    }
    return _request;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TYBackgroundCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kSmartSceneItemCollectionID forIndexPath:indexPath];
    NSString *url = _dataArray[indexPath.row];
    [cell.innerImageView sd_setImageWithURL:[NSURL URLWithString:url]];
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *url = _dataArray[indexPath.row];
    if (self.selectedImageBlock) {
        self.selectedImageBlock(url);
    }
    [self.navigationController popViewControllerAnimated:YES];
}


@end
