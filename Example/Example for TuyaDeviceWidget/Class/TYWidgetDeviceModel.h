//
//  TYWidgetDeviceModel.h
//  TuyaWidget
//
//  Created by lan on 2018/9/11.
//  Copyright © 2018年 Tuya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TYWidgetDeviceModel : NSObject
@property (nonatomic, strong) NSString *deviceName;
@property (nonatomic, strong) NSString *deviceIcon;
@property (nonatomic, assign) BOOL isOnline;

@property (nonatomic, strong) NSString *dpId;
@property (nonatomic, assign) BOOL dpValue;

+ (NSMutableArray *)deviceModelListWithHome:(TuyaSmartHome *)home;

- (instancetype)initWithModel:(id)model;

- (void)switchStatus;
@end
