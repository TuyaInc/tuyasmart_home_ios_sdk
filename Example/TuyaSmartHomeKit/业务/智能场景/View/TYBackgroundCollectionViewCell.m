//
//  TYBackgroundCollectionViewCell.m
//  TuyaSmartHomeKit_Example
//
//  Created by 高森 on 2018/6/27.
//  Copyright © 2018年 xuchengcheng. All rights reserved.
//

#import "TYBackgroundCollectionViewCell.h"

@implementation TYBackgroundCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.innerImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self addSubview:self.innerImageView];
    }
    return self;
}

@end
