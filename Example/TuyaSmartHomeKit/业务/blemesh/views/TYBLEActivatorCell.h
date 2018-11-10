//
//  TYBLEActivatorCell.h
//  TuyaSmartPublic
//
//  Created by 冯晓 on 16/8/14.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TYBLEActivatorCellDelegate <NSObject>

- (void)activeDevice:(NSIndexPath *)indexPath;

@end
@interface TYBLEActivatorCell : UITableViewCell


@property (nonatomic, weak) id <TYBLEActivatorCellDelegate> delegate;

- (void)setItem:(NSIndexPath *)indexPath name:(NSString *)name;

@end
