//
//  TPNavigationController.h
//  TYLibraryExample
//
//  Created by 冯晓 on 16/2/18.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TPNavigationController : UINavigationController


/**
 *  viewWillDisappear中调用 启用手势返回
 */
- (void)enablePopGesture;

/**
 *  viewWillAppear中调用 禁用手势返回
 */
- (void)disablePopGesture;

@end
