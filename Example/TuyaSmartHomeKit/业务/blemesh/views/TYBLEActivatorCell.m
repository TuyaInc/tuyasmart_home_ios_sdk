//
//  TYBLEActivatorCell.m
//  TuyaSmartPublic
//
//  Created by 冯晓 on 16/8/14.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TYBLEActivatorCell.h"

@interface TYBLEActivatorCell()

@property (nonatomic, strong) UILabel *textlLabel;
@property (nonatomic, strong) UILabel *addLabel;
@property (nonatomic, strong) NSIndexPath *indexPath;

@end

@implementation TYBLEActivatorCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor whiteColor];

        [self.contentView addSubview:self.textLabel];
        
        [self.contentView addSubview:self.addLabel];
    }
    return self;
}

- (UILabel *)addLabel {
    if (!_addLabel) {
        _addLabel = [TPViewUtil simpleLabel:CGRectMake(APP_CONTENT_WIDTH - 40 - 20, 0, 40, 48) f:16 tc:HEXCOLOR(0x178BFE) t:NSLocalizedString(@"ty_ec_find_add_device", nil)];
        _addLabel.textAlignment = NSTextAlignmentRight;
        _addLabel.userInteractionEnabled = YES;
    
        
        WEAKSELF_AT
        [_addLabel bk_whenTapped:^{
            
            if (weakSelf_AT.delegate && [weakSelf_AT.delegate respondsToSelector:@selector(activeDevice:)]) {
                [weakSelf_AT.delegate activeDevice:weakSelf_AT.indexPath];
            }
            
        }];
        
    }
    return _addLabel;
}

- (UILabel *)textLabel {
    if (!_textlLabel) {
        _textlLabel = [TPViewUtil simpleLabel:CGRectMake(15, 0, APP_CONTENT_WIDTH - 15 - 15 - 28, 48) f:16 tc:LIST_MAIN_TEXT_COLOR t:@""];
    }
    return _textlLabel;
}

- (void)setItem:(NSIndexPath *)indexPath name:(NSString *)name {
    _indexPath = indexPath;
    
    _textlLabel.text = name;
}

@end
