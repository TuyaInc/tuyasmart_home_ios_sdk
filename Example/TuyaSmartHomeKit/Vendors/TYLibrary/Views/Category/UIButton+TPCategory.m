//
//  UIButton+ATCategory.m
//  TuyaSmart
//
//  Created by 冯晓 on 15/12/4.
//  Copyright © 2015年 Tuya. All rights reserved.
//

#import "UIButton+TPCategory.h"

@implementation UIButton (TPCategory)

- (void)tp_centerImageAndTitle:(float)spacing {
    // get the size of the elements here for readability
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    
    // get the height they will take up as a unit
    CGFloat totalHeight = (imageSize.height + titleSize.height + spacing);
    
    // raise the image and push it right to center it
    self.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height), 0.0, 0.0, - titleSize.width);
    
    // lower the text and push it left to center it
    self.titleEdgeInsets = UIEdgeInsetsMake(0.0, - imageSize.width, - (totalHeight - titleSize.height),0.0);
}

@end
