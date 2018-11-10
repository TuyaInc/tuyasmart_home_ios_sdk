//
//  TYHomeBLEActivatorTableViewCell.h
//  TYActivatorModule
//
//  Created by 黄凯 on 2018/4/24.
//

#import <UIKit/UIKit.h>
#import "TYBLEActivatorCell.h"

@interface TYHomeBLEActivatorTableViewCell : UITableViewCell

@property (nonatomic, strong) UIButton *activeButton;

@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, assign) id<TYBLEActivatorCellDelegate> delegate;

- (void)updateState:(BOOL)canBind;

@end
