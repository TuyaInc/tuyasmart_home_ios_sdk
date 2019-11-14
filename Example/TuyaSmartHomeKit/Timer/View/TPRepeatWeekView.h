//
//  TPRepeatWeekView.h
//  TuyaSmart
//
//  Created by fengyu on 15/3/4.
//  Copyright (c) 2015年 Tuya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TPRepeatWeekView : UIView

@property(nonatomic) BOOL isSelected;

-(id)initWithFrame:(CGRect)frame weekDay:(NSInteger)weekDay;
-(void)setSelected:(BOOL)selected;

@end
