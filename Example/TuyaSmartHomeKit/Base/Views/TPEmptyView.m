//
//  TPEmptyView.m
//  TuyaSmart
//
//  Created by fengyu on 15/9/11.
//  Copyright (c) 2015年 TP. All rights reserved.
//

#import "TPEmptyView.h"

@interface TPEmptyView()

@property (nonatomic, strong) UILabel *subTitleLabel;

@end

@implementation TPEmptyView

#pragma mark - Style1

- (id)initWithFrame:(CGRect)frame title:(NSString *)title imageName:(NSString *)imageName {
    
    if (self = [super initWithFrame:frame]) {
        [self addEmptyView:title imageName:imageName];
    }
    return self;
}

- (void)addEmptyView:(NSString *)title imageName:(NSString *)imageName {
    
    if (imageName.length == 0) {
        imageName = @"tp_nolist_logo.png";
    }
    
    UIImageView *emptyImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    emptyImageView.left = (self.width - emptyImageView.width)/2.f;
    [self addSubview:emptyImageView];
    
    UILabel *titleLabel = [TPViewUtil labelWithFrame:CGRectMake(0, emptyImageView.bottom + 20, self.width, 0) fontSize:12 color:HEXCOLOR(0x8A8E91)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = title;
    titleLabel.alpha = 0.5;
    titleLabel.numberOfLines = 0;
    
    NSDictionary *attr = @{NSFontAttributeName:[UIFont systemFontOfSize:12]};
    CGRect rect = [titleLabel.text boundingRectWithSize:CGSizeMake(titleLabel.width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil];
    titleLabel.height = rect.size.height;
    
    [self addSubview:titleLabel];
    
    _titleLabel = titleLabel;
    
    emptyImageView.top = (self.height - titleLabel.bottom) / 2.f - 64;
    titleLabel.top = emptyImageView.bottom + 20;
}

- (void)setTitle:(NSString *)title {
    _titleLabel.text = title;
    
    NSDictionary *attr = @{NSFontAttributeName:[UIFont systemFontOfSize:12]};
    CGRect rect = [_titleLabel.text boundingRectWithSize:CGSizeMake(_titleLabel.width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil];
    _titleLabel.height = rect.size.height;
    
}


#pragma mark - Style2

- (id)initWithFrame:(CGRect)frame title:(NSString *)title subTitle:(NSString *)subTitle {
    if (self = [super initWithFrame:frame]) {
        
        UILabel *titleLabel = [TPViewUtil simpleLabel:CGRectMake(0, 0, self.width, 33) bf:24 tc:HEXCOLOR(0x303030) t:title];
        titleLabel.numberOfLines = 1;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:titleLabel];
        
        
        UILabel *subTitleLabel = [TPViewUtil simpleLabel:CGRectMake(0, titleLabel.bottom + 16, self.width, 0) f:12 tc:HEXCOLOR(0x8A8E91) t:subTitle];
        subTitleLabel.textAlignment = NSTextAlignmentCenter;
        subTitleLabel.alpha = 0.5;
        subTitleLabel.numberOfLines = 0;
        
        NSDictionary *attr = @{NSFontAttributeName:[UIFont systemFontOfSize:12]};
        CGRect rect = [subTitleLabel.text boundingRectWithSize:CGSizeMake(subTitleLabel.width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil];
        subTitleLabel.height = rect.size.height;
        
        [self addSubview:subTitleLabel];
        
        titleLabel.top = (self.height - subTitleLabel.bottom)/2.f - 64;
        subTitleLabel.top = titleLabel.bottom + 16;
        
        _titleLabel = titleLabel;
        _subTitleLabel = subTitleLabel;
        
    }
    return self;
}

- (void)setTitle:(NSString *)title subTitle:(NSString *)subTitle {
    _titleLabel.text = title;
    _subTitleLabel.text = subTitle;
    
    
    NSDictionary *attr = @{NSFontAttributeName:[UIFont systemFontOfSize:12]};
    CGRect rect = [_subTitleLabel.text boundingRectWithSize:CGSizeMake(_subTitleLabel.width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil];
    _subTitleLabel.height = rect.size.height;
    
}

@end
