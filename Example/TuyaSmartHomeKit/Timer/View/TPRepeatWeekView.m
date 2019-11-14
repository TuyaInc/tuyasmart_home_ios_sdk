//
//  TPRepeatWeekView.m
//  TuyaSmart
//
//  Created by fengyu on 15/3/4.
//  Copyright (c) 2015年 Tuya. All rights reserved.
//

#import "TPRepeatWeekView.h"

@interface TPRepeatWeekView()

@property(nonatomic,strong) UIImageView *selectedImageView;

@end

@implementation TPRepeatWeekView

-(id)initWithFrame:(CGRect)frame weekDay:(NSInteger)weekDay {
    self = [super initWithFrame:frame];
    
    [self setBackgroundColor:[UIColor whiteColor]];
    
    UILabel *weekLabel = [UILabel ty_labelWithText:nil font:[UIFont systemFontOfSize:16] textColor:[UIColor ty_colorWithHex:0x1E1E1E] frame:CGRectMake(15, 14, TY_ScreenWidth() - 35 - 15 - 10, 16)];
    weekLabel.text = [@[
    NSLocalizedString(@"sunday", @""),
    NSLocalizedString(@"monday", @""),
    NSLocalizedString(@"tuesday", @""),
    NSLocalizedString(@"wednesday", @""),
    NSLocalizedString(@"thursday", @""),
    NSLocalizedString(@"friday", @""),
    NSLocalizedString(@"saturday", @"")] objectAtIndex:weekDay];
    [self addSubview:weekLabel];
    
    _selectedImageView = [[UIImageView alloc] initWithFrame:CGRectMake(TY_ScreenWidth() - 35, 17, 13, 10)];
    _selectedImageView.image = [UIImage imageNamed:@"tysmart_selected"];
    [self addSubview:_selectedImageView];
    
//    if (weekDay != 6) {
//        UIView *separator = [UIView new];
//        separator.frame = CGRectMake(15, frame.size.height - 0.5, frame.size.width - 15, 0.5);
//        separator.backgroundColor = SEPARATOR_LINE_COLOR;
//        [self addSubview:separator];
//    }
    
    [self setSelected:NO];

    return self;
}

-(void)setSelected:(BOOL)selected {
    _isSelected = selected;
    _selectedImageView.hidden = !selected;
}

@end
