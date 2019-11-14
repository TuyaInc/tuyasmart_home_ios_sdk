//
//  TYTimerCommonTableViewCell.m
//  TuyaSmartHomeKit_Example
//
//  Created by Sakata Gintoki on 2019/11/13.
//  Copyright © 2019 xuchengcheng. All rights reserved.
//

#import "TYTimerCommonTableViewCell.h"

@interface TYTimerCommonTableViewCell ()
@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) UILabel *rightLabel;
@property (nonatomic, strong) UIImageView *rightArrow;
@end

@implementation TYTimerCommonTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.leftLabel = [UILabel new];
        self.leftLabel.font = [UIFont systemFontOfSize:17];
        self.leftLabel.textColor =  TY_HexColor(0x22242c);
        self.leftLabel.numberOfLines = 0;
        [self.contentView addSubview:self.leftLabel];
        self.rightLabel = [UILabel new];
        self.rightLabel.font = [UIFont systemFontOfSize:15];
        self.rightLabel.textColor = TY_HexColor(0xa2a3aa);
        self.rightLabel.numberOfLines = 0;
        [self.contentView addSubview:self.rightLabel];
        self.rightArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell_view_arrow"]];
        [self.contentView addSubview:self.rightArrow];
    }
    return self;
}

- (CGFloat)cellHeightWithLeft:(NSString *)left right:(NSString *)right {
    left = left?:@"";
    right = right?:@"";
    CGSize leftSize = [left ty_boundingSizeWithFont:self.leftLabel.font constrainedToSize:CGSizeMake(2000, 22) lineBreakMode:NSLineBreakByWordWrapping];
    CGSize rightSize = [right ty_boundingSizeWithFont:self.rightLabel.font constrainedToSize:CGSizeMake(2000, 22) lineBreakMode:NSLineBreakByWordWrapping];
    CGFloat maxWidth = TY_ScreenWidth() - leftSize.width - 80;
    if (rightSize.width > maxWidth) {
        CGSize newLeftSize = [left ty_boundingSizeWithFont:self.rightLabel.font constrainedToSize:CGSizeMake(TY_ScreenWidth() - 80, 20000) lineBreakMode:NSLineBreakByWordWrapping];
        CGSize newRightSize = [right ty_boundingSizeWithFont:self.rightLabel.font constrainedToSize:CGSizeMake(TY_ScreenWidth() - 80, 20000) lineBreakMode:NSLineBreakByWordWrapping];
        return (44 - leftSize.height)*1.5 + newLeftSize.height + newRightSize.height;
    }
    return 44;
}

- (void)setDataWithLeft:(NSString *)leftText rightText:(NSString *)rightText {
    
    self.leftLabel.text = leftText;
    self.rightLabel.text = rightText;
    CGFloat height = [self cellHeightWithLeft:leftText right:rightText];
    self.rightArrow.frame = CGRectMake(TY_ScreenWidth() - 15 - self.rightArrow.size.width, (height - self.rightArrow.height)/2, self.rightArrow.width, self.rightArrow.height);
    if (height == 44) {
        CGSize leftSize = [leftText ty_boundingSizeWithFont:self.leftLabel.font constrainedToSize:CGSizeMake(2000, 22) lineBreakMode:NSLineBreakByWordWrapping];
        CGSize rightSize = [rightText ty_boundingSizeWithFont:self.rightLabel.font constrainedToSize:CGSizeMake(2000, 22) lineBreakMode:NSLineBreakByWordWrapping];
        self.leftLabel.frame = CGRectMake(15, (44 - leftSize.height)/2, leftSize.width, leftSize.height);
        self.rightLabel.textAlignment = NSTextAlignmentRight;
        self.rightLabel.frame = CGRectMake(CGRectGetMaxX(self.leftLabel.frame), (height - rightSize.height)/2, TY_ScreenWidth() - CGRectGetMaxX(self.leftLabel.frame) - self.rightArrow.width - 25, rightSize.height);
    } else {
        CGSize leftSize = [leftText ty_boundingSizeWithFont:self.leftLabel.font constrainedToSize:CGSizeMake(2000, 22) lineBreakMode:NSLineBreakByWordWrapping];
        CGSize newLeftSize = [leftText ty_boundingSizeWithFont:self.rightLabel.font constrainedToSize:CGSizeMake(TY_ScreenWidth() - 80, 20000) lineBreakMode:NSLineBreakByWordWrapping];
        CGSize newRightSize = [rightText ty_boundingSizeWithFont:self.rightLabel.font constrainedToSize:CGSizeMake(TY_ScreenWidth() - 80, 20000) lineBreakMode:NSLineBreakByWordWrapping];
        self.leftLabel.frame = CGRectMake(15, (44 - leftSize.height)/2, TY_ScreenWidth() - 80, newLeftSize.height);
        self.rightLabel.textAlignment = NSTextAlignmentLeft;
        self.rightLabel.frame = CGRectMake(15, (44 - leftSize.height) + newLeftSize.height, newRightSize.width, newRightSize.height);
    }
}

@end
