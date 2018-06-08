//
//  TYBaseLayout.m
//  TuyaSmart
//
//  Created by 冯晓 on 16/1/4.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TPBaseLayout.h"
#import "TPUtils.h"
#import "TPViewConstants.h"

@interface TPBaseLayout()

@end

@implementation TPBaseLayout

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.frame = CGRectMake(0, 0, APP_CONTENT_WIDTH, APP_SCREEN_HEIGHT);
    }
    return self;
}

- (TPTopBarView *)topBarView {
    if (!_topBarView) {
        _topBarView                 = [[TPTopBarView alloc] init];

        _topBarView.leftItem        = [TPBarButtonItem backItem:self action:@selector(leftItemTap)];
        _topBarView.centerItem      = [TPBarButtonItem titleItem:@"" target:self action:@selector(centerItemTap)];
        _topBarView.rightItem       = [TPBarButtonItem titleItem:@"" target:self action:@selector(rightItemTap)];
        _topBarView.bottomLineHidden = NO;
    }
    return _topBarView;
}

- (void)reloadData {}

- (void)leftItemTap {
    if ([self.topBarDelegate respondsToSelector:@selector(topBarLeftItemTap)]) {
        [self.topBarDelegate topBarLeftItemTap];
    } else {
        [tp_topMostViewController().navigationController popViewControllerAnimated:YES];
    }
}

- (void)centerItemTap {
    if ([self.topBarDelegate respondsToSelector:@selector(topBarCenterItemTap)]) {
        [self.topBarDelegate topBarCenterItemTap];
    }
}

- (void)rightItemTap {
    if ([self.topBarDelegate respondsToSelector:@selector(topBarRightItemTap)]) {
        [self.topBarDelegate topBarRightItemTap];
    } else {
        [tp_topMostViewController() dismissViewControllerAnimated:YES completion:nil];
    }
}


@end
