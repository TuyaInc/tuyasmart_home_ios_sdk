//
//  TYPanelBaseViewCell.m
//  TuyaSmartKitDemo
//
//  Created by 冯晓 on 16/8/27.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TYPanelBaseViewCell.h"


@implementation TYPanelBaseViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = NO;
        self.contentView.backgroundColor = MAIN_BACKGROUND_COLOR;
        
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, APP_CONTENT_WIDTH, 64)];
        _bgView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_bgView];
        
        
        _titleView = [[TYPanelDpTitleView alloc] initWithFrame:CGRectMake(0, 0, APP_CONTENT_WIDTH / 2 , 64)];
        [_bgView addSubview:_titleView];
        
    }
    return self;
}

@end


