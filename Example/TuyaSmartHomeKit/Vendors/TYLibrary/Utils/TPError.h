//
//  TPError.h
//  TYLibraryExample
//
//  Created by 冯晓 on 16/2/16.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TPError : NSObject

+ (void)registerErrorMap:(NSDictionary *)errorMap;

+ (NSError *)errorWithCodeString:(NSString *)codeString errorMsg:(NSString *)errorMsg;

+ (NSError *)errorWithErrorCode:(int)errorCode errorMsg:(NSString *)errorMsg;

@end

