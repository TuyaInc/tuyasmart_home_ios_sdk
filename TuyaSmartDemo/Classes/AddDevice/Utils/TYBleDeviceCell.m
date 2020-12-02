//
//  TYBleDeviceCell.m
//  TuyaSmartHomeKit_Example
//
//  Created by milong on 2020/8/5.
//  Copyright © 2020 xuchengcheng. All rights reserved.
//

#import "TYBleDeviceCell.h"



@implementation TYBleDeviceCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.multipleSelectionBackgroundView = [UIView new];
        self.tintColor = [UIColor grayColor];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    for (UIControl *control in self.subviews){
        if ([control isMemberOfClass:NSClassFromString(@"UITableViewCellEditControl")]){
            for (UIView *v in control.subviews)  {
                if ([v isKindOfClass: [UIImageView class]]) {
                    UIImageView *img=(UIImageView *)v;
                    if (self.selected) {
                        img.image=[UIImage imageNamed:@"selected_icon"];
                    }else
                    {
                        img.image=[UIImage imageNamed:@"noSelected_icon"];
                    }
                }
            }
        }
    }
    
}


- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    for (UIControl *control in self.subviews){
        if ([control isMemberOfClass:NSClassFromString(@"UITableViewCellEditControl")]){
            for (UIView *v in control.subviews)
            {
                if ([v isKindOfClass: [UIImageView class]]) {
                    UIImageView *img=(UIImageView *)v;
                    if (!self.selected) {
                        img.image=[UIImage imageNamed:@"noSelected_icon"];
                    }
                }
            }
        }
    }
    
}

@end
