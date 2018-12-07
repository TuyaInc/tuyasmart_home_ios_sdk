//
//  TYPanelBoolViewCell.m
//  TuyaSmartKitDemo
//
//  Created by 冯晓 on 16/8/27.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TYPanelBoolViewCell.h"
#import "TYPanelDpTitleView.h"

@interface TYPanelBoolViewCell()

@end

@implementation TYPanelBoolViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        _switchButton = [[UISwitch alloc] initWithFrame:CGRectMake(0, (self.bgView.height - 36)/2, 51, 36)];
        _switchButton.right = APP_CONTENT_WIDTH - 15;
        [self.bgView addSubview:_switchButton];
        
    }
    return self;
}

@end
