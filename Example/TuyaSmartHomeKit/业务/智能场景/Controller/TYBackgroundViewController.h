//
//  TYBackgroundViewController.h
//  TuyaSmartHomeKit_Example
//
//  Created by XuChengcheng on 2018/6/8.
//  Copyright © 2018年 xuchengcheng. All rights reserved.
//

#import "TPBaseViewController.h"

typedef void (^SelectedImageBlock)(NSString *url);

@interface TYBackgroundViewController : TPBaseViewController

@property (nonatomic, copy) SelectedImageBlock selectedImageBlock;

@end
