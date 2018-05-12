//
//  TYResult.h
//  Pods
//
//  Created by 黄凯 on 2018/4/16.
//

#import <Foundation/Foundation.h>

@interface TYResult : NSObject

typedef void(^TYBLECompletion)(TYResult *result);

@property (nonatomic, strong) id data;

@property (nonatomic, assign) BOOL isSuccess;

@property (nonatomic, assign) NSError *error;

@end
