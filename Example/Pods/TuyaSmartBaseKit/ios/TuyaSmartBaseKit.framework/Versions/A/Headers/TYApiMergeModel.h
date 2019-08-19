//
//  TYApiMergeModel.h
//  TuyaSmartKit
//
//  Created by 冯晓 on 2017/4/12.
//  Copyright © 2017年 Tuya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TYApiMergeModel : NSObject


/**
 success
 */
@property (nonatomic, assign) BOOL      success;


/**
 api name
 */
@property (nonatomic, strong) NSString  *apiName;


/**
 error
 */
@property (nonatomic, strong) NSError   *error;


/**
 response result
 */
@property (nonatomic, strong) id        result;


/**
 timestamp
 */
@property (nonatomic, assign) NSTimeInterval time;

@end
