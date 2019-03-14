//
//  TYApiMergeModel.h
//  TuyaSmartKit
//
//  Created by 冯晓 on 2017/4/12.
//  Copyright © 2017年 Tuya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TYApiMergeModel : NSObject

@property (nonatomic, assign) BOOL      success;

@property (nonatomic, strong) NSString  *apiName;

@property (nonatomic, strong) NSError   *error;

@property (nonatomic, strong) id        result;

@property (nonatomic, assign) NSTimeInterval time;

@end
