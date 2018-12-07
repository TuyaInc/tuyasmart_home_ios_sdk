//
//  TYPanelValueViewCell.h
//  TuyaSmartKitDemo
//
//  Created by 冯晓 on 16/8/27.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TYPanelBaseViewCell.h"


@interface TYPanelValueViewCell : TYPanelBaseViewCell

@property (nonatomic, strong) UIButton  *minButton;
@property (nonatomic, strong) UIButton  *plusButton;

@property (nonatomic, strong) UILabel   *titleLabel;

@end
