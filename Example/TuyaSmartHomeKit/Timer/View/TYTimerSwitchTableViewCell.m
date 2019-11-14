//
//  TYTimerSwitchTableViewCell.m
//  TuyaSmartHomeKit_Example
//
//  Created by Sakata Gintoki on 2019/11/13.
//  Copyright © 2019 xuchengcheng. All rights reserved.
//

#import "TYTimerSwitchTableViewCell.h"

@interface TYTimerSwitchTableViewCell ()

@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) UISwitch *switchButton;
@end

@implementation TYTimerSwitchTableViewCell

+ (CGFloat)cellHeight {
    return 44;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.leftLabel = [UILabel new];
        self.leftLabel.font = [UIFont systemFontOfSize:17];
        self.leftLabel.textColor =  TY_HexColor(0x22242c);
        self.leftLabel.frame = CGRectMake(15, 0, 300, [[self class] cellHeight]);
        self.leftLabel.text = @"Notification";
        [self.contentView addSubview:self.leftLabel];
        self.switchButton = [UISwitch new];
        self.switchButton.frame = CGRectMake(TY_ScreenWidth() - 15 - self.switchButton.width, ([[self class] cellHeight] - self.switchButton.height)/2, self.switchButton.width, self.switchButton.height);
        [self.switchButton addTarget:self action:@selector(switchChanged) forControlEvents:UIControlEventValueChanged];
        [self.contentView addSubview:self.switchButton];
    }
    return self;
}

- (void)switchChanged {
    if (self.switchBlock) {
        self.switchBlock(self.switchButton.isOn);
    }
}

- (void)setOn:(BOOL)on {
    [self.switchButton setOn:on];
}

@end
