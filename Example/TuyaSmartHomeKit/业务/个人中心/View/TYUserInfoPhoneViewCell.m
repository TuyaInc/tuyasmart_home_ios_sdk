//
//  TYUserInfoPhoneViewCell.m
//  TuyaSmartPublic
//
//  Created by 高森 on 16/5/16.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TYUserInfoPhoneViewCell.h"

@interface TYUserInfoPhoneViewCell()

@property (nonatomic, strong) UIImageView *arrowImageView;

@end


@implementation TYUserInfoPhoneViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.backgroundColor = LIST_BACKGROUND_COLOR;
    
    UILabel *label = [TPViewUtil labelWithFrame:CGRectMake(15, 15, 110, 20) fontSize:15 color:LIST_MAIN_TEXT_COLOR];
    label.text = NSLocalizedString(@"phone_number", @"");
    [self.contentView addSubview:label];
    
    _arrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell_view_arrow"]];
    _arrowImageView.centerY = label.centerY;
    _arrowImageView.right = APP_SCREEN_WIDTH - 20;
    [self.contentView addSubview:_arrowImageView];
    
    _rightLabel = [TPViewUtil labelWithFrame:CGRectMake(15, 15, 200, 20) fontSize:15 color:LIST_LIGHT_TEXT_COLOR];
    _rightLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_rightLabel];
    
    return self;
}

- (void)setPhoneNumber:(NSString *)phone showArrow:(BOOL)showArrow {
    _arrowImageView.hidden = !showArrow;
    
    if (phone.length > 0) {
        _rightLabel.textColor = LIST_LIGHT_TEXT_COLOR;
        _rightLabel.text = phone;
        
        if (showArrow) {
            _rightLabel.right = _arrowImageView.left - 15;
        } else {
            _rightLabel.right = APP_SCREEN_WIDTH - 20;
        }
        
        
    } else {
        if (showArrow) {
            _rightLabel.right = _arrowImageView.left - 15;
        } else {
            _rightLabel.right = APP_SCREEN_WIDTH - 20;
        }
        
        _rightLabel.textColor = HEXCOLOR(0xff4800);
        _rightLabel.text = NSLocalizedString(@"never_bind", @"");
    }
}

@end
