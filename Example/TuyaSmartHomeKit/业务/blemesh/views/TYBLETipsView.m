//
//  TYBLETipsView.m
//  TuyaSmartPublic
//
//  Created by 高森 on 16/9/13.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TYBLETipsView.h"

@implementation TYBLETipsView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UIView *view = [[UIView alloc] initWithFrame:frame];
        view.backgroundColor = HEXCOLORA(0x000000, 0.6);
        [view addGestureRecognizer:[TPViewUtil singleFingerClickRecognizer:self sel:@selector(hide)]];
        [self addSubview:view];
        
//        UIImage *image = [TPUtils imageNamedLocalize:@"Activator.bundle/ty_device_bletip"];
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.center = self.center;
        imageView.userInteractionEnabled = YES;
        [self addSubview:imageView];
        
        UIButton *button = [TPViewUtil buttonWithFrame:CGRectMake(imageView.left + 20, imageView.bottom - 35 - 18, imageView.width - 40, 35) fontSize:16 bgColor:HEXCOLOR(0xF5A623) textColor:HEXCOLOR(0xFFFFFF)];
        [button setTitle:NSLocalizedString(@"cancel_tip", @"") forState:UIControlStateNormal];
        [button addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        self.alpha = 0;
    }
    return self;
}

- (void)show {
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 1;
    }];
}

- (void)hide {
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 0;
    }];
}

@end
