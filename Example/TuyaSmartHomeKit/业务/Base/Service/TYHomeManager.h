//
//  TYHomeManager.h
//  TuyaSmartKitExample
//
//  Created by XuChengcheng on 2018/1/3.
//  Copyright © 2018年 tuya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TYHomeManager : NSObject

TP_SINGLETON(TYHomeManager)

@property (nonatomic, strong) TuyaSmartHome *home;

@end
