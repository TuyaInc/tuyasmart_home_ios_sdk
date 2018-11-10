//
//  TYHomeBLEActivatorTableViewCell.m
//  TYActivatorModule
//
//  Created by 黄凯 on 2018/4/24.
//

#import "TYHomeBLEActivatorTableViewCell.h"

@implementation TYHomeBLEActivatorTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.activeButton = [[UIButton alloc] initWithFrame:CGRectMake(APP_SCREEN_WIDTH - 56 - 16, 14, 66, 32)];
        [_activeButton.titleLabel sizeToFit];
        [_activeButton setTitle:@"active" forState:UIControlStateNormal];
        [_activeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _activeButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        _activeButton.layer.cornerRadius = 4.0;
        _activeButton.layer.masksToBounds = YES;
        [_activeButton addTarget:self action:@selector(didClickButton) forControlEvents:UIControlEventTouchUpInside];
        self.accessoryView = _activeButton;
    }
    
    return self;
}

- (void)updateState:(BOOL)canBind {
//        _activeButton.enabled = YES;
//        [_activeButton setBackgroundImage:[TPUtils imageWithColor:RGBCOLOR(255, 72, 0)] forState:UIControlStateNormal];
//        [_activeButton setTitle:@"active" forState:UIControlStateNormal];
//        [_activeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        _activeButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
//        _activeButton.layer.borderColor = [UIColor clearColor].CGColor;
//        _activeButton.layer.borderWidth = 0;
}

- (void)didClickButton {
    if ([self.delegate respondsToSelector:@selector(activeDevice:)]) {
        [self.delegate activeDevice:self.indexPath];
    }
}

@end
