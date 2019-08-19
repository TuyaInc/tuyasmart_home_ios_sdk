//
//  TYWidgetDeviceModel.m
//  TuyaWidget
//
//  Created by lan on 2018/9/11.
//  Copyright © 2018年 Tuya. All rights reserved.
//

#import "TYWidgetDeviceModel.h"
#import "YYModel.h"

@interface TYWidgetDeviceModel()
@property (nonatomic, strong) id target;
@end

@implementation TYWidgetDeviceModel

+ (NSMutableArray *)deviceModelListWithHome:(TuyaSmartHome *)home {
    NSMutableArray *deviceList = [NSMutableArray array];
    if (!home) {
        return deviceList;
    }
    
    for (TuyaSmartGroupModel *group in home.groupList) {
        TYWidgetDeviceModel *widgetModle = [[TYWidgetDeviceModel alloc] initWithModel:group];
        
        if (widgetModle.dpId) {
            [deviceList addObject:widgetModle];
        }
    }
    
    for (TuyaSmartDeviceModel *device in home.deviceList) {
        TYWidgetDeviceModel *widgetModle = [[TYWidgetDeviceModel alloc] initWithModel:device];
        
        if (widgetModle.dpId && widgetModle.isOnline) {
            [deviceList addObject:widgetModle];
        }
    }
    
    for (TuyaSmartGroupModel *group in home.sharedGroupList) {
        TYWidgetDeviceModel *widgetModle = [[TYWidgetDeviceModel alloc] initWithModel:group];
        
        if (widgetModle.dpId) {
            [deviceList addObject:widgetModle];
        }
    }
    
    for (TuyaSmartDeviceModel *device in home.sharedDeviceList) {
        TYWidgetDeviceModel *widgetModle = [[TYWidgetDeviceModel alloc] initWithModel:device];
        
        if (widgetModle.dpId && widgetModle.isOnline) {
            [deviceList addObject:widgetModle];
        }
    }
    
    return deviceList;
}

- (instancetype)initWithModel:(id)model {
    if (self=[super init]) {
        if ([model isKindOfClass:[TuyaSmartGroupModel class]]) {
            [self _initWithGroup:model];
        } else if ([model isKindOfClass:[TuyaSmartDeviceModel class]]){
            [self _initWithDevice:model];
        }
    }
    return self;
}

- (void)switchStatus {
    if (!self.isOnline) return;
    
    [self.target publishDps:@{self.dpId: [NSNumber numberWithBool:!self.dpValue]} success:^{
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)_initWithGroup:(TuyaSmartGroupModel *)groupModel {
    
    TuyaSmartDeviceModel *deviceModel = [TuyaSmartDeviceModel yy_modelWithJSON:groupModel.productInfo];
    
    NSString *dpId = [self _toString:deviceModel.switchDp];
    if (dpId.length) {
        self.dpId = dpId;
        self.dpValue = [[groupModel.dps objectForKey:self.dpId] boolValue];
    }
    self.deviceName = groupModel.name;
    self.deviceIcon = groupModel.iconUrl;
    self.isOnline = YES;
    self.target = [TuyaSmartGroup groupWithGroupId:groupModel.groupId];
}

- (void)_initWithDevice:(TuyaSmartDeviceModel *)deviceModel {
    NSString *dpId = [self _toString:deviceModel.switchDp];
    if (dpId.length) {
        self.dpId = dpId;
        self.dpValue = [[deviceModel.dps objectForKey:self.dpId] boolValue];
    }
    self.deviceName = deviceModel.name;
    self.deviceIcon = deviceModel.iconUrl;
    self.isOnline = deviceModel.isOnline;
    self.target = [TuyaSmartDevice deviceWithDeviceId:deviceModel.devId];
}

- (NSString *)_toString:(NSString *)string {
    if ([string isKindOfClass:[NSString class]]) {
        return string;
    } else {
        return [NSString stringWithFormat:@"%@",string];
    }
}
@end
